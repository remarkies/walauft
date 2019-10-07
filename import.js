var moment = require('moment');
const https = require('https');
var contentful = require('contentful');
const contentfulM = require('contentful-management')


let url1 = "https://zuerich.usgang.ch/v1/events?date=";
let url2 = "&regionid=";

let checkDaysInAdvance = 20;
//2 : "Luzern", 3 : "Bern", 4 : "Basel", 5 : "St.Gallen", 6 : "Zürich"
let regions = ["2", "3", "4", "5", "6"];

let links = [];


let client = connectToContentful();
let clientM = connectToContentfulManagement();


for(let i = 0; i < checkDaysInAdvance; i++) {
  regions.forEach((region) => {
    let date = moment().add(i, 'days').format("YYYY-MM-DD");
    let link = url1 + date + url2 + region;
    links.push({url: link, id: region});
  });
}

links.forEach((url) => {
  downloadJsonFromUrl(url.url, url.id);
});

function downloadJsonFromUrl(url, region) {
  let req = https.get(url, function(res) {
    let data = '', json_data;

    res.on('data', function(stream) {
      data += stream;
    });


    res.on('end', function() {
      console.log("Data downloaded:");
      console.log(url);

      try {
        json_data = JSON.parse(data);
      } catch(e) {
        console.log("Json parsing error. Url:");
        console.log(url);
        return;
      }

      console.log("Json parsed!");

      console.log("Events found: " + json_data.items.length);

      for(let i = 0; i < json_data.items.length; i++) {
        let event = json_data.items[i];

        console.log("Region ID: " + region + " Event ID: " + event.id);

        handleEvent(event, region);
      }
    });
  });

  req.on('error', function(e) {
    console.log("Request caused an error: " + e.message);
  });
}


function connectToContentful() {
  let client;
  try {
    client = contentful.createClient({
      space: 'rq1gh35slude',
      accessToken: 'tq-9zxXuOyTJpiEXSAxg2waOG07mURBt7lJgoTBEPZs'
    });
  } catch(exception) {
    console.log("Could not connect to Contentful! Error: " + exception);
    client = null;
  } finally {
    return client;
  }
}

function connectToContentfulManagement() {
  let client;
  try {
    client = contentfulM.createClient({
      accessToken: 'CFPAT-RwIXTc0puQNDc3v1EyUye59pEOePrZopcR6moMAZEhc'
    });
  } catch(exception) {
    console.log("Could not connect to Contentful Management! Error: " + exception);
    client = null;
  } finally {
    return client;
  }
}

function handleEvent(event, region) {



  if(client !== null) {
    client.getEntries().then((response) => {
      console.log("Checking all entries for event id: " + event.id + "...");

      let entryId = null;
      response.items.forEach(item => {
        if(item.fields.json.id === event.id) {
          entryId = item.sys.id;
        }
      });

      return entryId;

    }).then((entryId) => {
      console.log("Result: " + entryId);
      if(entryId !== null) {
        console.log("Event id entry: " + entryId);
        updateEntry(entryId, event);
      } else {
        console.log("No entry found for event id: " + event.id);
        createEntry(event, region);
      }

    }).catch((error) => {
      console.log("Could not check if event: " + event.id +  " exists.");
      console.log("Error message: " + error);
    });
  }
}

function updateEntry(entryId, event) {
  try {
    if(clientM !== null) {
      clientM.getSpace('rq1gh35slude')
        .then((space) => space.getEnvironment('master'))
        .then((environment) => environment.getEntry(entryId))
        .then((entry) => {
          entry.fields.json['en-US'] = event;
          return entry.update();
        })
        .then((entry) => {
          entry.publish();
          console.log("Updated entry: " + event.id);
        });
    }

  } catch(exception) {
    console.log("Update entry error! Message: " + exception);
  }
}

function createEntry(event, region) {
  try {
    if(clientM !== null) {
      clientM.getSpace('rq1gh35slude')
      .then((space) => space.getEnvironment('master'))
      .then((environment) => environment.createEntry('event', {
        fields: {
          json : { 'en-US' : event },
          region : { 'en-US' : region }
        }
      }))
      .then((entry) => {
        entry.publish();
        console.log("Created entry: " + event.id);
      });
    }
  } catch(exception) {
    console.log("Create entry error! Message: " + exception);
  }
}








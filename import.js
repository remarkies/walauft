var moment = require('moment');
const https = require('https');
var contentful = require('contentful');
const contentfulM = require('contentful-management')


let url1 = "https://zuerich.usgang.ch/v1/events?date=";
let url2 = "&regionid=";

let checkDaysInAdvance = 10;
let regions = { 2 : "Luzern", 3 : "Bern", 4 : "Basel", 5 : "St.Gallen", 6 : "Zürich" };

for(let i = 0; i < checkDaysInAdvance; i++) {
  for(let region in regions) {
    let date = moment().add(i, 'days').format("YYYY-MM-DD");
    let url = url1 + date + url2 + region;

    downloadJsonFromUrl(url, region);
  }
}

function downloadJsonFromUrl(url, region) {
  let req = https.get(url, function(res) {
    let data = '',
      json_data;

    res.on('data', function(stream) {
      data += stream;
    });
    res.on('end', function() {
      json_data = JSON.parse(data);


      for(let i = 0; i < json_data.items.length; i++) {
        let event = json_data.items[i];

        pushEventToContentful(event, region);
      }
    });
  });

  req.on('error', function(e) {
    console.log(e.message);
  });
}

function pushEventToContentful(event, region) {

  var client = contentful.createClient({
    space: 'rq1gh35slude',
    accessToken: 'tq-9zxXuOyTJpiEXSAxg2waOG07mURBt7lJgoTBEPZs'
  });

  client.getEntries()
    .then((response) => {

      let exists = false;
      let entryId = "";
      for(let i = 0; i < response.items.length; i++) {
        let resItem = response.items[i];
        if(resItem.fields.json.id === event.id) {
          exists = true;
          entryId = resItem.sys.id;
        }
      }

      const clientM = contentfulM.createClient({
        accessToken: 'CFPAT-RwIXTc0puQNDc3v1EyUye59pEOePrZopcR6moMAZEhc'
      });

      if(exists) {
        //update entry
        clientM.getSpace('rq1gh35slude')
          .then((space) => space.getEnvironment('master'))
          .then((environment) => environment.getEntry(entryId))
          .then((entry) => {
            entry.fields.json['en-US'] = event
            return entry.update()
          })
          .then((entry) => { entry.publish().catch(console.error); console.log("updated entry: " + entry.sys.id); })
          .catch(console.error);
      } else {
        //create entry
        console.log("created entry...");

        clientM.getSpace('rq1gh35slude')
          .then((space) => space.getEnvironment('master'))
          .then((environment) => environment.createEntry('event', {
            fields: {
                json : { 'en-US' : event },
                region : { 'en-US' : region }
            }
          }))
          .then((entry) => { entry.publish().catch(console.error); console.log("created entry: " + entry.sys.id); })
          .catch(console.error);

      }

    })
    .catch(console.error);
}








let moment = require('moment');
require('dotenv').config()
const https = require('https');
let database = require('../services/database');
const NodeGeocoder = require('node-geocoder');
let url1 = "https://zuerich.usgang.ch/v1/events?date=";
let url2 = "&regionid=";
let url3 = "&limit=100";

var promise = Promise.resolve();


let checkDaysInAdvance = 30;

let regionsDic = {
    2 : "Luzern",
    3 : "Bern",
    4 : "Basel",
    5 : "St.Gallen",
    6 : "Zürich"
};

//2 : "Luzern", 3 : "Bern", 4 : "Basel", 5 : "St.Gallen", 6 : "Zürich"
let regions = ["2", "3", "4", "5", "6"];
//let regions = [ "4" ];

scratchData(regions);

async function scratchData(regions) {
    await database.connect(process.env.DB_LINK);
    console.log("INFO: Connected to Db")
    for (const region of regions) {
        let links = createLinks(region);

        for (const link of links) {
            let data = await importData(link);
            data = await searchForMissingLocations(data);
            data = await handleEvents(data);
            data = await handleTags(data);
        }
    }

    await database.close();
    console.log("INFO: Db connection closed");
}

function createLinks(region) {
    let links = [];

    for(let i = 0; i < checkDaysInAdvance; i++) {
        let date = moment()
            .add(-1, 'years')
            .add(i, 'days').hours(0).minutes(0).seconds(0).milliseconds(0).format("YYYY-MM-DD");
        let link = url1 + date + url2 + region + url3;
        links.push({url: link, id: region, date: date});
    }

    return links;
}
function importData(link) {
    return Promise.resolve(downloadEvents(link.url, link.id, link.date))
}
function downloadEvents(url, region, date) {
    return new Promise(function (resolve, reject) {
        let req = https.get(url, function(res) {

            let data = ''
            let json_data;

            res.on('data', function(stream) {
                data += stream;
            });

            res.on('end', function() {
                let result = {};
                result.date = moment(date).format('YYYYMMDD');
                result.region = region;
                result.events = [];
                try {

                    data = data.replace(/\\n/g, "\\n")
                        .replace(/\\'/g, "\\'")
                        .replace(/\\"/g, '\\"')
                        .replace(/\\&/g, "\\&")
                        .replace(/\\r/g, "\\r")
                        .replace(/\\t/g, "\\t")
                        .replace(/\\b/g, "\\b")
                        .replace(/\\f/g, "\\f");

                    // remove non-printable and other non-valid JSON chars
                    data = data.replace(/[\u0000-\u0019]+/g,"");

                    if(!data.includes("Service unavailable!")) {
                        json_data = JSON.parse(data);
                    } else {
                        throw new Error("Service unavailable!")
                    }
                } catch(e) {
                    console.log(url);
                    console.log(e);
                    resolve(result);
                    return;
                }

                console.log(date, regionsDic[region], json_data.items.length, url)


                json_data.items.forEach((eventItem) => {
                    let foundTags = [];

                    getTagsForStyle(eventItem.musicstyles).forEach(o => {
                       if(o.text.length > 0) {
                           foundTags.push(o);
                       }
                    });
                    getTagsForActs(eventItem.acts).forEach(o => {
                        if(o.text.length > 0) {
                            foundTags.push(o);
                        }
                    });

                    foundTags.push(getTagForLocation(eventItem.location.name));

                    eventItem.tags = foundTags;
                });
                json_data.items.forEach(item => {
                    let newEventItem = {
                        name: item.name,
                        date: item.date,
                        time: item.start,
                        tags: item.tags,
                        minage: item.minage,
                        price: item.price,
                        description: item.text,
                        location: {
                            name: item.location.name,
                            street: item.location.street,
                            streetNo: item.location.streetno,
                            zipCode: item.location.zipcode,
                            city: item.location.city,
                            longitude: item.location.longitude,
                            latitude: item.location.latitude
                        }
                    };
                    result.events.push(newEventItem);
                });

                resolve(result);
            });
        });

        req.on('error', function(e) {
            reject(e.message);
        });
    });
}
function searchForMissingLocations(result) {
    let promises = [];
    const options = {
        provider: 'google',

        // Optional depending on the providers
        //fetch: customFetchImplementation,
        apiKey: 'AIzaSyAaqSC_s0YO6-lkfimjjFN9lIL31plwu8A', // for Mapquest, OpenCage, Google Premier
        //formatter: null // 'gpx', 'string', ...
    };
    const geocoder = NodeGeocoder(options);
    for (const event of result.events) {
        if (event.location.longitude === "-1" || event.location.latitude === "-1") {
            promises.push(new Promise((resolve, reject) => {
                let search = event.location.street + " " + event.location.streetno + ", " + event.location.zipcode + " " + event.location.city;

                geocoder.geocode(search)
                    .then(loc => {
                        if (loc.length > 0) {
                            let foundLocation = loc[0];
                            event.location.latitude =  "" + foundLocation.latitude + "";
                            event.location.longitude = "" + foundLocation.longitude + "";
                        }
                        resolve();
                    })
                    .catch(error => {
                        console.log(error);
                        reject(error);
                    });
            }));
        }
    }

    return Promise.all(promises).then(() => {
        return result;
    });
}
async function handleEvents(result) {
    if (result.events.length > 0) {
        await database.upsert('events', {date: result.date, region: result.region}, result)
    }
    return result;
}
async function handleTags(result) {

    let tagsDoc = await database.find('tags', {"region" : result.region});

    if (tagsDoc.length === 0) {
        tagsDoc = {
            region: result.region,
            tags: []
        }
    } else {
        tagsDoc = tagsDoc[0];
    }

    result.events.forEach(event => {
        event.tags.forEach(tagOfEvent => {
            let existingTags = tagsDoc.tags.filter(o => o.text === tagOfEvent.text && o.type === tagOfEvent.type);
            if (existingTags.length > 0) {
                if (moment(existingTags[0].date) < moment(result.date)) {
                    existingTags[0].date = result.date;
                } else {
                }
            } else {
                tagsDoc.tags.push({
                    date: result.date,
                    text: tagOfEvent.text,
                    type: tagOfEvent.type
                });
            }
        });
    });

    return Promise.resolve(database.upsert('tags', { region: tagsDoc.region }, tagsDoc));
}

function getTagsForStyle(style) {
    let foundTags = [];
    if(style !== null) {
        let array = style.split(",").map(o => o.trim());

        array.forEach(o => {
           foundTags.push({
               type: "style",
               text: o
           });
        });
    }
    return foundTags;
}
function getTagsForActs(acts) {
    let foundTags = [];
    if(acts !== null) {
        acts = acts.replace("\r\n", ",");
        acts = acts.replace("\n", ",");
        acts = acts.replace("+", ",");
        acts = acts.replace("Live: ", "");
        acts = acts.replace("DJs", "");
        acts = acts.replace("DJ", "");
        acts = acts.replace("Div. DJs", "Irgendöper");
        acts = acts.replace("Div.Djs", "Irgendöper");
        acts = acts.replace("Diverse", "Irgendöper");
        let array = acts.split(",").map(o => o.trim());
        array.forEach(o => {
            foundTags.push({
                type: "act",
                text: o
            });
        });
    }
    return foundTags;
}
function getTagForLocation(location) {
    return {
        type: "location",
        text: location
    };
}




let moment = require('moment');
const https = require('https');
let database = require('../services/database');
const env = require('../environment')
let url1 = "https://zuerich.usgang.ch/v1/events?date=";
let url2 = "&regionid=";
let url3 = "&limit=100";

var promise = Promise.resolve();

var urlDB = env.database_prod;

let checkDaysInAdvance = 60;

let regionsDic = {
    2 : "Luzern",
    3 : "Bern",
    4 : "Basel",
    5 : "St.Gallen",
    6 : "Zürich"
};

//2 : "Luzern", 3 : "Bern", 4 : "Basel", 5 : "St.Gallen", 6 : "Zürich"
let regions = ["2", "3", "4", "5", "6"];

let links = [];

promise
    .then(function () {
        return database.connect(urlDB);
    })
    .then(importData)
    .then(handleEvents)
    .then(function () {
        database.close();
    });

function importData() {
    for(let i = 0; i < checkDaysInAdvance; i++) {
        regions.forEach((region) => {
            let date = moment().add(i, 'days').hours(0).minutes(0).seconds(0).milliseconds(0).format("YYYY-MM-DD");
            let link = url1 + date + url2 + region + url3;
            links.push({url: link, id: region, date: date});
        });
    }

    let downloadingPromises = [];

    links.forEach((url) => {
        downloadingPromises.push(downloadEvents(url.url, url.id, url.date));
    });

    return Promise.all(downloadingPromises);
}

function downloadEvents(url, region, date) {
    return new Promise(function (resolve, reject) {

        let req = https.get(url, function(res) {

            let data = '', json_data;

            res.on('data', function(stream) {
                data += stream;
            });


            res.on('end', function() {
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
                    return;
                }

                console.log(date, regionsDic[region], json_data.items.length, url)
                let result = {};
                result.date = moment(date).format('YYYYMMDD');
                result.region = region;
                result.events = json_data.items;

                resolve(result);
            });
        });

        req.on('error', function(e) {
            reject(e.message);
        });
    });
}

function handleEvents(results) {

    let handlingPromises = [];
    let progress = 0;
    console.log(results.length + " doc upserts to do.");

    let lastStep = 0;
    let stepsInPerc = 10;
    results.forEach(doc => {
        handlingPromises.push(database.upsert('events', { date:  doc.date, region: doc.region }, doc));
        progress++;
        let currentPerc = Math.round(100.00 / results.length * progress)

        if(currentPerc >= lastStep + stepsInPerc) {
            console.log("Updating... (" + currentPerc + "%)");
            lastStep += stepsInPerc;
        }

    });


    return Promise.all(handlingPromises).then(function () {
        console.log("Log: Data imported.");
    });
}


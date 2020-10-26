let moment = require('moment');
const https = require('https');
let database = require('../services/database');

var promise = Promise.resolve();
var urlDB = 'mongodb://localhost:27017/walauft';
urlDB = 'mongodb://server:Olgr3mJu1@walauftdb-shard-00-00-wysk3.mongodb.net:27017,walauftdb-shard-00-01-wysk3.mongodb.net:27017,walauftdb-shard-00-02-wysk3.mongodb.net:27017/walauftDB?ssl=true&replicaSet=walauftDB-shard-0&authSource=admin&retryWrites=true&w=majority';

promise
    .then(function () {
        return database.connect(urlDB);
    }).then(function() {


        database.find('events', {}, {}).then(function (docs) {

            console.log("Results found: " + docs.length);

            let genres = [];
            docs.forEach(o => {
                o.events.forEach(i => {

                    let styles = i.musicstyles.split(',');

                    styles.forEach(s => {

                        let newGenre = s.trimLeft().trimRight();

                        let exists = false;
                        genres.forEach(g => {
                            if(g === newGenre)
                                exists = true;
                        });
                        if(!exists) {
                            genres.push(newGenre);
                        }

                    });
                });
            });


            genres.forEach(x => {
                console.log(x);
            });
            //console.log(genres);

        });


});
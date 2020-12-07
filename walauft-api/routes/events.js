let express = require('express');
let moment = require('moment');
let database = require('../services/database');
let router = express.Router();

router.post('/:regionId/:today',function(request,response){

    let regionId = request.params.regionId;
    let today = request.params.today;

    let filter = {};
    if(today === "0") {
        filter = {
            $and: [
                { date: moment(new Date()).add(-10, 'hours').format('YYYYMMDD') },
                { region: regionId }
            ]
        };


        database.find('events',filter , { sort: 'date', limit: 100 })
            .then(function (docs) {
                response.json(docs);
            });
    } else if(today === "1") {
        filter = {
            $and: [
                { date: { $gt: moment(new Date()).add(-10, 'hours').format('YYYYMMDD') } },
                { region: regionId }
            ]
        };
        console.log(filter);

        database.find('events',filter , { sort: 'date', limit: 100 })
            .then(function (docs) {
                response.json(docs);
            });
    } else {
        response.json({
            message: "Wrong parameter!"
        });
    }

});

router.post('/:regionId',function(request,response){

    let regionId = request.params.regionId;

    let filter = {
        $and: [
            { date: { $gte: moment(new Date()).add(-1, 'years').add(-10, 'hours').format('YYYYMMDD') } },
            { region: regionId }
        ]
    };

    database.find('events',filter , { sort: 'date', limit: 10 })
        .then(function (docs) {
            response.json(docs);
        });
});

module.exports = router;

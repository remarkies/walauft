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

router.post('/',function(request,response){
    var param = request.body;
    let date = moment(new Date())
                    .add(-10, 'hours')
                    .format('YYYYMMDD');

    let query = [
        { $match: { region: "" + param.regionId + "", date: { $gte: date } } },
        { $unwind: '$events' },
    ];

    if(param.tags !== undefined && param.tags.length > 0) {
        let orQuery = { $match: { $or: [] } };
        param.tags.forEach(tag => {
            orQuery.$match.$or.push({'events.tags': { $elemMatch: { type: '' + tag.type + '', text: '' + tag.text + ''  }}});
        });
        query.push(orQuery);
    }

    query.push({ $group: { _id: '$_id', date: { '$last':'$date'}, region: { '$last' : '$region' }, events: {$push: '$events'}}});
    query.push({ $sort : { date: 1 } });

    if(param.tags !== undefined && param.tags.length > 0) {
        query.push({ $limit: 14 })
    } else {
        query.push({ $limit: 14 })
    }


    database.aggregate('events', query)
        .then(function (docs) {
            response.json(docs);
        })
        .catch(() => {
            response.json({})
        });
});

module.exports = router;

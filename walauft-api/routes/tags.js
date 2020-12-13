let express = require('express');
let moment = require('moment');
let database = require('../services/database');
let router = express.Router();
let fuzzy = require('fuzzy-search')

router.post('/',function(request,response){
    var param = request.body;
    let date = moment(new Date())
        .add(-1, 'years')
        .add(-10, 'hours')
        .format('YYYYMMDD');

    let query = [
        { $match: { region: param.regionId.toString() } },
        { $project: {
                tags: {
                    $filter: {
                        input: "$tags",
                        as: "tag",
                        cond: { $gte: ["$$tag.date", date]}
                    }
                }, _id: 0 }},
        { $unwind: '$tags' }
    ];

    database.aggregate('tags', query)
        .then(function (docs) {
            const searcher = new fuzzy(docs, ['tags.text'], {
                caseSensitive: false,
                sort: true
            });

            const results = searcher.search(param.search);

            response.json(results.map((result => {
                return {
                    date: result.tags.date,
                    text: result.tags.text,
                    type: result.tags.type
                }
            })));
        })
        .catch(() => {
            response.json({})
        });
});

module.exports = router;

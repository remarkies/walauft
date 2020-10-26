let MongoClient = require('mongodb').MongoClient;

let database = null;

module.exports.connect = function(url) {
    return new Promise(function (resolve, reject) {
        MongoClient.connect(url, function(err, db) {
            if(err) return reject(err);

            database = db;
            resolve();
        });
    });
};

module.exports.query = function (collection, query) {
    return new Promise(function (resolve, reject) {
        database.collection(collection, function (err, collection) {
            if(err) return reject(err);

            collection.findOne(query).then(function (doc) {
                resolve(doc);
            });
        });
    });
};

module.exports.upsert = function (collection, query, doc) {
    return new Promise(function (resolve, reject) {
        database.collection(collection, function (err, collection) {
            if(err) return reject(err);

            collection.updateOne(query, doc, { upsert: true }, function (err, res) {
                if(err) return reject(err);
                resolve(res);
            });
        });
    });
};

module.exports.find = function (collection, query, options) {
    return new Promise(function (resolve, reject) {
        database.collection(collection, function (err, collection) {
            if(err) return reject(err);

            collection.find(query, options).toArray(function (err, docs) {
                if(err) return reject(err);
                resolve(docs);
            });
        });
    });
};

module.exports.findAndSort = function (collection, query, options, sort) {
    return new Promise(function (resolve, reject) {
        database.collection(collection, function (err, collection) {
            if(err) return reject(err);

            collection.find(query, options).sort(sort).toArray(function (err, docs) {
                if(err) return reject(err);
                resolve(docs);
            });
        });
    });
};

module.exports.close = function () {
    return new Promise(function (resolve, reject) {
        if(!database) return resolve();

        database.close();
        resolve();
    });
};
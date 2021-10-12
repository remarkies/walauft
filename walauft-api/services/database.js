let MongoClient = require('mongodb').MongoClient;

let database = null;
let client = null

module.exports.connect = function(url) {
    return new Promise(function (resolve, reject) {
        MongoClient.connect(url, function(err, client) {
            if(err) return reject(err);
            this.client = client
            database = client.db('walauftDB');
            resolve();
        });
    });
};

module.exports.query = function (collection, query) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);

        coll.findOne(query).then(function (doc) {
            resolve(doc);
        });
    });
};

module.exports.upsert = function (collection, query, doc) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection)
        coll.updateOne(query, { $set: doc }, { upsert: true }, function (err, res) {
            if(err) return reject(err);
            resolve(res);
        });
    });
};

module.exports.update = function (collection, query, doc) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);

        coll.update(query, doc, { upsert: true }, function (err, res) {
            if(err) return reject(err);
            resolve(res);
        });
    });
};

module.exports.insert = function (collection, doc) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);
        coll.insertOne(doc, function (err, res) {
            if(err) return reject(err);
            resolve(res);
        });
    });
};

module.exports.find = function (collection, query, options) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);
        coll.find(query, options).toArray(function (err, docs) {
            if(err) return reject(err);
            resolve(docs);
        });
    });
};

module.exports.aggregate = function (collection, query, options) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);
        coll.aggregate(query, options).toArray(function (err, docs) {
            if(err) return reject(err);
            resolve(docs);
        });
    });
};

module.exports.findAndSort = function (collection, query, options, sort) {
    return new Promise(function (resolve, reject) {
        let coll = database.collection(collection);

        coll.find(query, options).sort(sort).toArray(function (err, docs) {
            if(err) return reject(err);
            resolve(docs);
        });
    });
};

module.exports.close = function () {
    return new Promise(async function (resolve, reject) {
        if(!database) return resolve();

        await this.client.close();
        resolve();
    });
};
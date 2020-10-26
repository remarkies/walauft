var express = require('express');
var path = require('path');
var logger = require('morgan');
var cors = require('cors');
var bodyParser = require('body-parser');
const dotenv = require('dotenv');
dotenv.config();
var database = require('./services/database');
var events = require('./routes/events');



database.connect('mongodb://server:Olgr3mJu1@walauftdb-shard-00-00-wysk3.mongodb.net:27017,walauftdb-shard-00-01-wysk3.mongodb.net:27017,walauftdb-shard-00-02-wysk3.mongodb.net:27017/walauftDB?ssl=true&replicaSet=walauftDB-shard-0&authSource=admin&retryWrites=true&w=majority').then(function () {
    console.log('connected');
});

var app = express();

app.use(cors());
app.use(logger('dev'));
app.use(bodyParser.json());

app.use('/events', events);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.json(err);
  console.log(err);
});

module.exports = app;

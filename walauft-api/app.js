const express = require('express')
require('dotenv').config()
const app = express()
const port = 3000

let cors = require('cors');
app.use(cors());

let bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(bodyParser.raw());

let database = require('./services/database');
database.connect(process.env.DB_LINK).then(function () {
  console.log('connected to database');
});

let events = require('./routes/events');
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

app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`)
})
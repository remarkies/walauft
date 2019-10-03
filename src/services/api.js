var contentful = require('contentful');
var moment = require('moment');

var client = contentful.createClient({
  space: 'rq1gh35slude',
  accessToken: 'tq-9zxXuOyTJpiEXSAxg2waOG07mURBt7lJgoTBEPZs'
});


export function getEntries(regionId) {
  return new Promise(function (resolve, reject) {
    client.getEntries({content_type: 'event', 'fields.region': regionId, limit: 1000} )
      .then((response) => {
          resolve(response);
      })
      .catch(console.error);
  });
}


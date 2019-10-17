export function getEvents(regionId, today) {
    let axios = require('axios');

    let url = "https://walauftapi.herokuapp.com/" + "events/" + regionId + "/" + today;
    //url = "http://localhost:3000/" + "events/" + regionId + "/" + today;
    return axios.post(url).then((res) => {


      let json = JSON.parse(JSON.stringify(res.data));


      let events = [];

      json.forEach(o => {
        o.events.forEach(e => {
          events.push(e);
        });
      });

      return events;
    });
}


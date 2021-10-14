var Xray = require('x-ray')
var moment = require('moment')
var x = Xray()
moment.locale('DE')
const utf8 = require('utf8');

/*
x('https://www.zukunft.cl/', ['#eventlistcont .scroll a@href'])
(async function(err, eventLinks) {
    // eventsLink => all event links for detailpage

    for (let eventLink of eventLinks) {
        await fetchEventData(eventLink)
    }
})
*/

let model = {
    day: {
        date: {
            expression: '.edate@html',
            func: function (input) {
                return moment(input, 'ddd DD MM YY').format('YYYYMMDD')
            }
        },
        region: {
            expression: null,
            func: function () {
                return 6
            }
        }
    },
    event: {
        name: {
            expression: '.etitle@html',
            func: function(input) {
                return input.replace(':', '')
            }
        },
        date: {
            expression: '.edate@html',
            func: function (input) {
                return moment(input, 'ddd DD MM YY').format('YYYY-MM-DD')
            }
        },
        time: {
            expression: '.einfo span@html',
            func: function(input) {
                return input.replace('h', ':00')
            }
        },
        minage: {
            expression: null,
            func: function () {
                return "18+"
            }
        },
        price: {
            expression: ['.einfo span@html'],
            func: function (input) {
                return input[2].replace(',', '').trim()
            }
        },
        description: {
            expression: ['#eventcont .hyphenate p@html'],
            func: function(input) {
                input = input.join(' ')
                    .replaceAll('&#xA0;', ' ')
                    .replaceAll('&#xE4;', 'ä')
                    .replaceAll('&#xFC;', 'ü')
                    .replaceAll('&#xF6;', 'ö')

                return input
            }
        },
        styles: {
            expression: null,
            func: function () {
                return [ "Elektr. Musik" ]
            }
        }
    },
    location: {
        name: {
            expression: null,
            func: function () {
                return "Club Zukunft"
            }
        },
        street: {
            expression: null,
            func: function () {
                return "Dienerstrasse"
            }
        },
        streetNo: {
            expression: null,
            func: function () {
                return "33"
            }
        },
        zipCode: {
            expression: null,
            func: function () {
                return "8004"
            }
        },
        city: {
            expression: null,
            func: function () {
                return "Zürich"
            }
        },
        longitude: {
            expression: null,
            func: function () {
                return "8.5251524"
            }
        },
        latitude: {
            expression: null,
            func: function () {
                return "47.3781886"
            }
        }
    }
}

let modelTag = {
    type: String,
    text: String
}

scrap('https://www.zukunft.cl/club/2021-10-14_unknown-citizen-sean-douglas-axophono/')
    .then(result => {
        console.log(result.events[0])
    })

async function scrap(link) {

    for (let [key, value] of Object.entries(model)) {
        value = await scrapProperties(link, value)
    }

    let scrapModel = {}
    return
}

async function scrapProperties(link, model) {
    for (const [key, propVal] of Object.entries(model)) {
        if(propVal.expression !== undefined) {
            propVal.value = propVal.expression == null ? propVal.func() : await fetchSomething(link, propVal.expression, propVal.func)
        }
    }
    return model
}

async function fetchSomething(link, expression, modificationFunction) {
    return new Promise(function(resolve, reject) {
        x(link, expression)
        (async function(err, info) {
            resolve(modificationFunction(info))
        })
    });
}
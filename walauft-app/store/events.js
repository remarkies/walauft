import Fuse from 'fuse.js'
const options = {
  keys: ["name", "tags.text"],
  threshold: 0.4
}
const fuse = new Fuse([], options)
const _ = require('lodash');
export const state = () => ({
  allEventDays: [],
  searchTerm: "",
  filteredEventDays: []
})

export const mutations = {
  setAllEventDays(state, newAllEventDays) {
    let allEvents = []
    newAllEventDays.forEach(eventDay => {
      //merge all events of all days together to later search for events independently from a day
      allEvents = [...allEvents, ...eventDay.events]
    })
    fuse.setCollection(allEvents)
    state.allEventDays = newAllEventDays
    //maybe be stupid dunno yet
    state.filteredEventDays = newAllEventDays
  },
  setSearchTerm(state, newSearchTerm) {
    state.searchTerm = newSearchTerm
  },
  setFilteredEventDays(state) {
    if (state.searchTerm.length > 0) {

      const allFoundEventIds = fuse.search(state.searchTerm).map(obj => obj.item._id)

      //only get eventDays that contain eventItems that were found
      const copyOfAllEventDays = _.cloneDeep(state.allEventDays)
      let newlyFilteredEventDays = copyOfAllEventDays.filter(eventDay => {
        return eventDay.events.some(eventItem => {
          return allFoundEventIds.includes(eventItem._id)
        })
      }
      )
      //only put eventItems that were found in a EventDay 
      state.filteredEventDays = newlyFilteredEventDays.map(eventDay => {
        eventDay.events = eventDay.events.filter(eventItem => allFoundEventIds.includes(eventItem._id))
        return eventDay
      }

      )
      // state.filteredEventDays = newlyFilteredEventDays
    } else {
      state.filteredEventDays = state.allEventDays
    }
  }
}
export const getters = {
  getFilteredEventDays(state) {

  },

}
export const actions = {
  setSearchTerm({ commit, state }, newSearchTerm) {
    commit("setSearchTerm", newSearchTerm)
    commit("setFilteredEventDays")
  }
}
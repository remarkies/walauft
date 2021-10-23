import Fuse from 'fuse.js'
const options = {
  keys: ["name", "tags.text", "location.name"],
  threshold: 0.25
}
const fuse = new Fuse([], options)
const _ = require('lodash');
export const state = () => ({
  allEventDays: [],
  allEvents: [],
  searchTerm: "",
  filteredEventDays: [],
  activeTags: []
})

export const mutations = {
  addTag(state, tag) {
    state.activeTags.push(tag)
  },
  removeTag(state, tag) {
    state.activeTags = state.activeTags.filter(activeTag => activeTag.text !== tag.text)
  },
  clearAllTags(state) {
    state.activeTags = []
  },
  setAllEventDays(state, newAllEventDays) {

    newAllEventDays.forEach(eventDay => {
      //merge all events of all days together to later search for events independently from a day
      state.allEvents = [...state.allEvents, ...eventDay.events]
    })
    fuse.setCollection(state.allEvents)
    state.allEventDays = newAllEventDays
  },
  setSearchTerm(state, newSearchTerm) {
    state.searchTerm = newSearchTerm
  },
  setFilteredEventDays(state) {
    const hasActiveSearch = state.searchTerm.length > 0
    const hasActiveTag = state.activeTags.length > 0
    if (hasActiveSearch || hasActiveTag) {
      const eventsFoundBySearch = hasActiveSearch ? fuse.search(state.searchTerm).map(obj => obj.item) : state.allEvents
      const eventsFoundBySearchAndTags = hasActiveTag ? eventsFoundBySearch.filter(eventItem => eventItem.tags.map(tag => tag.text).some(text => state.activeTags.map(tag => tag.text).includes(text))) : eventsFoundBySearch
      const allFoundEventIds = eventsFoundBySearchAndTags.map(eventItem => eventItem._id)

      const copyOfAllEventDays = _.cloneDeep(state.allEventDays)
      //only get eventDays that contain eventItems that were found
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
  },
  toggleTag({ commit, state }, tag) {
    if (state.activeTags.find(tagInArray => tagInArray.text == tag.text)) {
      commit("removeTag", tag)
      commit("setFilteredEventDays")

    }
    else {
      commit("addTag", tag)
      commit("setFilteredEventDays")

    }

  },
  setAllEventDays({ commit, state }, eventDays) {
    commit("setAllEventDays", eventDays)
    commit("setFilteredEventDays")
  },
}
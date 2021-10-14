import Fuse from 'fuse.js'
const options = {
  keys: ["events.name", "events.tags.text"]
}
const fuse = new Fuse([], options)

export const state = () => ({
  allEvents: [],
})

export const mutations = {
  setAllEvents(state, events) {
    console.log("setting all events");
    fuse.setCollection(events)
    state.allEvents = events
  },
}
export const getters = {
  getFilteredEvents: (state) => (searchTerm) => {
    return searchTerm ? fuse.search(searchTerm).map(obj => obj.item) : state.allEvents
  },

}
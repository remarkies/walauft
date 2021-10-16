export const state = () => ({
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
  }
}
export const actions = {
  toggleTag({ commit, state }, tag) {
    if (state.activeTags.find(tagInArray => tagInArray.text == tag.text) ) {
      commit("removeTag", tag)
    }
    else {
      commit("addTag", tag)
    }
  }
}
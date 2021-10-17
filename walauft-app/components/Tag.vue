<template>
  <button
    class="tag"
    :class="{
      active: $store.state.activeTags.find(
        (tagInArray) => tagInArray.text == tag.text
      ),
    }"
    @click="toggleTag(tag)"
  >
    {{ tag.text }}
  </button>
</template>

<script lang="ts">
import Vue from "vue";
import { Tag } from "~/types/Models";
import { mapActions } from "vuex";

export default Vue.extend({
  props: {
    tag: {
      type: Object as () => Tag,
      required: true,
    },
  },
  data() {
    return {
      isActive: false,
    };
  },
  methods: {
    ...mapActions({
      toggleTag: "toggleTag",
    }),
  },
});
</script>
<style lang="scss" scoped>
.tag {
  border: var(--border-style);
  font-size: 0.625rem;
  border-radius: 0.2rem;
  padding: 0.1rem 0.3rem;
  display: inline;
  color: inherit;
  background-color: var(--secondary-color);
  cursor: pointer;
  box-shadow: 0rem 0rem 0px var(--primary-color);
  transition: all 0.17s cubic-bezier(0.485, -0.12, 0.07, 1);
  white-space: nowrap;
}
.active {
  box-shadow: 0.125rem 0.125rem 0px var(--primary-color);
  font-weight: 700;
}
</style>
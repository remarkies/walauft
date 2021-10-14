<template>
  <button class="tag" :class="{ active: $store.state.tags.activeTags.find(tagInArray => tagInArray.text == tag.text) }" @click="toggleTag(tag)">
    {{ tag.text }}
  </button>
</template>

<script lang="ts">
import Vue from "vue";
import { Tag } from "~/types/Models";
import { mapActions} from "vuex";

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
      toggleTag: "tags/toggleTag",
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
  margin-right: 0.5rem;
  color: inherit;
  background-color: var(--secondary-color);
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.55, 0.055, 0.675, 0.19);
}
.active {
  box-shadow: 0.125rem 0.125rem 0px var(--primary-color);
  font-weight: 700;
}
</style>
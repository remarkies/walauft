<template>

    <transition-group
      name="list-complete"
      tag="div"
      id="tag-list"
      :class="{ flexEnd: flexEnd }"
    >
      <Tag v-for="tag in tags" :tag="tag" :key="tag.text" />
    </transition-group>
 
</template>

<script lang="ts">
import Vue from "vue";
import { Tag } from "~/types/Models";

export default Vue.extend({
  props: {
    tags: {
      type: Array as () => Tag[],
      required: true,
    },
    flexEnd: {
      type: Boolean,
      required: false,
      default: false,
    },
  },
});
</script>
<style lang="scss" scoped>
#tag-list {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 0.5rem;
  padding: 0.3rem 0;
  // min-height: calc(var(--shadow-distance) + var(--tag-height));
}
.flexEnd {
  justify-content: flex-end;
}
</style>
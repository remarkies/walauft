<template>
  <div class="tag">{{tag.text}}</div>
</template>

<script lang="ts">
import Vue from "vue";
import { Tag } from "~/types/Models";

export default Vue.extend({
  props: {
    tag: {
      type: Object as () => Tag,
      required: true,
    },
  },
});
</script>
<style lang="scss" scoped>
.tag {
  border: var(--border-style);
  font-size: 0.625rem;
  border-radius: 0.2rem;
  padding: 0.05rem 0.3rem;
  display: inline;
  margin-right: 0.5rem;
}
</style>
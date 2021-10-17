<template>
  <section>
    <h4 class="info-title">{{ title }}</h4>
    <span class="info">
      <slot> </slot>
    </span>
  </section>
</template>

<script lang="ts">
import Vue from "vue";
import { EventItem } from "~/types/Models";

export default Vue.extend({
  props: {
    title: {
      type: String,
      required: true,
    },
  },
});
</script>
<style lang="scss" scoped>
h4 {
  font-size: 0.625rem;
  margin: 0;
  font-weight: 400;

  font-style: normal;
}
.info {
  font-size: 1rem;
  // font-variation-settings: "wght" 500;
  font-weight: 500;


}
</style>
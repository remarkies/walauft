<template>
  <div class="event-item">
    <NuxtLink
      class="event-item-name"
      :to="{
        name: 'stadt-event',
        params: { event: eventItem.name, eventItem: eventItem },
      }"
      >{{ eventItem.name }}</NuxtLink
    >
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { EventItem } from "~/types/Models" 

export default Vue.extend({
  props: {
    eventItem: {
      type: Object as () => EventItem,
    },
  },
});
</script>
<style lang="scss" scoped>
.event-item {
}
.event-item-name {
  font-size: 1rem;
}
</style>
<template>
  <li class="event-item">
    <NuxtLink
      class="event-item-name"
      :to="{
        name: 'stadt-event',
        params: { event: eventItem._id, eventItem: eventItem },
      }"
      >{{ eventItem.name }}</NuxtLink
    >
    <div class="location-tags-wrapper">
      <div class="location">{{ eventItem.location.name }}</div>
      <div class="tags-wrapper">
        <Tag v-for="genre in getGenres" :tag="genre" :key="genre.text"></Tag>
      </div>
    </div>
  </li>
</template>

<script lang="ts">
import Vue from "vue";
import { EventItem, Tag } from "~/types/Models";

export default Vue.extend({
  props: {
    eventItem: {
      type: Object as () => EventItem,
    },
  },
  computed: {
    getGenres(): Tag[] {
      return this.eventItem.tags
        .filter((tag) => tag.type == "style")
        .slice(0, 2);
    },
  },
});
</script>
<style lang="scss" scoped>
.event-item {
  display: flex;
  flex-direction: column;
  // gap: 0.25rem;
  padding-left: 1rem;
}
.event-item-name {
  font-size: 1rem;
  font-weight: 500;
}
.location-tags-wrapper {
  .location {
    font-size: 0.75rem;
    font-weight: 300;
  }
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  .tags-wrapper {
    text-align: right;
    max-width: 66%;
    gap: 0.5rem;
    display: flex;
  }
}
</style>
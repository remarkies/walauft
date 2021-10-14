<template>
  <ul class="event-day">
    <li class="event-day-date" ref="day">{{ formattedDay }}</li>
    
    <EventListItem
      v-for="eventItem in eventDay.events"
      :key="eventItem.key"
      :event-item="eventItem"
    />
  </ul>
</template>

<script lang="ts">
import Vue from "vue";
import { EventDay } from "~/types/Models";

export default Vue.extend({
  props: {
    eventDay: {
      type: Object as () => EventDay,
    },
  },
  computed: {
    formattedDay(): String {
      return this.eventDay.date;
    },
  },
});
</script>
<style lang="scss" scoped>
.event-day {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin: 1.5rem 0;
}
.event-day-date {
  font-size: 1.5rem;
  padding: 0.75rem;
  border: var(--border-style);
  box-shadow: var(--box-shadow-style);
  border-radius: 0.25rem;
  position: sticky;
  background: var(--secondary-color);
  top: 1rem;
}
</style>
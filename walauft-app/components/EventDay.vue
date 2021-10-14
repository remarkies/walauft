<template>
  <ul class="event-day">
    <li class="event-day-date" ref="day">
      <time>
        {{ formattedDay }}
      </time>
      <time class="date">
        {{ formattedDate }}
      </time>
    </li>
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
import moment, { MomentInput } from "moment";
import "moment/locale/es";
import swissGermanLocale from "@/static/swissGermanLocale"
moment.updateLocale("de-ch", swissGermanLocale);
export default Vue.extend({
  props: {
    eventDay: {
      type: Object as () => EventDay,
    },
  },
  computed: {
    formattedDay(): String {
      return moment(this.eventDay.date as MomentInput, "YYYYMMDD").calendar();
    },
    formattedDate(): String {
      return moment(this.eventDay.date as MomentInput, "YYYYMMDD").format(
        "DD.MMM"
      );
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
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 1.5rem;
  padding: 0.75rem;
  border: var(--border-style);
  box-shadow: var(--box-shadow-style);
  border-radius: 0.25rem;
  position: sticky;
  background: var(--secondary-color);
  top: 1rem;
  .date{
    font-size: 0.75rem;
    font-weight: 200;
  }
}
</style>
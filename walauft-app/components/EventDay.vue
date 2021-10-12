<template>
  <div class="event-day">
    <div class="event-day-date"> {{eventDay.date}}</div>
    <div v-for="event in eventDay.events" :key="event.key"> {{ event.name }}</div>

  </div>
</template>

<script lang="ts">
import Vue from "vue";
interface EventDay {
  date: String,
  

}
export default Vue.extend({
  props: {
    eventDay: {
      type: Object,
    },
  },
});
</script>
<style lang="scss" scoped>
.event-day {
}
.event-day-date{
  font-size: 2rem;
}
</style>
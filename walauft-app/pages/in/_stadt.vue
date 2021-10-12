<template>
  <div>
    {{ city }}
    <ul>
      <EventDay v-for="eventDay in eventDays" :key="eventDay.date" :eventDay="eventDay" />
      
 
    </ul>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import citiesObj from "@/static/cities.js"

export default Vue.extend({
  data() {
    return {
      city: this.$route.params.stadt,
      eventDays: [],
    };
  },

  async fetch() {
    this.eventDays = await this.$http.$post("https://api.walauft.ch/events", {
      tags: [],
      regionId: citiesObj.cityIdName.find( cityIdNameObj => this.city == cityIdNameObj.name)?.id,
    });
  },
});
</script>

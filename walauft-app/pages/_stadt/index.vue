<template>
  <div>
    <div v-if="$fetchState.pending">Bin am lade... wart schnell pls</div>
    <div v-else-if="$fetchState.error">da lauft nix</div>
    <ul v-else>
      <EventDay
        v-for="eventDay in eventDays"
        :key="eventDay.date"
        :eventDay="eventDay"
      />
    </ul>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { PropType } from "vue";
import citiesObj from "@/static/cities.js";
import { EventDay } from "~/types/Models";
export default Vue.extend({
  head() {
    return {
      title: "Walauft in " + this.$route.params.stadt,
      meta: [
        {
          hid: "description",
          name: "description",
          content: "Events und Partys in" + this.$route.params.stadt,
        },
      ],
      link: [
        {
          hid: "canonical",
          rel: "canonical",
          href: `https://walauft.ch/in/${this.$route.params.stadt}`,
        },
        {
          rel: "stylesheet",
          href: 'https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@0,300;0,400;0,500;1,700&display=swap" rel="stylesheet',
        },
      ],
    };
  },
  data() {
    return {
      city: this.$route.params.stadt,
      eventDays: [] as EventDay[],
    };
  },
  async fetch(){
    this.eventDays = await this.$http.$post("https://api.walauft.ch/events", {
      tags: [],
      regionId: citiesObj.cityIdName.find(
        (cityIdNameObj) => this.city == cityIdNameObj.name
      )?.id,
    });
    if (this.eventDays.length <= 0) {
      throw new Error();
    }
  },
});
</script>

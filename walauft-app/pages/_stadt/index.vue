<template>
  <div>
    <div>
      {{ $store.state.events.filteredEventDays.length }}

      <Search />
      <div>
        <Tag
          v-for="tag in $store.state.tags.activeTags"
          :key="tag.text"
          :tag="tag"
        />
      </div>
    </div>
    <div v-if="$fetchState.pending">Bin am lade... wart schnell pls</div>
    <div v-else-if="$fetchState.error">da lauft nix</div>
    <ul v-else>
      <EventDay
        v-for="eventDay in $store.state.events.filteredEventDays"
        :key="eventDay.date"
        :eventDay="eventDay"
      />
    </ul>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import citiesObj from "@/static/cities.js";
import { EventDay, Tag } from "~/types/Models";
import { mapState } from "vuex";
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
      searchString: "",
      allEventDays: [] as EventDay[],
    };
  },
  computed: {
    ...mapState("tags", {
      activeTags: (state: any) => state.activeTags,
    }),
  },
  watch: {
    activeTags() {
      this.$fetch();
    },
    //watching it bc fetch requests can be cached therefore be not executed
    allEventDays(newValue: EventDay[]) {
      this.$store.commit("events/setAllEventDays", newValue);
    },
  },
  async fetch() {
    this.allEventDays = await this.$http.$post(
      "https://api.walauft.ch/events",
      {
        tags: this.activeTags,
        regionId: citiesObj.cityIdName.find(
          (cityIdNameObj) => this.city == cityIdNameObj.name
        )?.id,
      }
    );
    if (this.allEventDays.length <= 0) {
      throw new Error();
    }
  },
});
</script>
<style>
ul {
  padding: 0;
  list-style-type: none;
}
</style>

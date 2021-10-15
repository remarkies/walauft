<template>
  <div>
    <div>
      <Search id="search-bar" />
      <div id="active-tag-wrapper">
        <Tag
          v-for="tag in $store.state.tags.activeTags"
          :key="tag.text"
          :tag="tag"
        />
      </div>
    </div>
    <div v-if="this.$store.state.events.allEventDays.length <= 0 && !$fetchState.error">Bin am lade... wart schnell pls</div>
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
import citiesObj from "@/static/cities";
import { City, EventDay, Tag } from "~/types/Models";
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
      cityName: this.$route.params.stadt,
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
      this.$fetch(true);
    },
    //watching it bc fetch requests can be cached therefore be not executed
    allEventDays(newValue: EventDay[]) {
      this.$store.commit("events/setAllEventDays", newValue);
    },
  },
  // mounted() {
  //   const color = citiesObj.cityIdName.find(
  //     (cityIdNameObj: City) => this.cityName == cityIdNameObj.name
  //   )?.color;
  //   if (color) {
  //     document.documentElement.style.setProperty("--hue", color[0].toString());
  //     document.documentElement.style.setProperty(
  //       "--saturation",
  //       color[1].toString() + "%"
  //     );
  //     document.documentElement.style.setProperty(
  //       "--luminosity",
  //       color[2].toString() + "%"
  //     );
  //   }
  // },
  async fetch() {
    if (this.$store.state.events.allEventDays.length <= 0 || this.activeTags) {
      const response = await this.$http.$post(
        "https://api.walauft.ch/events",
        {
          tags: this.activeTags,
          regionId: citiesObj.cityIdName.find(
            (cityIdNameObj: City) => this.cityName == cityIdNameObj.name
          )?.id,
        }
      );
      if (response.length <= 0) {
        throw new Error();
      }
      this.allEventDays = response
    }
  },
});
</script>
<style>
ul {
  padding: 0;
  list-style-type: none;
}
#active-tag-wrapper {
  display: flex;
  align-items: center;
}
#search-bar {
  margin-bottom: 1rem;
}
</style>

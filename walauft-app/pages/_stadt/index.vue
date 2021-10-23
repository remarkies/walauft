<template>
  <div>
    <Search id="search-bar" />
      <TagSection
        v-if="$store.state.activeTags.length > 0"
        :tags="$store.state.activeTags"
      />
    
    <EventDayDateBox
      v-if="this.$store.state.allEventDays.length <= 0 && !$fetchState.error"
      class="loading"
    >
     walauft?
    </EventDayDateBox>
    <div v-else-if="$fetchState.error">da lauft nix</div>

    <transition-group name="list-complete" tag="ul" id="event-day-list" v-else>
      <EventDay
        v-for="eventDay in $store.state.filteredEventDays"
        :key="eventDay.date"
        :eventDay="eventDay"
        class="list-complete-item"
      />
    </transition-group>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import citiesObj from "@/static/cities";
import { City, EventDay, Tag } from "~/types/Models";
import { mapState } from "vuex";

declare module "vue/types/vue" {
  interface Vue {
    $http: any;
  }
}

export default Vue.extend({
  transition(to, from) {
    if (
      (to.name == "stadt" && from?.name == "index") ||
      (to.name == "stadt-event" && from?.name == "stadt")
    ) {
      return "slide-left";
    }
    return "slide-right";
  },
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
    ...mapState({
      activeTags: (state: any) => state.activeTags,
    }),
  },
  watch: {
    activeTags() {
      // this.$fetch(true);
    },
    //watching it bc fetch requests can be cached therefore be not executed
    allEventDays(newValue: EventDay[]) {
      this.$store.dispatch("setAllEventDays", newValue);
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
    const response = await this.$http.$post("https://api.walauft.ch/events", {
      tags: "",
      regionId: citiesObj.cityIdName.find(
        (cityIdNameObj: City) => this.cityName == cityIdNameObj.name
      )?.id,
    });
    if (response.length <= 0) {
      throw new Error();
    }
    this.allEventDays = response;
  },
});
</script>
<style lang="scss">
#active-tag-wrapper {
  padding-top: calc((var(--tag-height) + var(--shadow-distance)) / 2);
}

ul {
  padding: 0;
  list-style-type: none;
  margin: 0;
  display: flex;
  flex-direction: column;
}
#event-day-list {
  display: flex;
  flex-direction: column;
}
.loading{

}
</style>

<template>
  <article class="event" v-if="eventItem">
    <!-- <NuxtLink :to="'/' + $route.params.stadt"> zrugg </NuxtLink> -->
    <h1 class="box-with-dropshadow">{{ eventItem.name }}</h1>
    <section id="event-details-section">
      <EventInfoSection title="Wo">
        <address id="event-adress">{{ eventItem.location.name }}</address>
      </EventInfoSection>
      <EventInfoSection title="Wenn">
        <time id="event-date" :datetime="formatedDate">{{ formatedDate }}</time>
      </EventInfoSection>
      <EventInfoSection v-if="eventItem.minage.length > 0" title="Ab">
        <div id="event-minage">{{ eventItem.minage }}</div>
      </EventInfoSection>
      <EventInfoSection v-if="eventItem.price.length > 0" title="Wie tür">
        <div id="event-price">{{ eventItem.price }}</div>
      </EventInfoSection>
      <EventInfoSection v-if="getGenres.length > 0" title="Genres">
        <Tag :tag="tag" v-for="tag in getGenres" :key="tag.text" />
      </EventInfoSection>
      <EventInfoSection v-if="getActs.length > 0" title="Acts">
        <Tag :tag="tag" v-for="tag in getActs" :key="tag.text" />
      </EventInfoSection>
      <section>
        <p>{{ eventItem.description }}</p>
      </section>
    </section>

    <MapBox v-if="hasCoordinates" :location="eventItem.location" />
  </article>
</template>

<script lang="ts">
import Vue from "vue";
import { EventDay, EventItem, Tag } from "~/types/Models";
import moment, { MomentInput } from "moment";
import "moment/locale/es";
import swissGermanLocale from "@/static/swissGermanLocale";
moment.updateLocale("de-ch", swissGermanLocale);
export default Vue.extend({
  data: function () {
    return {
      eventItem: this.$route.params.eventItem as unknown as EventItem,
    };
  },
  computed: {
    hasCoordinates(): Boolean {
      return (
        String(this.eventItem.location.longitude).length > 0 &&
        !isNaN(this.eventItem.location.longitude)
      );
    },
    formatedDate(): String {
      if (this.eventItem.time) {
        return (
          moment(this.eventItem.date as MomentInput, "YYYYMMDD").format(
            "dddd DD.MMMM"
          ) +
          " am " +
          this.eventItem.time
        );
      } else {
        return moment(this.eventItem.date as MomentInput, "YYYYMMDD").format(
          "dddd DD.MMMM"
        );
      }
    },
    getGenres(): Tag[] {
      return this.eventItem.tags.filter((tag) => tag.type == "style");
    },
    getActs(): Tag[] {
      return this.eventItem.tags.filter((tag) => tag.type == "act");
    },
  },
  async fetch() {
    if (!this.eventItem) {
      const eventday = (await this.$http.$post(
        "https://api.walauft.ch/events/event",
        {
          eventId: this.$route.params.event,
        }
      )) as EventDay[];
      //api doesnt respond with an array of events but with a EventItem
      this.eventItem = eventday[0].events[0] as EventItem;
    }
  },
});
</script>
<style lang="scss" >
.event {
  $gap: 1rem;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  p {
    margin-top: 0;
    margin-bottom: $gap;
  }
  #event-adress {
    font-style: inherit;
  }
  #event-details-section {
    display: flex;
    flex-direction: column;
    gap: $gap;
    padding: 0 $gap;
    height: 100%;
  }
}
</style>
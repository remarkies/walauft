<template>
  <article class="event" v-if="eventItem">
    <h2 class="rounded-box">{{ eventItem.name }}</h2>
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
    formatedDate(): String {
      if (this.eventItem.time) {
        return (
          moment(this.eventItem.date as MomentInput, "YYYYMMDD").format(
            "dddd  DD.MMMM"
          ) +
          " am " +
          this.eventItem.time
        );
      } else {
        return (
          moment(this.eventItem.date as MomentInput, "YYYYMMDD").format(
            "dddd  DD.MMMM"
          )
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
  section {
    margin: 1rem 0;
  }
  #event-adress {
    font-style: inherit;
  }
}
</style>
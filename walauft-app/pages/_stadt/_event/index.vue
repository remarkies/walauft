<template>
  <article class="event">
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
import { EventItem, Tag } from "~/types/Models";

export default Vue.extend({
  data: function () {
    return {
      eventItem: this.$route.params.eventItem as unknown as EventItem,
    };
  },
  computed: {
    formatedDate(): String {
      return this.eventItem.date + " " + this.eventItem.time;
    },
    getGenres(): Tag[] {
      return this.eventItem.tags.filter((tag) => tag.type == "style");
    },
    getActs(): Tag[] {
      return this.eventItem.tags.filter((tag) => tag.type == "act");
    },
  },
});
</script>
<style lang="scss" >
.event {
  section {
    margin: 1rem 0;
  }
}
adress {
  font-style: normal !important;
}
</style>
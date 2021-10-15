<template>
  <ul class="event-day">
    <div class="event-day-date-wrapper" ref="day">
      <li class="event-day-date box-with-dropshadow">
        <!-- <span style="font-size: 8px"> {{ rectTop }} , {{ rectBottom }} </span> -->
        <time>
          {{ formattedDay }}
        </time>
        <time class="date">
          {{ formattedDate }}
        </time>
      </li>
    </div>
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
import swissGermanLocale from "@/static/swissGermanLocale";
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
  //   data() {
  //   return {
  //     rectTop: 0 as Number,
  //     rectBottom: 0 as Number,

  //   };
  // },
  // mounted() {
  //   const stickyElm = this.$refs.day as Element;

  //   const observer = new IntersectionObserver(
  //     ([e]) => {
  //       this.rectBottom = e.boundingClientRect.bottom;
  //       this.rectTop = e.boundingClientRect.top;

  //       e.target.classList.toggle("isSticky", e.intersectionRatio < 1);
  //     },
  //     { threshold: [1] }
  //   );

  //   observer.observe(stickyElm);
  // },
});
</script>
<style lang="scss" scoped>
.event-day {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin: 1.5rem 0;
  .event-day-date-wrapper {
    top: -1px;
    padding-top: calc(1rem + 1px);
    position: sticky;

    .event-day-date {
      font-size: 1.5rem;
      position: sticky;
      top: 1rem;
      .date {
        font-size: 0.75rem;
        font-weight: 200;
      }
    }
  }
  // .isSticky {
  //   .event-day-date {
  //     font-variation-settings: "wght" 500;
  //     box-shadow: var(--box-shadow-style);
  //   }
  // }
}
</style>
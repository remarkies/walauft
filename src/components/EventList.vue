<template>
    <div class="event-list">
        <Event :event="event.fields.json" v-for="event in events" />
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEntries } from "../services/api";
  import moment from "moment";


  export default {
    name: "EventList",
    data: function() {
      return {
        events: []
      }
    },
    components: {
      Event
    },
    props: {
      type: String
    },
    watch: {
      type: async function(newVal) {
        var Enumerable = require('../../node_modules/linq');
        let result = await getEntries(this.$route.params.regionId);

        console.log("New Val: " + newVal);

        if(newVal == "0")
          this.events = Enumerable.from(result.items)
            .where($ => $.fields.json.date == moment().add(-10, 'hours').format('YYYY-MM-DD'))
            .orderBy($ => $.fields.json.date && $.fields.json.name).toArray();
        else if(newVal == "1")
          this.events = Enumerable.from(result.items)
            .where($ => moment($.fields.json.date).add(-1, 'day').isAfter(moment()))
            .orderBy($ => $.fields.json.date && $.fields.json.name).toArray();
      }
    },
    mounted: function() {
        this.type = "0";
    }
  };



</script>

<style scoped>
    @import "../styles/event.scss";
</style>

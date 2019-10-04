<template>
    <div class="event-list">
        <Event @click.native="eventClick(event.fields.json.location.latitude, event.fields.json.location.longitude)" :event="event.fields.json" v-for="event in events" />
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEntries } from "../services/api";

  export default {
    name: "EventList",
    methods: {
      eventClick: function(latitude, longitude) {
        this.$emit('locationChanged', {lat: latitude, lng: longitude});
       console.log(latitude, longitude);
      }
    } ,
    data: function() {
      return { events: []}
    },
    components: {
      Event
    },
    created: async function() {
      let result = await getEntries(this.$route.params.regionId);

      



      this.events = result.items;
      console.log(this.events.length);
    }
  };


</script>

<style scoped>
    @import "../styles/event.scss";
</style>

<template>
    <div class="event-list">
        <Event :event="event.fields.json" v-for="event in events" />
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEntries } from "../services/api";

  export default {
    name: "EventList",
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

</style>
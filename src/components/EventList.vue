<template>
    <div class="event-list">
        <Event />
        <Event />
        <Event />
    </div>
</template>

<script>
  import Event from "./Event";
  export default {
    name: "EventList",
    components: { Event }
  };
</script>

<style scoped>
    @import "../styles/event.scss";
</style>
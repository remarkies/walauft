<template>
    <div class="event">
        <div class="event-name">{{event.name}}</div>
        <div class="event-desc-container">
            <div class="club">{{event.location.name}}</div>
            <div class="zeit">{{event.start}}</div>
        </div>
    </div>
</template>

<script>
  export default {
    name: "Event",
    props: {
      event: {}
    }
  };
</script>

<style scoped>
    @import "../styles/event.scss";
</style>

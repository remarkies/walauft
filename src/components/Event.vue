<template>
    <div class="event">
        <div class="club">{{event.name}}</div>
        <div class="event-name">{{event.date}}</div>
        <div class="acts">{{event.location.name}}</div>
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

</style>

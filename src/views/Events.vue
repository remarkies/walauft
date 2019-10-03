<template>
  <div class="Events">
    <Header/>
    <EventList/>
  </div>
</template>
<script>
  import Header from "../components/Header";
  import EventList from "../components/EventList";

  export default {
    name: "events",
    components: { Header, EventList }
  };
</script>
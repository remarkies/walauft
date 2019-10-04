<template>
  <div class="Events">
    <div class="heute-sonst-switch">
      <a><div id="heute" >hüt</div></a>
      <a><div id="sonst" >süsch</div></a>
    </div>

    <Header/>
    <EventList/>
  </div>
</template>
<style scoped>
  @import "../styles/events.scss";
</style>
<script>
  import Header from "../components/Header";
  import EventList from "../components/EventList";

  export default {
    name: "events",
    components: { Header, EventList },
    

  };




</script>
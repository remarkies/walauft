<template>
  <div class="Events">
    <div class="heute-sonst-switch">
      <a id="heute" >hüt</a>
      <a id="sonst">süsch</a>
    </div>
    Region ID is: {{ $route.params.regionId }}
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
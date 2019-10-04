<template>
  <div class="Events">

    <div class="heute-sonst-switch">
      <a><div id="heute" >hüt</div></a>
      <a><div id="sonst" >süsch</div></a>
    </div>

    <Header/>
    <EventList @locationChanged="changedHandler"/>
    <GMap ref="map" />
  </div>
</template>
<style scoped>
  @import "../styles/events.scss";
</style>
<script>

  import Header from "../components/Header";
  import EventList from "../components/EventList";
  import GMap from "../components/GMap"
  export default {
    name: "events",
    components: { Header, EventList, GMap },
    methods: {
      changedHandler: function(event) {
        this.$refs.map.showLocation(event.lat, event.lng);
      }
    } ,

  };




</script>
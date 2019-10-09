<template>
  <div class="events">

    <GMap id="backgroundMap" ref="map" />
    <div class="content">
      <div class="heute-sonst-switch">
        <a v-on:click="changeTypeToToday" v-bind:class="{ active: !heuteActive}"><div id="heute" >HÜT</div></a>
        <a v-on:click="changeTypeToRest" v-bind:class="{ active: heuteActive}"><div id="sonst" >SÜSCH</div></a>
      </div>

      <EventList :type="type" @locationChanged="changedHandler"/>
    </div>
  </div>
</template>
<style scoped>
  @import "../styles/events.scss";
</style>
<script>

  import EventList from "../components/EventList";
  import GMap from "../components/GMap"
  export default {
    name: "events",
    components: { EventList, GMap },
    data: function() {
      return {
        heuteActive: true,
        type: {
          type: String,
          default : "0"
        }
      }
    },
    methods : {
      changeTypeToToday: function() {
        this.heuteActive = true;
        this.type = "0";
      },
      changeTypeToRest: function() {
        this.heuteActive = false;
        this.type = "1";
      },
      changedHandler: function(event) {
        this.$refs.map.showLocation(event.lat, event.lng);
      }

    }
  };
</script>

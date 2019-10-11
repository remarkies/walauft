<template>
  <div class="events">
      <GMap  id="backgroundMap" ref="map" />
      <div v-bind:class="{ hide: hideContent}" class="header">
        <div id="today" class="nav"><a v-on:click="changeTypeToToday" v-bind:class="{ active: !heuteActive}">HÜT</a></div>
          <div class="city"><router-link :to="{name: 'home'}">{{getCurrentCity()}}</router-link></div>
        <div id="all" class="nav"><a v-on:click="changeTypeToRest" v-bind:class="{ active: heuteActive}">SÜSCH</a></div>
      </div>
      <div v-bind:class="{ showMap: showMap }" class="content">
        <EventList :when="when" @locationChanged="changedHandler"/>
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
        when: "0",
        regionen: [
          { id: "2", name: "Luzern" },
          { id: "3", name: "Bern" },
          { id: "4", name: "Basel" },
          { id: "5", name: "St.Gallen" },
          { id: "6", name: "Zürich" }
        ],
        showMap: false,
        hideContent: false
      }
    },
    watch : {
      hideContent : function() {
        console.log("Hide content");
      }
    },
    methods : {
      changeTypeToToday: function() {
        this.heuteActive = true;
        this.when = "0";
      },
      changeTypeToRest: function() {
        this.heuteActive = false;
        this.when = "1";
      },
      changedHandler: function(event) {
        this.$refs.map.showLocation(event.lat, event.lng);
      },
      getCurrentCity: function() {
        let Enumerable = require('../../node_modules/linq');
        let city = Enumerable.from(this.regionen).firstOrDefault($ => $.id === this.$route.params.regionId);
        return city.name;
      },
      handleMap: function() {
        this.showMap = !this.showMap;
        console.log("handle map function");
      },
    },
  };
</script>

<template>
  <div class="events">
      <GMap  id="backgroundMap" ref="map" />
      <div v-bind:class="{ hide: hideContent}" class="header">
        <div id="today" class="nav"><a v-on:click="changeTypeToToday" v-bind:class="{ active: !heuteActive}">HÜT</a></div>
          <div class="city"><router-link :to="{name: 'home'}"><-{{getCurrentCity()}}</router-link></div>
        <div id="all" class="nav"><a v-on:click="changeTypeToRest" v-bind:class="{ active: heuteActive}">SÜSCH</a></div>
      </div>
      <div v-bind:class="{ showMap: showMap, hide: hideContent }" class="content">
        <EventList :when="when" @locationChanged="changedHandler"/>
      </div>

      <div v-if="hideContent" v-on:click="handleMap" class="map-icon">
          <div v-if="showMap" class="icon-text">{{iconText}}</div>
          <img src="../assets/map-icon.svg" alt="map-icon" height="50px" width="50px" />
      </div>
    </div>
</template>
<style scoped>
    @import "../styles/theme.scss";
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
      { id: "2", name: "Luzärn" },
      { id: "3", name: "Bärn" },
      { id: "4", name: "Baasel" },
      { id: "5", name: "St.Galle" },
      { id: "6", name: "Züri" }
        ],
        showMap: false,
        hideContent: false,
        eventSelected: false,
        iconText: ""
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
      },
    },
  };
</script>

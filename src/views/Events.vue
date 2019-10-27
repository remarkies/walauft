<template>
  <div class="events">
      <GMap  id="backgroundMap" ref="map" />
      <div v-bind:class="{ hide: hideContent}" class="header">
          <div class="city"><router-link :to="{name: 'home'}">
              <font-awesome-icon size="1x" id="backRegion" :icon="['fas', 'arrow-left']" />{{getCurrentCity()}}</router-link></div>
          <div class="heute-sonst-switch">
          <div id="today"><a v-on:click="changeTypeToToday" v-bind:class="{ inactive: !heuteInactive, active: heuteInactive}">HÜT</a></div>
        <div id="slash">/</div>
        <div id="all"><a v-on:click="changeTypeToRest" v-bind:class="{ inactive: heuteInactive, active: !heuteInactive}">SÜSCH</a></div>
          </div>
      </div>
      <div v-bind:class="{ showMap: showMap, hide: hideContent }" class="content">
        <EventList :when="when" @locationChanged="changedHandler"/>
      </div>

      <div v-if="hideContent" v-on:click="handleMap" class="map-icon">
          <div v-if="showMap" class="icon-text">
              <font-awesome-icon size="xs" id="backToEventToggle" :icon="['fas', 'arrow-left']" />
              {{iconText}}
          </div>
          <div v-if="!showMap" class="icon-text">
              Map
          </div>
          <div id="map-icon">
              <font-awesome-icon size="4x" :icon="['fas', 'map']" />
          </div>
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
        heuteInactive: true,
        when: "0",
        regionen: [
          { id: "2", name: "LZN" },
          { id: "3", name: "BRN" },
          { id: "4", name: "BSL" },
          { id: "5", name: "SG" },
          { id: "6", name: "ZH" }
        ],
        regionenLong: [
          { id: "2", name: "Lozärn" },
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
        this.heuteInactive = true;
        this.when = "0";
      },
      changeTypeToRest: function() {
        this.heuteInactive = false;
        this.when = "1";
      },
      changedHandler: function(event) {
        this.$refs.map.showLocation(event.lat, event.lng);
      },
      getCurrentCity: function() {
        let Enumerable = require('../../node_modules/linq');
        let city = null;
        if(screen.width > 800) {
          city = Enumerable.from(this.regionenLong).firstOrDefault($ => $.id === this.$route.params.regionId);
        } else {
          city = Enumerable.from(this.regionen).firstOrDefault($ => $.id === this.$route.params.regionId);
        }
        return city.name;
      },
      handleMap: function() {
        this.showMap = !this.showMap;
      },
    },
  };
</script>

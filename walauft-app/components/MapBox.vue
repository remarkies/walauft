<template>
  <div id="map"></div>
</template>

<script lang="ts">
import Vue from "vue";
import { Location } from "~/types/Models";
import mapboxgl from "mapbox-gl";

export default Vue.extend({
  props: {
    location: {
      type: Object as () => Location,
      required: true,
    },
  },
  head() {
    return {
      link: [
        {
          rel: "stylesheet",
          href: "https://api.mapbox.com/mapbox-gl-js/v2.5.0/mapbox-gl.css",
        },
      ],
    };
  },
  mounted() {
    mapboxgl.accessToken =
      "pk.eyJ1Ijoid2FsYXVmdCIsImEiOiJja3Vucm8zbHExcTM3MnBydm1kd2d1NjF1In0.ucJ1HzfmupdjVWLSnsiPZg";
    const map = new mapboxgl.Map({
      container: "map", // container ID
      style: "mapbox://styles/walauft/ckusewei54zsv17mrg8ecvu59", // style URL
      center: [this.location.longitude, this.location.latitude], // starting position [lng, lat]
      zoom: 12, // starting zoom
      //attributionControl: false, //mabybe illegal
    });

    const geojson = {
      type: "FeatureCollection",
      features: [
        {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [this.location.longitude, this.location.latitude] as [
              number,
              number
            ],
          },
        },
      ],
    };
    for (const { geometry } of geojson.features) {
      // create a HTML element for each feature
      const el = document.createElement("img");
      el.src = require("@/static/marker.svg");
      // el.innerText =  "genau da"; //this.location.name as string;
      // el.innerHTML = document.createElement("img").src = require("@/static/marker.svg")

      // make a marker for each feature and add to the map
      new mapboxgl.Marker(el).setLngLat(geometry.coordinates).addTo(map);
    }
    // new mapboxgl.Marker()
    //   .setLngLat([this.location.longitude, this.location.latitude])
    //   .addTo(map);
    // console.log(map);
  },
});
</script>
<style lang="scss">
#map {
  height: 100%;
  min-height: 20rem;
  max-height: 40rem;

  flex-grow: 1;
  margin-left: 1rem;
  margin-right: 1rem;
  margin-bottom: 3rem;

  @media screen and (max-width: 480px) {
    margin: 0 -1.2rem;
  }
}
.mapboxgl-marker {
  cursor: grab !important;
  height: 6rem;
}
</style>
<template>
    <div class="gmap"></div>
</template>

<script>

  import gmapsInit from "../services/gmaps.js";

  export default {
    name: "gmap",
    methods: {
      showLocation: function(lat, lang) {
        let position = new google.maps.LatLng(lat, lang);
        console.log(lat, lang);
        this.map.panTo(position);
        let marker = new google.maps.Marker({
          position: position,
          icon: "myicon.png",
          map: this.map,

        });


        ;
      }

    },
    async mounted() {
      const locations = [
        { //Luzern id 2
          position: {
            lat: 47.049026,
            lng: 8.308846
          }
        },
        { //Bern id 3
          position: {
            lat: 46.946367,
            lng: 7.444112
          }
        },
        { //Basel id 4
          position: {
            lat: 47.549363,
            lng: 7.589188
          }
        },

        { //SANGALLE! id 5
          position: {
            lat: 47.424854,
            lng: 9.376589
          }
        },
        { //Zürich id 6
          position: {
            lat: 47.380134,
            lng: 8.527955
          }
        }
      ];


      //console.log(locations[this.$route.params.regionId-2].position.lng);
      try {
        const google = await gmapsInit();
        const element = this.$el;
        const options = {
          zoom: 14,
          center: new google.maps.LatLng(locations[this.$route.params.regionId - 2].position)
        };
        this.map = new google.maps.Map(element, options);

      } catch (error) {
        console.error(error);
      }
    }
  };
</script>

<style scoped>
    .gmap {
        width: 100vw;
        height: 100vh;
    }
</style>
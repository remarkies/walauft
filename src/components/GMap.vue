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
        setMapOnAll(null);
        let marker = new google.maps.Marker({
          position: position,
         // icon: "myicon.png",
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
        const styles =
          [
            {
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#212121"
                }
              ]
            },
            {
              "elementType": "labels",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
            {
              "elementType": "labels.icon",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
            {
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "elementType": "labels.text.stroke",
              "stylers": [
                {
                  "color": "#212121"
                }
              ]
            },
            {
              "featureType": "administrative",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "featureType": "administrative.country",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#9e9e9e"
                }
              ]
            },
            {
              "featureType": "administrative.land_parcel",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
            {
              "featureType": "administrative.locality",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#bdbdbd"
                }
              ]
            },
            {
              "featureType": "administrative.neighborhood",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
            {
              "featureType": "poi",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "featureType": "poi.park",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#181818"
                }
              ]
            },
            {
              "featureType": "poi.park",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#616161"
                }
              ]
            },
            {
              "featureType": "poi.park",
              "elementType": "labels.text.stroke",
              "stylers": [
                {
                  "color": "#1b1b1b"
                }
              ]
            },
            {
              "featureType": "road",
              "elementType": "geometry.fill",
              "stylers": [
                {
                  "color": "#2c2c2c"
                }
              ]
            },
            {
              "featureType": "road",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#8a8a8a"
                }
              ]
            },
            {
              "featureType": "road.arterial",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#373737"
                }
              ]
            },
            {
              "featureType": "road.highway",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#3c3c3c"
                }
              ]
            },
            {
              "featureType": "road.highway.controlled_access",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#4e4e4e"
                }
              ]
            },
            {
              "featureType": "road.local",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#616161"
                }
              ]
            },
            {
              "featureType": "transit",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#757575"
                }
              ]
            },
            {
              "featureType": "water",
              "elementType": "geometry",
              "stylers": [
                {
                  "color": "#000000"
                }
              ]
            },
            {
              "featureType": "water",
              "elementType": "labels.text.fill",
              "stylers": [
                {
                  "color": "#3d3d3d"
                }
              ]
            }
          ];
        const options = {
          zoom: 14,
          center: new google.maps.LatLng(locations[this.$route.params.regionId - 2].position),
          styles: styles,
          zoomControl: false,
          mapTypeControl: false,
          scaleControl: false,
          streetViewControl: false,
          rotateControl: false,
          fullscreenControl: false
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
        height: calc(100vh + 25px);
    }
</style>
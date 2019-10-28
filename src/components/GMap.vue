<template>
    <div class="gmap"></div>
</template>

<script>

  import gmapsInit from "../services/gmaps.js";

  export default {
    name: "gmap",
    data: function() {
      return {
        markers: []
      }
    },
    methods: {
      showOwnLocation: function(map, markers) {

        var icon = {
          path: 'M-10,0a20,20 0 1,0 40,0a20,20 0 1,0 -40,0',
          fillColor: '#FFF',
          fillOpacity: 1,
          anchor: new google.maps.Point(0,0),
          strokeWeight: 0,
          scale: 0.5
        };

        var options = {
          enableHighAccuracy: true,
          timeout: 5000,
          maximumAge: 0
        };

        function success(pos) {
            var crd = pos.coords;
            let ownLoc = new google.maps.Marker({
                position: new google.maps.LatLng(crd.latitude, crd.longitude),
                //animation: google.maps.Animation.DROP,
                icon: icon,
                map: map
            });

            if(markers.length >= 2)
                markers[1] = ownLoc;
            else
                markers.push(ownLoc);

              var bounds = new google.maps.LatLngBounds();
              for (var i = 0; i < markers.length; i++) {
                bounds.extend(markers[i].getPosition());
              }

              //map.fitBounds(bounds);
        }

        function error(err) {
          console.warn(`ERROR(${err.code}): ${err.message}`);
        }

        navigator.geolocation.getCurrentPosition(success, error, options);

      },
      showLocation: function(lat, lang) {
        for (var i = 0; i < this.markers.length; i++) { //delets all markers
          this.markers[i].setMap(null);
        }
        let position = new google.maps.LatLng(lat, lang);


        var icon = {
          path: 'M172.268 501.67C26.97 291.031 0 269.413 0 192 0 85.961 85.961 0 192 0s192 85.961 192 192c0 77.413-26.97 99.031-172.268 309.67-9.535 13.774-29.93 13.773-39.464 0zM192 272c44.183 0 80-35.817 80-80s-35.817-80-80-80-80 35.817-80 80 35.817 80 80 80z',
          //path: 'M436 480h-20V24c0-13.255-10.745-24-24-24H56C42.745 0 32 10.745 32 24v456H12c-6.627 0-12 5.373-12 12v20h448v-20c0-6.627-5.373-12-12-12zM128 76c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40c0 6.627-5.373 12-12 12h-40c-6.627 0-12-5.373-12-12V76zm0 96c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40c0 6.627-5.373 12-12 12h-40c-6.627 0-12-5.373-12-12v-40zm52 148h-40c-6.627 0-12-5.373-12-12v-40c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40c0 6.627-5.373 12-12 12zm76 160h-64v-84c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v84zm64-172c0 6.627-5.373 12-12 12h-40c-6.627 0-12-5.373-12-12v-40c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40zm0-96c0 6.627-5.373 12-12 12h-40c-6.627 0-12-5.373-12-12v-40c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40zm0-96c0 6.627-5.373 12-12 12h-40c-6.627 0-12-5.373-12-12V76c0-6.627 5.373-12 12-12h40c6.627 0 12 5.373 12 12v40z',
          fillColor: '#fff',
          fillOpacity: 1,
          anchor: new google.maps.Point(0,0),
          strokeWeight: 0,
          scale: 0.06,
        };

        if(lat > 0){
            this.map.panTo(position);

           // console.log("marker wird gesetzt");

            let marker = new google.maps.Marker({
              position: position,
              //animation: google.maps.Animation.DROP,
              icon: icon,
              map: this.map,
            });
            this.markers.push(marker);
        }
        this.showOwnLocation(this.map, this.markers);
      }

    },
    async mounted() {
      const locations = [
        { //Luzern id 2

          position: {
            lat: 47.049026,
            lng: 8.308846,
            color: "#2973a6"
          }
        },
        { //Bern id 3
          position: {
            lat: 46.946367,
            lng: 7.444112,
            color: "#a69029"
          }
        },
        { //Basel id 4
          position: {
            lat: 47.549363,
            lng: 7.589188,
            color: "#a62c29"
          }
        },

        { //SANGALLE! id 5
          position: {
            lat: 47.424854,
            lng: 9.376589,
            color: "#29a74e"
          }
        },
        { //Zürich id 6
          position: {
            lat: 47.380134,
            lng: 8.527955,
            color: "#29a6a5"
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
                },
                {
                  "visibility": "off"
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
              "stylers": [
                {
                  "color": "#515151"
                },
                {
                  "weight": 0.5
                }
              ]
            },
            {
              "featureType": "road",
              "elementType": "labels.icon",
              "stylers": [
                {
                  "visibility": "off"
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
              "stylers": [
                {
                  "color": "#ffffff"
                },
                {
                  "weight": 0.5
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
              "elementType": "geometry.fill",
              "stylers": [
                {
                  "color": locations[this.$route.params.regionId - 2].position.color,
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
          ]
        ;
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
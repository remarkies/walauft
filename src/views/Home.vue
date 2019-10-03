<template>
  <div class="home">
    <div id="map"></div>
  </div>
</template>
<style lang="scss">
    @import '../styles/home.sass';
</style>
<script>
  //  import Vue from "Vue";
  export default {
    name: "home",
    data:
      function() {
        return {
          regionen: [
            { id: "2", name: "Luzern" },
            { id: "3", name: "Bern" },
            { id: "4", name: "Basel" },
            { id: "5", name: "St.Gallen" },
            { id: "6", name: "Zürich" }
          ]
        };
      }
    ,
    components: {}


    this.map = new google.maps.Map(element, options);
  }
};
</script>

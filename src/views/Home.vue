
<template>
  <div class="home">
      <ul>
          <li v-for="region in regionen"><router-link :to="{name: 'events', params: {regionId: region.id}}">{{region.name}}</router-link></li>
      </ul>
  </div>
</template>
<style lang="scss">
    @import '../styles/home.scss';
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

};
</script>

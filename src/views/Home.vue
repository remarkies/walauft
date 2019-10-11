<template>
    <div class="home">
        <div class="title">WALAUFT </div>
        <div class="title2"> IN </div>
        <ul>
            <li v-for="region in regionen">
                <router-link :to="{name: 'events', params: {regionId: region.id}}">{{region.name}}</router-link>
            </li>
        </ul>
    </div>
</template>
<style lang="scss">
    @import '../styles/home.scss';
</style>
<script scoped>
  //  import Vue from "Vue";
  export default {
    name: "home",
    data:
      function() {
        return {
          regionen: [
            { id: "2", name: "Lozärn" },
            { id: "3", name: "Bärn" },
            { id: "4", name: "Baasel" },
            { id: "5", name: "St.Galle" },
            { id: "6", name: "Züri" }
          ]
        };
      }

  };
</script>

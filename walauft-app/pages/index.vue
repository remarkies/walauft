<template>
  <div id="cities">
    <NuxtLink v-for="city in cities" :key="city.id" :to="'/' + city.name">
      {{ city.name }}
    </NuxtLink>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import citiesObj from "@/static/cities.js";

export default Vue.extend({
  data() {
    return {
      cities: citiesObj.cityIdName,
    };
  },
  
});
</script>
<style lang="scss">

#cities {
    display: flex;
    flex-direction: column;
    font-size: 10vw;
    font-variation-settings: "wght" 200;
    a:hover {
        transition: all 0.3s ease-in-out;
        font-variation-settings: "wght" 500;
    }
}

</style>
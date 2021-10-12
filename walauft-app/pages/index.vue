<template>
  <div id="cities">
    <NuxtLink v-for="city in cities" :key="city.id" :to="'in/' + city.name">
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
<style lang="scss" scoped>
#cities {
  display: flex;
  flex-direction: column;
}
</style>
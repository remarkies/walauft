<template>
  <div>
    <input type="search" name="search" id="" v-model="searchTerm" />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mapActions } from "vuex";

export default Vue.extend({
  data() {
    return {
      searchTerm: "",
    };
  },
  watch: {
    searchTerm(newTerm) {
      console.log(newTerm);
      
      this.$store.dispatch("events/setSearchTerm", newTerm);
    },
  },
  methods: {
    ...mapActions({
      toggleTag: "tags/toggleTag",
    }),
  },
});
</script>
<style lang="scss" scoped>
input {
}
</style>
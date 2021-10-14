<template>
  <div>
    <input type="search" name="search" id="" v-model="searchString" />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import { mapActions } from "vuex";

export default Vue.extend({
  data() {
    return {
      searchString: "",
    };
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
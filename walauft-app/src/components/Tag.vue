<template>
    <div v-bind:class="{ selected: selected }" class="tag">{{tag}}</div>
</template>

<script>
  export default {
    name: "Tag",
    props: {
      tag: String,
      selected: Boolean
    },
    watch: {
      tag: function(newVal) {
      },

    }
  };
</script>

<style lang="scss" scoped>
    @import "../styles/tag.scss";
</style>
<template>
    <div class="tag">{{tag}}</div>
</template>

<script>
  export default {
    name: "Tag",
    props: {
      tag: String
    },
    watch: {
      tag: function(newVal) {
      }
    }
  };
</script>

<style scoped>
    @import "../styles/tag.scss";
</style>
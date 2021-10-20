<template>
  <main id="main" ref="main">
    <Nuxt />
  </main>
</template>

<style lang="scss" scoped>
#main {
  padding: 0.75rem;
  max-width: 40rem;
  margin: 0 auto;
}
</style>
<script lang="ts">
import Vue from "vue";
export default Vue.extend({});
</script>
<style lang="scss" >
.slide-left-enter-active {
  transition: all 0.3s cubic-bezier(0.000, 0.970, 0.250, 0.935);
}

.slide-left-enter {
  // transform: translate3d(100vw, 0, 0);
  transform: translateX(100vw);

}
// .slide-left-leave-active {
// transition: all 0.1s ease;

// }
// .slide-left-leave-to {
//   transform: translate3d(-100vw, 0, 0);
// }

// .slide-right-enter-active {
//   transition: all 0.2s ease;
// }
// .slide-right-leave-active {
//   transform: translate3d(-100vw, 0, 0);
// }
// .slide-right-enter,
// .slide-right-leave-to {
//   opacity: 0;
// }
</style>
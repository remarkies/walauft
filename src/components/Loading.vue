<template>
    <div>
    <lottie class="loadingAnim" :options="defaultOptions"/>
    </div>
    <!--<div class="sk-cube-grid">
        <div>wart schnell</div>
        <div class="sk-cube sk-cube1"></div>
        <div class="sk-cube sk-cube2"></div>
        <div class="sk-cube sk-cube3"></div>
        <div class="sk-cube sk-cube4"></div>
        <div class="sk-cube sk-cube5"></div>
        <div class="sk-cube sk-cube6"></div>
        <div class="sk-cube sk-cube7"></div>
        <div class="sk-cube sk-cube8"></div>
        <div class="sk-cube sk-cube9"></div>
        <div>chunt gad</div>
    </div>-->
</template>

<script>
  import Lottie from "vue-lottie";
  import * as animationData from '../assets/loadingAnim.json';
  export default {
    name: "Loading",
    components: {Lottie},
    data(){
    return {
      defaultOptions: {
        animationData: animationData.default,
        renderer: 'svg',
        loop: true,
        autoplay: true
      },
      animationSpeed: 1
    }
    }
  };
</script>

<style lang="scss" scoped>
    @import "../styles/loading.scss";
</style>
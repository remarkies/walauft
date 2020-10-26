<template>
  <div id="app">
    <transition name="slide-to-right">
    <router-view />
    </transition>
  </div>
</template>

<style lang="scss">
  .slide-to-right-enter-active, .slide-to-right-leave-active {
    transition: opacity 0.3s ease-in-out; transition: transform 0.3s ease-in-out;
    .city{
      transition: opacity 0.5s 0.3s ease-in-out;
    }
  }
  .slide-to-right-enter-active{
    transition-delay: 0.3s;
  }
  .slide-to-right-enter{
    .city{
      opacity: 0;
    }
    opacity: 0;
  transform: translateX(100%);
  }
  .slide-to-right-leave-to{

    transform: translateX(-100%);
  }
  .slide-to-right-enter-to, slide-to-right-leave{
    .city{
      opacity: 1;
    }
    opacity: 1;
    transform: translateX(0%);
  }



#app {
  @import 'styles/theme.scss';

  @import 'styles/tooltip';
    @import url('https://fonts.googleapis.com/css?family=Varela+Round&display=swap');
    @import url('https://fonts.googleapis.com/css?family=IBM+Plex+Mono&display=swap');

    * {
        font-family: 'Varela Round', sans-serif;
    }
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  font-family: $fontfamily1;

}
#nav {
  padding: 30px;
  a {
    font-weight: bold;
    color: #2c3e50;
    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>

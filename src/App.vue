<template>
  <div id="app">
 <!-- <div id="nav">
      <router-link to="/">Home</router-link> |
      <router-link to="/events">Events</router-link>
    </div> -->

    <router-view />
  </div>
</template>

<style lang="scss">
#app {
  @import 'styles/theme.scss';
    @import url('https://fonts.googleapis.com/css?family=Abel&display=swap');
    @import url('https://fonts.googleapis.com/css?family=Open+Sans&display=swap');
    @import url('https://fonts.googleapis.com/css?family=Open+Sans+Condensed:300&display=swap');
    @import url('https://fonts.googleapis.com/css?family=Unica+One&display=swap');
    @import url('https://fonts.googleapis.com/css?family=IBM+Plex+Mono&display=swap');
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

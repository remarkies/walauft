<template>
  <div id="app">
    <router-view />
  </div>
</template>

<style lang="scss">
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

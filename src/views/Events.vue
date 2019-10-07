<template>
  <div class="Events">
    <div class="heute-sonst-switch">
      <a v-on:click="changeTypeToToday"><div id="heute" >hüt</div></a>
      <a v-on:click="changeTypeToRest"><div id="sonst" >süsch</div></a>
    </div>

    <Header/>
    <EventList :type="type" />
  </div>
</template>
<style scoped>
  @import "../styles/events.scss";
</style>
<script>
  import Header from "../components/Header";
  import EventList from "../components/EventList";

  export default {
    name: "events",
    components: { Header, EventList },
    data: function() {
      return {
        type: {
          type: String,
          default : "0"
        }
      }
    },
    methods : {
      changeTypeToToday: function() {
        this.type = "0";
      },
      changeTypeToRest: function() {
        this.type = "1";
      }

    }
  };
</script>
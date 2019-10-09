<template>
    <div class="event">
        <div class="event-name">{{event.name}}</div>
        <div class="event-desc-container">

                <div class="club">{{event.location.name}}</div>
                <div class="zeit">{{event.start}}</div>

            <div class="genres">
                <Tag :tag="genre" v-for="genre in splitGenres(event.musicstyles)"/>
            </div>
        </div>
    </div>
</template>

<script>
  import Tag from "./Tag";
  export default {
    name: "Event",
    components: { Tag },
    props: {
      event: {}
    },
    methods: {
      splitGenres: function(genres) {
        let splitted = genres.split(',');

        let res = [];
        splitted.forEach(o => {
          o.trimRight();

          if(o.length > 0)
            res.push(o);
        });
        return res;
      }
    }
  };
</script>

<style lang="scss" scoped>
    @import "../styles/event.scss";
</style>

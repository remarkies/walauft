<template>
    <div class="event">
        <div class="dates">
            <div class="weekday">{{getWeekday(event.date)}}</div>
            <div class="datum">{{getDate(event.date)}}</div>
        </div>
        <div>
        <div class="event-name">{{event.name}}</div>
            <div class="event-desc-container">

                    <div class="club">{{event.location.name}}</div>
                    <div class="zeit">{{event.start}}</div>

                <div class="genres">
                    <Tag :tag="genre" v-for="genre in splitGenres(event.musicstyles).slice(0,2)"/>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
  import Tag from "./Tag";

  import moment from "moment";
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
      },
      getWeekday: function(date) {
        return moment(date).format("ddd").toUpperCase();
      },
      getDate: function(date) {
        return moment(date).format("DD.MM");
      }
    }
  };
</script>

<style lang="scss" scoped>
    @import "../styles/event.scss";
</style>

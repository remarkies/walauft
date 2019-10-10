<template>
    <div v-bind:class="{ selected: selected }" v-on:click="handleSelect" class="event">
        <div v-if="selected" class="event-content">

            <div class="date-info">
                <div class="week-date">{{getWeekday(event.date)}}</div>
                <div class="date-rotate">
                    <div class="start">{{event.start}}</div>
                    <div class="date">{{getDateDetail(event.date)}}</div>
                </div>
            </div>
            <div class="info1">
                <div class="name">{{event.name}}</div>

                <div class="location-name"><a v-bind:href="event.location.url">{{event.location.name}}</a></div>
                <div v-if="areActsAvailable(event.acts)" class="acts-desc">Acts</div>
                <div v-if="areActsAvailable(event.acts)" class="acts">{{event.acts}}</div>
                <div class="genres">
                    <Tag :tag="genre" v-for="genre in splitGenres(event.musicstyles)"/>
                </div>

                <div class="text">{{event.text}}</div>

                <div class="extra-info">
                    <Tag v-if="isAgeAvailable(event.getMinAge)" :tag="getMinAge(event.getMinAge)"></Tag>
                    <Tag v-if="isPriceAvailable(event.price)" :tag="getPrice(event.price)"></Tag>
                </div>

            </div>

        </div>


        <div v-if="!selected" class="event-content">
            <div class="dates">
                <div class="weekday">{{getWeekday(event.date)}}</div>
                <div class="datum">{{getDate(event.date)}}</div>
            </div>
            <div>
                <div class="event-title">{{event.name}}</div>
                <div class="event-desc-container">

                    <div class="club">{{event.location.name}}</div>
                    <div class="zeit">{{event.start}}</div>
                    <div class="genres">
                        <Tag :tag="genre" v-for="genre in splitGenres(event.musicstyles).slice(0,2)"/>
                    </div>
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
    data: function() {
      return { selected: false }
    },
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
        let weekday = moment(date).locale("de-CH");
        return weekday.format("ddd").toUpperCase();
      },
      getDate: function(date) {
        return moment(date).format("DD.MM");
      },
      handleSelect: function() {
        this.selected = !this.selected;

      },
      getDateDetail: function(date) {
        return moment(date).locale("de-CH").format("DD. MMM")
      },
      getMinAge: function(age) {
        return age + "+";
      },
      isAgeAvailable: function(age) {
        if(age === undefined)
          return false;
        else
          return true;
      },
      getPrice: function(price) {
        return price + " Höde";
      },
      areActsAvailable: function(acts) {
        if(acts === "")
          return false;
        else
          return true;
      },
      isPriceAvailable: function(price) {
        if(price === "0.00" || price === "")
          return false;
        else
          return true;
      }
    }

  };
</script>

<style lang="scss" scoped>
    @import "../styles/event.scss";
</style>

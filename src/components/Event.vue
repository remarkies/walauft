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
                    <div class="acts-desc">Club</div>
                    <div class="location-name"><font-awesome-icon size="xs" class="pre-icon" :icon="['fas', 'building']" />{{event.location.name}}</div>
                    <div v-if="areActsAvailable(event.acts)" class="acts-desc">Acts</div>
                    <div v-if="areActsAvailable(event.acts)" class="acts"><font-awesome-icon class="pre-icon" size="xs" :icon="['fas', 'user']" />{{event.acts}}</div>
                    <div class="genres">
                        <Tag @click.native="tagClick(genre)"  :tag="genre" v-for="genre in splitGenres(event.musicstyles)"/>
                    </div>

                    <div class="text">{{event.text}}</div>

                    <div class="extra-info">
                        <Tag v-if="isAgeAvailable(event.getMinAge)" :tag="getMinAge(event.getMinAge)"></Tag>
                        <Tag v-if="isPriceAvailable(event.price)" :tag="getPrice(event.price)"></Tag>
                    </div>

                </div>
            <div class="icon">
                <font-awesome-icon size="2x" :icon="['fas', 'times']" />
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
  import Events from "../views/Events";


  export default {
    name: "Event",
    components: { Events, Tag },
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

        this.$parent.$parent.hideContent = this.selected;
        this.$parent.$parent.iconText = this.event.location.name;

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
      },
      tagClick: function(subGenre) {
        let parentGenreText = this.$parent.getParentGenre(subGenre)[1];
        let parentGenre = null;
        this.$parent.genres.forEach(o => {

          if(o[0][1].trimLeft().trimRight().toUpperCase() === parentGenreText.trimLeft().trimRight().toUpperCase()) {
            parentGenre = o;
          }
        });
        if(parentGenre !== null)
            this.$parent.tagClick(parentGenre);
      }
    }

  };
</script>

<style lang="scss" scoped>
    @import "../styles/event.scss";
</style>

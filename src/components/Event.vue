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
                    <div class="location">
                        <div class="location-name">
                            <font-awesome-icon size="xs" class="pre-icon" :icon="['fas', 'building']" />{{event.location.name}}</div>

                    </div>
                    <div v-if="areActsAvailable(event.acts)" class="acts-desc">Acts</div>
                    <div v-if="areActsAvailable(event.acts)" class="acts"><font-awesome-icon class="pre-icon" size="xs" :icon="['fas', 'user']" />{{removeDJs(event.acts)}}</div>
                    <div class="genres">
                        <Tag class="detailTag" v-bind:class="{tagSelected: genre[1]}" @click.native="tagClick(genre[0])"  :tag="genre[0]" v-for="genre in selectGenres(splitGenres(event.musicstyles))"/>
                    </div>

                    <div class="text">{{event.text}}</div>

                    <div class="extra-info">
                        <Tag class="eventTagHead" v-if="isAgeAvailable(event.minage)" :tag="getMinAge(event.minage)"></Tag>
                        <Tag class="eventTagHead" v-if="isPriceAvailable(event.price)" :tag="getPrice(event.price)"></Tag>
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
                        <Tag class="eventTagHead" :tag="genre" v-for="genre in getShortetGenres(splitGenres(event.musicstyles))"/>
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
      return {
        selected: false,
        selectedCity: ""
      }
    },
    props: {
      event: {}
    },
    methods: {

      splitGenres: function(genres) {
        console.log(this.event);
        let splitted = genres.split(',');

        let res = [];
        splitted.forEach(o => {
          o.trimRight();

          if(o.length > 0)
            res.push(o);
        });
        return res;
      },
      selectGenres: function(genres) {

        let array = [];
        genres.forEach(o => {
          let parentGenre = this.$parent.getParentGenre(o);

          let isSelected = false;
          this.$parent.genres.forEach(x => {
            if(x[0] === parentGenre) {
              isSelected = x[1];
            }
          });


          array.push([o , isSelected]);

        });

        return array;
      },
      getShortetGenres: function(genres) {
        let array = [];


        let index = 0;
        let textLength = 1;
        let noEnoughSpace = false;
        genres.forEach(o => {
          if(screen.width / (textLength + this.event.location.name.length) > 25  || screen.width > 800) {
            array.push(o);
            textLength += o.length + 2;
          } else {
            if(!noEnoughSpace) {
                array.push("...");
                noEnoughSpace = true;
            }
          }
          index++;
        });

        if(array.length === 0)
          array.push("Unbekannt");

        return array;
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
        if(age === undefined || age === "")
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
      },
      removeDJs(value){

        if (value === undefined || value === null || value.length === 0) { return '';}

        if (value.startsWith('DJs')){
          return value.replace(/DJs/, '');
        } else {
          return value;
        }
      }
    },
    mounted: function() {
      this.selectedCity = this.$parent.$parent.getCurrentCity();
    }

  };
</script>

<style lang="scss" scoped>
    @import "../styles/event.scss";
</style>

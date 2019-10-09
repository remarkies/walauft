<template>
    <div class="event-list">
        <p>Selected genres</p>
        <div class="selected-genres">
            <Tag @click.native="tagClick(genre)" :tag="genre" v-for="genre in selectedGenres"/>
        </div>
        <p>Available genres</p>
        <div class="genres">
            <Tag @click.native="tagClick(genre)" :tag="genre" v-for="genre in genres"/>
        </div>
        <Event @click.native="eventClick(event.fields.json.location.latitude, event.fields.json.location.longitude)" :event="event.fields.json" v-for="event in filteredEvents" />
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEntries } from "../services/api";
  import moment from "moment";
  import Tag from "./Tag";


  export default {
    name: "EventList",
    methods: {
      eventClick: function(latitude, longitude) {
        this.$emit('locationChanged', {lat: latitude, lng: longitude});
       console.log(latitude, longitude);
      },
      tagClick: function(tag) {
        let Enumerable = require('../../node_modules/linq');
        if(!Enumerable.from(this.selectedGenres).any($ => $ === tag)){
          this.selectedGenres.push(tag);
        }
        else {
          for(let i = 0; i < this.selectedGenres.length; i++) {
            if(this.selectedGenres[i] === tag) {
              this.selectedGenres.splice(i,1);
            }
          }
        }
      },
      genreComparer: function(musicstyles) {
        if(this.selectedGenres.length > 0) {
          let foundGenre = false;

          this.selectedGenres.forEach(o => {
            if(musicstyles.toUpperCase().includes(o.toUpperCase()))
              foundGenre = true;
          });


          return foundGenre;

        } else {
          return true;
        }
      }
    },
    data: function() {
      return {
        events: [],
        filteredEvents: [],
        genres: [],
        selectedGenres: []
      }
    },
    components: {
      Tag,
      Event
    },
    props: {
      type: String
    },
    watch: {
      selectedGenres: async function() {
        let Enumerable = require('../../node_modules/linq');
        this.filteredEvents = Enumerable.from(this.events).where($ => this.genreComparer($.fields.json.musicstyles))
          .orderBy($ => $.fields.json.date && $.fields.json.name).toArray();
      },
      type: async function(newVal) {
        let Enumerable = require('../../node_modules/linq');
        let result = await getEntries(this.$route.params.regionId);
        this.genres = [];

        if(newVal == "0")
          this.events = Enumerable.from(result.items)
            .where($ => $.fields.json.date == moment().add(-10, 'hours').format('YYYY-MM-DD'))
            .orderBy($ => $.fields.json.date && $.fields.json.name).toArray();
        else if(newVal == "1")
          this.events = Enumerable.from(result.items)
            .where($ => moment($.fields.json.date).add(-1, 'day').isAfter(moment()))
            .orderBy($ => $.fields.json.date && $.fields.json.name).toArray();


        try {
          this.events.forEach(o => {
            let eventGenres = o.fields.json.musicstyles.split(',');
            eventGenres.forEach(eventGenre => {
              let trimmedGenre = eventGenre.trimRight();
              if(!Enumerable.from(this.genres).any($ => $ === trimmedGenre) && trimmedGenre.length > 0)
                this.genres.push(eventGenre.trimRight());
            });
          });
        } catch(exception) {
          console.log("Could not fetch genres from events! Message: " + exception);
        }

        this.filteredEvents = this.events;
      }
    },
    mounted: function() {
        this.type = "0";
    }
  };



</script>

<style scoped>
    @import "../styles/eventList.scss";
</style>

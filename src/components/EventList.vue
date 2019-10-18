<template>
    <div class="event-list">
        <div class="genres">
            <Tag class="filter" @click.native="tagClick(genre)" :selected="genre[1]" :tag="genre[0][1]" v-for="genre in genres"/>
        </div>
        <Event @click.native="eventClick(event.location.latitude, event.location.longitude)" :event="event" v-for="event in filteredEvents" />
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEvents } from "../services/api";
  import moment from "moment";
  import Tag from "./Tag";


  export default {
    name: "EventList",
    methods: {
      eventClick: function(latitude, longitude) {
        this.$emit('locationChanged', {lat: latitude, lng: longitude});
      },
      tagClick: function(genre) {

        let index = -1;
        for(let i = 0; i < this.genres.length; i++) {
          if(this.genres[i] === genre)
            index = i;
        }
        genre[1] = !genre[1];
        this.$set(this.genres, index, genre);
      },
      genreComparer: function(musicstyles) {
        let Enumerable = require('../../node_modules/linq');
        if(this.genres.length > 0) {
          let foundGenre = false;

          if(Enumerable.from(this.genres).any($ => $[1] === true)) {
            Enumerable.from(this.genres).where($ => $[1] === true).forEach(o => {

              let styles = musicstyles.split(',');
              styles.forEach(s => {
                s = s.trimLeft().trimRight();
                if (o[0][1].toUpperCase() === this.getParentGenre(s)[1].toUpperCase())
                  foundGenre = true;
              });
            });
          } else {
            foundGenre = true;
          }


          return foundGenre;

        } else {
          return true;
        }
      },
      getParentGenre: function(child) {
        let Enumerable = require('../../node_modules/linq');


        let parent = Enumerable.from(this.genresOverall).firstOrDefault($ => $[2].toUpperCase().includes(child.toUpperCase()));
        if(parent === undefined) {

          parent = this.genresOverall[5];
        }

        return parent;
      },
      compareDates: function ( a, b ) {
        return moment(a.date, "YYYY-MM-DD").format('YYYYMMDD') - moment(b.date, "YYYY-MM-DD").format('YYYYMMDD');
      },
      updateEvents: async function() {
        let Enumerable = require('../../node_modules/linq');

        this.genres = [];

        this.events = await getEvents(this.$route.params.regionId, this.when);

        this.filteredEvents = this.events;

        //this.events = Enumerable.from(this.events).where($ => $.fields.json.location.longitude !== "-1" && $.fields.json.location.latitude !== "-1").toArray();

        try {
          this.events.forEach(o => {
            let eventGenres = o.musicstyles.split(',');
            eventGenres.forEach(eventGenre => {
              let trimmedGenre = eventGenre.trimRight().trimLeft();

              if(!Enumerable.from(this.genres).any($ => $[0][1] === this.getParentGenre(trimmedGenre)[1]) && trimmedGenre.length > 0) {


                this.genres.push([this.getParentGenre(trimmedGenre), false]);
              }
            });
          });
        } catch(exception) {
          console.log("Could not fetch genres from events! Message: " + exception);
        }

      }
    },
    data: function() {
      return {
        events: [],
        filteredEvents: [],
        genres: [],
        genresOverall: [
          [1, "Chlöpft & Tätscht", "Tech House,Techno,Elektr. Musik,Deep House,House,Electro Swing"],
          [2, "Gitarre Gschmäus", "Indie Rock,Rock,Metal"],
          [3, "Gangster", "Rap,Urban,Hip Hop,Trap,Oldschool,R'n'B"],
          [4, "Radio Musik", "80's,90's,Singer/Songwriter,Partytunes,Pop,Club Classics,90's,Disco,Hits,Worldmusic,Schlager,Volksmusik"],
          [5, "Ab uf Südamerika", "Reggae,Dancehall,Salsa,Afro Beats,Funk,Reggaeton,Latin"],
          [6, "Restliche Gugus", "Soul,Jazz,Diverses"]
        ],

      }
    },
    components: {
      Tag,
      Event
    },
    props: {
      when: String
    },
    watch: {
      genres: async function() {
        let Enumerable = require('../../node_modules/linq');
        this.filteredEvents = Enumerable.from(this.events).where($ => this.genreComparer($.musicstyles)).toArray();

      },
      when: function() {
        this.events = null;
        this.updateEvents();
      }
    },
    mounted: function() {
        this.updateEvents();
    }
  };



</script>

<style lang="scss" scoped>
    @import "../styles/eventList.scss";
</style>

<template>
    <div class="event-list">
        <div class="genres">
            <Tag class="filter" @click.native="tagClick(genre)" :selected="genre[1]" :tag="genre[0][1]" v-for="genre in genres"/>
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
      type: String
    },
    watch: {
      genres: async function() {
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


        //this.events = Enumerable.from(this.events).where($ => $.fields.json.location.longitude !== "-1" && $.fields.json.location.latitude !== "-1");

        try {
          this.events.forEach(o => {
            let eventGenres = o.fields.json.musicstyles.split(',');
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

        this.filteredEvents = this.events;
      }
    },
    mounted: function() {
        this.type = "0";
    }
  };



</script>

<style lang="scss" scoped>
    @import "../styles/eventList.scss";
</style>

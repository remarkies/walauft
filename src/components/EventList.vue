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
        selectedGenres: [],
        genresOverall: [
          [1, "Chlöpft & Tätscht", "Deep House,House"],
          [2, "Gitarre Gschmäus"],
          [3, "Gangster"],
          [4, "Radio Musik"],
          [5, "Ab uf Südamerika"],
          [6, "Restliche Gugus", "Elektr. Musik" +
          "1: \"\"\n" +
          "2: \"\"\n" +
          "3: \"\"\n" +
          "4: \"\"\n" +
          "5: \" Hits\"\n" +
          "6: \" Worldmusic\"\n" +
          "7: \"Diverses\"\n" +
          "8: \"Schlager\"\n" +
          "9: \" Volksmusik\"\n" +
          "10: \"Afro Beats\"\n" +
          "11: \" Disco\"\n" +
          "12: \" Urban\"\n" +
          "13: \"Jazz\"\n" +
          "14: \"90's\"\n" +
          "15: \" Club Classics\"\n" +
          "16: \" Funk\"\n" +
          "17: \" Hip Hop\"\n" +
          "18: \" Reggaeton\"\n" +
          "19: \" Soul\"\n" +
          "20: \" Trap\"\n" +
          "21: \"Hip Hop\"\n" +
          "22: \" Techno\"\n" +
          "23: \"Indie Rock\"\n" +
          "24: \"Electro Swing\"\n" +
          "25: \" Latin\"\n" +
          "26: \"Funk\"\n" +
          "27: \" Oldschool\"\n" +
          "28: \" R'n'B\"\n" +
          "29: \"Pop\"\n" +
          "30: \"Partytunes\"\n" +
          "31: \" Schlager\"\n" +
          "32: \" Rap\"\n" +
          "33: \"R'n'B\"\n" +
          "34: \"80's\"\n" +
          "35: \" 90's\"\n" +
          "36: \"Salsa\"\n" +
          "37: \" Partytunes\"\n" +
          "38: \" Dancehall\"\n" +
          "39: \" Reggae\"\n" +
          "40: \"Rock\"\n" +
          "41: \"Tech House\"\n" +
          "42: \"Dancehall\"\n" +
          "43: \" Pop\"\n" +
          "44: \" Singer/Songwriter\""]


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


        this.events = Enumerable.from(this.events).where($ => $.fields.json.location.longitude !== "-1" && $.fields.json.location.latitude !== "-1");

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

        console.log(this.genres);

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

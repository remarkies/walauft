<template>
    <div>
        <Loading v-if="isLoading"></Loading>
        <div class="event-list">
            <div class="genres">
                <Tag class="filter" @click.native="tagClick(genre)" :selected="genre[1]" :tag="genre[0][1]" v-for="genre in genres"/>
            </div>
            <Event @click.native="eventClick(event.location.latitude, event.location.longitude)" :event="event" v-for="event in filteredEvents" />
        </div>
    </div>
</template>

<script>
  import Event from "./Event";
  import { getEvents } from "../services/api";
  import moment from "moment";
  import Tag from "./Tag";
  import Loading from "./Loading";


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
        /*
                let parentGenre = null;

                this.genresOverall.forEach(o => {
                  if(o[2].toUpperCase().includes(child.trimLeft().trimRight().toUpperCase())) {
                    console.log("Genres overall found: " + o[1] + " for:" + child);
                  }
                });
        */
        let parent = Enumerable.from(this.genresOverall).firstOrDefault($ => $[2].toUpperCase().includes(child.trimLeft().trimRight().toUpperCase()));
        if(parent === undefined) {

          parent = this.genresOverall[5];
        }

        //console.log("getParentGenre function: param: " + child + " Parent found: " + parent);
        return parent;
      },
      compareDates: function ( a, b ) {
        return moment(a.date, "YYYY-MM-DD").format('YYYYMMDD') - moment(b.date, "YYYY-MM-DD").format('YYYYMMDD');
      },
      updateEvents: async function() {
        let Enumerable = require('../../node_modules/linq');

        this.isLoading = true;
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
        } finally {
          this.isLoading = false;
        }

      }
    },
    data: function() {
      return {
        events: [],
        filteredEvents: [],
        genres: [],
        genresOverall: [
          [1, "Chlöpft & Tätscht", "Deep House,Techno,House,Elektr. Musik,Tech House,Goa,Drum'n'Bass,Dubstep,Trance,Electro,Hardstyle,Downtempo,Nu-​Disco,Hardcore,Electro Swing"],
          [2, "Gitarre & Co.", "Rock,Indie,Indie Rock,Rock'n'Roll,Hard Rock,Heavy Metal,Punk,Wave,Grunge"],
          [3, "Gangster", "Hip Hop,Rap,Oldschool,Trap,Cloud Rap,Deutschrap"],
          [4, "Radio Musik", "Disco,Pop,Schlager,Volksmusik,Country,Worldmusic,Electropop,Deutsche Welle,Singer/Songwriter,Chansons,Folk"],
          [5, "Tanzbei Schwinge", "Funk,Latin,Blues,Reggaeton,R'n'B,Reggae,Salsa,Afro Beats,Dancehall,Soul,Jazz,Tango,Tropical,Swing,Afro House,Baile Funk,Urban,Balkan Beats,Oriental Beats"],
          [6, "Misch Masch", "Partytunes,Hits,Diverses,Open Format,Club Classics,Chill Out,80's,90's,00's,Mash Up,60's,70's,Oldies,Klassik"]
        ],
        isLoading: false
      }
    },
    components: {
      Loading,
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

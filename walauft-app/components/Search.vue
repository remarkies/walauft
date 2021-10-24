<template>
  <form v-on:submit.prevent="onSubmit">
    <input
      type="search"
      name="search"
      ref="seachfield"
      placeholder="suech was so lauft"
      v-model="searchTerm"
    />
    <!-- <button @click="searchTerm = ''">X</button> -->
  </form>
</template>

<script lang="ts">
import Vue from "vue";
import { mapActions } from "vuex";

export default Vue.extend({
  data() {
    return {
      searchTerm: "",
    };
  },
  watch: {
    searchTerm(newTerm) {
      this.$store.dispatch("setSearchTerm", newTerm);
    },
  },
  methods: {
    onSubmit(): void {
      const seachrFieldEL = this.$refs.seachfield as HTMLInputElement;
      seachrFieldEL.blur();
    },
    ...mapActions({
      toggleTag: "toggleTag",
    }),
  },
  mounted() {
    this.searchTerm = this.$store.state.searchTerm;
  },
});
</script>
<style lang="scss" scoped>
form {
  display: flex;
  button {
    background: none;
    color: inherit;
    border: none;
    padding: 0;
    font: inherit;
    cursor: pointer;
    outline: inherit;
  }
}
input {
  border: var(--border-style);
  border-radius: 0.1rem;
  width: 100%;
  padding: 0.5rem;
  background-color: var(--secondary-color);
  color: var(--primary-color);
  box-shadow: none !important;
  outline: none;
  font-size: 16px;
  font-family: inherit !important;
}

input::placeholder {
  color: var(--primary-color);
  opacity: 0.5;
  font-family: inherit !important;
}

input:focus {
  border: var(--border-style);
  background-color: var(--secondary-color);
  transition: width 0.5s ease-in-out;
}
:-webkit-autofill {
  color: var(--primary-color) !important;
}
</style>
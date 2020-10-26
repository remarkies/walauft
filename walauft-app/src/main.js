import Vue from "vue";
import App from "./App.vue";
import router from "./router";
import { library } from '@fortawesome/fontawesome-svg-core'
import { faArrowLeft } from '@fortawesome/free-solid-svg-icons'
import { faArrowRight } from '@fortawesome/free-solid-svg-icons'
import { faTimes } from '@fortawesome/free-solid-svg-icons'
import { faBuilding } from '@fortawesome/free-solid-svg-icons'
import { faUser } from '@fortawesome/free-solid-svg-icons'
import { faMap } from '@fortawesome/free-solid-svg-icons'
import { faMapPin } from '@fortawesome/free-solid-svg-icons'

import VTooltip from 'v-tooltip'

Vue.use(VTooltip);

library.add(faArrowLeft, faTimes, faBuilding, faUser, faMap, faArrowRight,faMapPin);

import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
Vue.component('font-awesome-icon', FontAwesomeIcon)


Vue.config.productionTip = false;

new Vue({
  router,
  render: h => h(App)
}).$mount("#app");

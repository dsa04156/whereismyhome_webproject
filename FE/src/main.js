import Vue from "vue";
import App from "./App.vue";
import router from "@/router";
import store from "@/store";
import vClickOutside from "v-click-outside";
import LetItSnow from "vue-let-it-snow";

import "@/api/lib/fontAwesomeIcon.js"; // fontAwesomeIcon.js 불러옴
import "@/api/lib/vueBootstrap.js";

import { PaginationPlugin } from "bootstrap-vue";
import { BootstrapVue, IconsPlugin } from "bootstrap-vue";

// Import Bootstrap and BootstrapVue CSS files (order is important)
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";

// Make BootstrapVue available throughout your project
Vue.use(BootstrapVue);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);
Vue.use(PaginationPlugin);
Vue.use(LetItSnow);

export const eventBus = new Vue();

Vue.config.productionTip = false;
Vue.use(vClickOutside);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

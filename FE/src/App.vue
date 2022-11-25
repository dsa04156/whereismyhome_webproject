<template>
  <div id="app">
    <the-header-navbar></the-header-navbar>
    <let-it-snow></let-it-snow>
    <main-page></main-page>
    <router-view></router-view>
    <footer-nav></footer-nav>
  </div>
</template>

<script>
import TheHeaderNavbar from "@/components/TheHeaderNavbar";
import FooterNav from "@/components/FooterNav";
import LetItSnow from "@/components/LetItSnow ";
import mainPage from "@/components/mainPage";
export default {
  name: "App",
  components: {
    TheHeaderNavbar,
    LetItSnow,
    FooterNav,
    mainPage,
  },
};
</script>

<style>
@font-face {
  font-family: "Tenada";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2210-2@1.0/Tenada.woff2")
    format("woff2");
  font-weight: bold;
  font-style: italic;
}

#app {
  /* background-image: url(/src/img/main2.png); */
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  height: 100vh;
  font-family: "Tenada";
  /* color: #2c3e50; */
}

a.router-link-exact-active {
  color: #89bfef;
}

a.router-link-exact-active:hover {
  text-decoration: none;
}
</style>

<template>
  <b-div>
    <header id="header">
      <h1>
        <b-navbar-brand href="#">
          <router-link :to="{ name: 'main' }">
            <b-img
              :src="require('@/img/chrismaslogo.png')"
              id="logo"
              class="d-inline-block align-top"
            ></b-img>
          </router-link>
        </b-navbar-brand>
      </h1>
      <nav>
        <ul class="tt">
          <div class="aaaa">
            <li>
              <a>
                <router-link :to="{ name: 'main' }"> 메인 </router-link>
              </a>
            </li>
            <li>
              <a>
                <router-link :to="{ name: 'house' }"> 아파트정보 </router-link>
              </a>
            </li>
            <li>
              <a>
                <router-link :to="{ name: 'board' }"> 게시판 </router-link>
              </a>
            </li>
            <li>
              <a>
                <router-link :to="{ name: 'qna' }"> 1:1 문의 </router-link>
              </a>
            </li>
          </div>
        </ul>
        <ul class="qq">
          <a>
            <b-navbar-nav class="navbar" v-if="userInfo">
              <ul class="bbbb">
                <li>
                  <a>
                    <img src="@/assets/thor.png" id="thor" />
                    {{ userInfo.id }}({{ userInfo.name }})님 환영합니다.
                  </a>
                </li>
                <li>
                  <a class="right">
                    <router-link :to="{ name: 'mypage' }"
                      >내정보보기</router-link
                    >
                  </a>
                </li>
                <li>
                  <a class="right">
                    <b-div @click.prevent="onClickLogout" name="logout"
                      >로그아웃</b-div
                    >
                  </a>
                </li>
              </ul>
            </b-navbar-nav>
            <b-navbar-nav class="navbar" v-else>
              <ul>
                <li>
                  <a class="right">
                    <router-link :to="{ name: 'join' }"> 회원가입 </router-link>
                  </a>
                </li>
                <li>
                  <a class="right">
                    <router-link :to="{ name: 'login' }"> 로그인 </router-link>
                  </a>
                </li>
              </ul>
            </b-navbar-nav>
          </a>
        </ul>
      </nav>
    </header>
  </b-div>
</template>

<script>
import { mapState, mapGetters, mapActions } from "vuex";
const memberStore = "memberStore";
export default {
  name: "TheHeaderNavbar",
  data() {
    return {};
  },
  computed: {
    ...mapState(memberStore, ["isLogin", "userInfo"]),
    ...mapGetters(["checkUserInfo"]),
  },
  methods: {
    ...mapActions(memberStore, ["userLogout"]),
    // ...mapMutations(memberStore, ["SET_IS_LOGIN", "SET_USER_INFO"]),
    onClickLogout() {
      // this.SET_IS_LOGIN(false);
      // this.SET_USER_INFO(null);
      // sessionStorage.removeItem("access-token");
      // if (this.$route.path != "/") this.$router.push({ name: "main" });
      console.log(this.userInfo.id);
      //vuex actions에서 userLogout 실행(Backend에 저장 된 리프레시 토큰 없애기
      //+ satate에 isLogin, userInfo 정보 변경)
      // this.$store.dispatch("userLogout", this.userInfo.userid);
      this.userLogout(this.userInfo.id);

      if (this.$route.path != "/") this.$router.push({ name: "main" });
    },
  },
};
</script>

<style scoped>
@import url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2210-2@1.0/Tenada.woff2");

@font-face {
  font-family: "Tenada";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2210-2@1.0/Tenada.woff2")
    format("woff2");
  font-weight: bold;
  font-style: italic;
}

b-div {
  font-family: "Tenada";
  font-size: 20px;
}
#header {
  display: contents;
}
nav {
  display: contents;
}
.navbar {
  display: contents;
}

nav {
  width: 100vw;
}
.qq {
  display: inline-block;

  padding-left: 118px;
}
.tt {
  text-align: start;
  display: inline-block;
}
.aaaa {
  display: inline-block;
  margin-left: 0;
}

.bbbb {
  display: inline-block;
}

#thor {
  width: 40px;
}

#header {
  position: fixed;
  z-index: 10000;
  left: 0;
  top: 0;
  width: 100%;
  background: rgba(255, 255, 255, 0.95);
  height: 3em;
  line-height: 3em;
  box-shadow: 0 0 0.15em 0 rgba(0, 0, 0, 0.1);
}

#header h1 {
  position: absolute;
  left: 1em;
  top: 0;
  height: 3em;
  line-height: 3em;
  cursor: default;
}

#header h1 a {
  font-size: 2em;
}

#header nav {
  position: absolute;
  /* right: 0.5em; */
  top: 0;
  height: 3em;
  line-height: 3em;
}

#header nav ul {
  margin: 0;
}

#header nav ul li {
  display: inline-block;
  margin-left: 0.5em;
  font-size: 1.2em;
}

#header nav ul li a {
  display: contents;
  color: inherit;
  text-decoration: none;
  height: 4em;
  line-height: 3em;
  /* padding: 0 0.5em 0 0.5em; */
  outline: 0;
}

@media screen and (max-width: 736px) {
  #header {
    height: 2.5em;
    line-height: 2.5em;
  }

  #header h1 {
    text-align: center;
    position: relative;
    left: 0;
    top: 0;
    height: 2.5em;
    line-height: 2.5em;
  }

  #header h1 a {
    font-size: 1em;
  }

  #header nav {
    display: contents;
  }
}

body {
  padding-top: 3em;
}

@media screen and (max-width: 736px) {
  body {
    padding-top: 2.5em;
  }
}

#logo {
  size: "100%";
  margin-top: 20px;
  margin-left: 120px;
}

/*
.nav {
  background-color: rgb(109, 109, 109);
  background-size: 1920px;
  height: 100px;
  top: 0px;
}
#logo {
  width: 80px;
}

.link {

  display: inline-block;
  padding: 0 9px;
  height: 40px;
  line-height: 40px;
  color: #fff;
  font-size: 2.4rem;
  font-weight: 500;
  box-sizing: border-box;
  text-decoration: none;
  cursor: pointer;
  word-break: keep-all;
  word-wrap: break-word;
  white-space: normal;
  text-align: left;

  font-size: 22px;
  letter-spacing: -0.03em;
}

#logout {
  color: white;
}

body{
  background-color: #ffffff;
  padding: 0;
  margin: 0;
} */
</style>

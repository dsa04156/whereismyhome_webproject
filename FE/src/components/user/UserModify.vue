<template>
  <b-container class="mt-4" v-if="userInfo">
    <b-row>
      <b-col>
        <b-alert variant="secondary" show><h3>내정보</h3></b-alert>
      </b-col>
    </b-row>
    <b-row>
      <b-col></b-col>
      <b-col cols="8">
        <b-jumbotron>
          <template #header>회원정보 수정</template>

          <template #lead> 내 정보 수정 페이지 입니다. </template>

          <hr class="my-4" />
          <form>
            <b-container class="mt-4">
              <b-row>
                <b-col cols="2"></b-col>
                <b-col cols="2" align-self="end">아이디</b-col
                ><b-col cols="4" align-self="start" id="id" name="name">{{
                  userInfo.id
                }}</b-col>
                <b-col cols="2"></b-col>
              </b-row>

              <div class="form-outline mb-4 Check">
                <label class="form-label Label" for="name"
                  >&nbsp;&nbsp;이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label
                >
                <input
                  type="text"
                  id="name"
                  name="name"
                  v-model="user.name"
                  class="form-control form-control-lg inputText"
                />
                <b-col cols="2"></b-col>
              </div>
              <div class="form-outline mb-4 Check">
                <label class="form-label Label" for="email">전자 메일</label>
                <input
                  type="email"
                  id="email"
                  name="email"
                  v-model="user.email"
                  class="form-control form-control-lg inputText"
                />
                <b-col cols="2"></b-col>
              </div>
              <div class="form-outline mb-4 Check">
                <label class="form-label Label" for="pw">비밀 번호</label>
                <input
                  type="password"
                  id="pw"
                  name="pw"
                  v-model="user.pw"
                  class="form-control form-control-lg inputText"
                />
                <b-col cols="2"></b-col>
              </div>
            </b-container>
            <hr class="my-4" />
            <b-button @click="submitForm" variant="primary" class="mr-1"
              >정보수정</b-button
            >
          </form>
        </b-jumbotron>
      </b-col>
      <b-col></b-col>
    </b-row>
  </b-container>
</template>

<script>
import axios from "@/api/http";
import { mapState } from "vuex";

const memberStore = "memberStore";
// import axios from "@/api/index";
export default {
  name: "UserModify",
  data() {
    return {
      user: {
        id: "",
        email: "",
        name: "",
        pw: "",
        comment: "",
        level: "",
      },
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
  },
  methods: {
    submitForm() {
      axios
        .put("/user/modify", {
          id: this.userInfo.id,
          pw: this.user.pw,
          email: this.user.email,
          name: this.user.name,
          comment: this.user.comment,
          level: "normal",
          withCredentials: true, // 쿠키 cors 통신 설정
        })
        .then(({ data }) => {
          console.log(data);
        })
        .catch((data) => {
          console.log(data);
        });
      this.$router.go(-1);
      this.$router.push({ name: "mypage" });
    },
  },
  // movePage() {
  //   this.$router.push({ name: "main" });
  // },
};
</script>

<style>
.inputText {
  width: 12vw;
}
.Check {
  display: flex;
  justify-content: space-between;
  text-align: center;
  vertical-align: middle;
  margin-left: 125px;
}

.Label {
  margin-top: 15px;
}
</style>

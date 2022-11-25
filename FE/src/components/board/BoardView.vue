<template>
  <b-container class="bv-example-row mt-3">
    <h3>글보기</h3>
    <b-row class="mb-1">
      <b-col class="text-left">
        <b-button variant="outline-success" @click="moveList">목록</b-button>
      </b-col>
      <b-col
        v-if="this.userInfo != null && this.userInfo.id == 'admin'"
        class="text-right"
      >
        <b-button
          variant="outline-info"
          size="sm"
          @click="moveModifyArticle"
          class="mr-2"
          >글수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="deleteArticle"
          >글삭제</b-button
        >
      </b-col>
    </b-row>
    <b-row class="mb-1">
      <b-col>
        <b-card
          :header-html="`<h3>${notice.articleNo}.
          ${notice.subject} [${notice.hit}]</h3><div><h6>${notice.id}</div><div>${notice.regTime}</h6></div>`"
          class="mb-2"
          border-variant="dark"
          no-body
        >
          <b-card-body class="text-left">
            <div v-html="message"></div>
          </b-card-body>
        </b-card>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
// import moment from "moment";
import http from "@/api/http";

import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  name: "BoardView",
  data() {
    return {
      notice: {},
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    message() {
      if (this.notice.content)
        return this.notice.content.split("\n").join("<br>");
      return "";
    },
  },
  created() {
    http.get(`/notice/${this.$route.params.articleNo}`).then(({ data }) => {
      this.notice = data;
    });
  },
  methods: {
    moveModifyArticle() {
      this.$router.replace({
        name: "boardmodify",
        params: { articleNo: this.notice.articleNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteArticle() {
      if (confirm("정말로 삭제?")) {
        this.$router.replace({
          name: "boarddelete",
          params: { articleNo: this.notice.articleNo },
        });
      }
    },
    moveList() {
      this.$router.push({ name: "boardlist" });
    },
  },
  // filters: {
  //   dateFormat(regtime) {
  //     return moment(new Date(regtime)).format("YY.MM.DD hh:mm:ss");
  //   },
  // },
};
</script>

<style></style>

<template>
  <b-container class="bv-example-row mt-3">
    <h3>글보기</h3>

    <b-row class="mb-1">
      <b-col class="text-left">
        <b-button variant="outline-primary" @click="moveList">목록</b-button>
      </b-col>
      <b-col class="text-right">
        <b-button
          variant="outline-info"
          size="sm"
          @click="moveModifyQna"
          class="mr-2"
          >글수정</b-button
        >
        <b-button variant="outline-danger" size="sm" @click="deleteQna"
          >글삭제</b-button
        >
      </b-col>
    </b-row>
    <b-row class="mb-1">
      <b-col>
        <b-card
          :header-html="`<h3>${qna.qnaNo}.
          ${qna.subject}</h3><div><h6>${qna.id}</div><div>${qna.regTime}</h6></div>`"
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
    <b-row class="mb-1">
      <b-col>
        <div v-if="qna.state == true">
          <b-card
            :header-html="`<h3>답변</h3><div>${qna.adRegTime}</h6></div>`"
            class="mb-2"
            border-variant="dark"
            no-body
          >
            <b-card-body class="text-left">
              <div v-html="answer"></div>
            </b-card-body>
          </b-card>
        </div>
        <div v-else>
          <div v-if="userInfo.id == 'admin'">
            <b-form-group id="content-group" label="답변:" label-for="content">
              <b-form-textarea
                id="content"
                v-model="qna.answer"
                placeholder="내용 입력..."
                rows="2"
                max-rows="15"
              >
              </b-form-textarea>
            </b-form-group>
            <b-button @click="submitAnswer" variant="primary" class="m-1"
              >글작성</b-button
            >
          </div>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
// import moment from 'moment';
import http from "@/api/http";
import { mapState } from "vuex";
const memberStore = "memberStore";
export default {
  name: "QnaView",

  data() {
    return {
      qna: {
        qnaNo: "",
        answer: "",
        subject: "",
        content: "",
        state: "",
        // adRegTime: '',
      },
    };
  },
  computed: {
    message() {
      if (this.qna.content) return this.qna.content.split("\n").join("<br>");
      return "";
    },
    answer() {
      if (this.qna.answer) return this.qna.answer.split("\n").join("<br>");
      return "";
    },
    ...mapState(memberStore, ["userInfo"]),
  },
  created() {
    http.get(`/qna/${this.$route.params.qnaNo}`).then(({ data }) => {
      this.qna = data;
      // console.log(this.qna);
    });
  },
  methods: {
    submitAnswer() {
      http
        .post("/qna/writeAnswer", {
          qnaNo: this.qna.qnaNo,
          answer: this.qna.answer,
          subject: this.qna.subject,
          content: this.qna.content,
        })
        .then(({ data }) => {
          console.log(data);
        })
        .catch(({ data }) => {
          console.log(data);
        });
      this.$router.go();
    },

    moveModifyQna() {
      this.$router.replace({
        name: "qnamodify",
        params: { qnaNo: this.qna.qnaNo },
      });
      //   this.$router.push({ path: `/board/modify/${this.article.articleno}` });
    },
    deleteQna() {
      if (confirm("정말로 삭제?")) {
        this.$router.replace({
          name: "qnadelete",
          params: { qnaNo: this.qna.qnaNo },
        });
      }
    },
    moveList() {
      this.$router.push({ name: "qnalist" });
    },
  },
  // filters: {
  //     dateFormat(regtime) {
  //         return moment(new Date(regtime)).format('YY.MM.DD hh:mm:ss');
  //     },
  // },
};
</script>

<style></style>

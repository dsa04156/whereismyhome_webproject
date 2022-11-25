<template>
  <b-container class="bv-example-row mt-3 boardclass">
    <h3>Q&amp;A</h3>

    <b-button variant="outline-secondary butwri" @click="moveWrite()"
      >글쓰기</b-button
    >

    <b-row>
      <b-col>
        <b-table
          id="qna"
          hover
          outlined
          head-variant="dark"
          :items="qnas"
          :fields="fields"
          :per-page="perPage"
          :current-page="currentPage"
          @row-clicked="viewArticle"
        >
          <template #cell(subject)="data">
            <router-link
              :to="{ name: 'qnaview', params: { qnaNo: data.item.qnaNo } }"
            >
              {{ data.item.subject }}
            </router-link>
          </template>
        </b-table>
      </b-col>
    </b-row>
    <b-pagination
      v-model="currentPage"
      size="m"
      :total-rows="rows"
      :per-page="perPage"
      align="center"
      aria-controls="qna"
    ></b-pagination>
  </b-container>
</template>

<script>
import http from "@/api/http";

export default {
  name: "QnaList",
  data() {
    return {
      qnas: [],
      fields: [
        { key: "qnaNo", label: "글번호", tdClass: "tdClass" },
        { key: "subject", label: "제목", tdClass: "tdSubject" },
        { key: "id", label: "작성자", tdClass: "tdClass" },
        { key: "regTime", label: "작성일", tdClass: "tdClass" },
        { key: "state", label: "답변 여부", tdClass: "tdClass" },
      ],

      perPage: 5,
      currentPage: 1,
    };
  },
  computed: {
    rows() {
      return this.qnas.length;
    },
  },
  created() {
    http.get(`/qna`).then(({ data }) => {
      this.qnas = data;
      console.log(this.qnas);
      // console.log(this.qnas.state);
      this.qnas.forEach((item) => {
        if (item.state == true) item.state = "답변완료";
        else item.state = "답변대기";
      });
      if (this.qnas.state) this.qnas.state = "답변완료";
    });
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "qnawrite" });
    },
    viewArticle(qna) {
      this.$router.push({
        name: "qnaview",
        params: { qnaNo: qna.qnaNo },
      });
    },
  },
};
</script>

<style scope>
.userwr {
  display: inline-block;
}
.butwri {
  float: inline-end;
  margin-left: 920px;
}
h3 {
  display: inline-block;
  margin-top: 30px;
}
.wriri {
  display: inline-block;
}
#qna {
  background-color: #ffffff;
}
.boardclass {
  margin-top: 3rem;
}
.tdClass {
  width: 50px;
  text-align: center;
}
.tdSubject {
  width: 300px;
  text-align: left;
}
</style>

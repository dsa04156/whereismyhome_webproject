<template>
  <b-container class="bv-example-row mt-3 boardclass">
    <h3>글목록</h3>

    <b-row
      v-if="this.userInfo != null && this.userInfo.id == 'admin'"
      class="mb-1 userwr"
    >
      <b-button variant="outline-secondary butwri" @click="moveWrite()"
        >글쓰기</b-button
      >
    </b-row>
    <b-row>
      <b-col>
        <b-table
          id="notice"
          outlined
          head-variant="dark"
          :items="notices"
          :fields="fields"
          :per-page="perPage"
          :current-page="currentPage"
          @row-clicked="viewArticle"
        >
          <template #cell(subject)="data">
            <router-link
              :to="{
                name: 'boardview',
                params: { articleNo: data.item.articleNo },
              }"
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
      aria-controls="notice"
    ></b-pagination>
  </b-container>
</template>

<script>
import http from "@/api/http";

import { mapState } from "vuex";
const memberStore = "memberStore";

export default {
  name: "BoardList",
  data() {
    return {
      notices: [],
      fields: [
        { key: "articleNo", label: "글번호", tdClass: "tdClass" },
        { key: "subject", label: "제목", tdClass: "tdSubject" },
        { key: "id", label: "작성자", tdClass: "tdClass" },
        { key: "regTime", label: "작성일", tdClass: "tdClass" },
        { key: "hit", label: "조회수", tdClass: "tdClass" },
      ],
      perPage: 5,
      currentPage: 1,
    };
  },
  created() {
    http.get(`/notice`).then(({ data }) => {
      this.notices = data;
    });
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    rows() {
      return this.notices.length;
    },
    lists() {
      const items = this.notices;
      return items.slice(
        (this.currentPage - 1) * this.perPage,
        this.currentPage * this.perPage
      );
    },
  },
  methods: {
    moveWrite() {
      this.$router.push({ name: "boardwrite" });
    },
    viewArticle(notice) {
      this.$router.push({
        name: "boardview",
        params: { articleNo: notice.articleNo },
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
.wriri {
  display: inline-block;
}
h3 {
  display: inline-block;
  margin-top: 30px;
}
#notice {
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

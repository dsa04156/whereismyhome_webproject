<template>
  <b-card style="max-width: 20rem" class="rank position-absolute">
    <template #header>
      <h4 class="mb-0">실시간 관심지역 순위</h4>
    </template>

    <b-card-body>
      <bar-chart :name="name" :cnt="cnt"></bar-chart>
      <!-- <div v-for="item in rank" v-bind:key="item">
                    {{ item.sidoName }} {{ item.gugunName }} {{ item.dongName }} ({{ item.cnt }})
                </div> -->
    </b-card-body>

    <!-- <b-list-group flush>
                <b-list-group-item>Cras justo odio</b-list-group-item>
                <b-list-group-item>Dapibus ac facilisis in</b-list-group-item>
                <b-list-group-item>Vestibulum at eros</b-list-group-item>
            </b-list-group> -->

    <b-card-body>
      <router-link :to="{ name: 'house' }" class="link text-primary">
        더 많은 정보 보기
      </router-link>
    </b-card-body>
  </b-card>
</template>

<script>
import { mapState, mapActions, mapMutations } from "vuex";
import BarChart from "@/components/house/item/BarChart.vue";

const houseStore = "houseStore";

export default {
  data() {
    return {
      name: [],
      cnt: [],
    };
  },
  components: {
    BarChart,
  },
  computed: {
    ...mapState(houseStore, ["ranks"]),
  },
  created() {
    this.CLEAR_RANK_LIST();
    this.getRank();
  },
  watch: {
    ranks: "setRankList",
  },
  methods: {
    ...mapActions(houseStore, ["getRank"]),
    ...mapMutations(houseStore, ["CLEAR_RANK_LIST"]),
    setRankList() {
      // console.log(this.ranks);
      // this.rank = this.ranks;
      var allCnt = 0;
      this.ranks.forEach((item) => {
        allCnt += item.cnt;
      });
      // console.log(allCnt);

      // for (var i = 0; i < 5; i++) {
      //     this.name.push(this.ranks[i].dongName);
      //     this.cnt.push(this.ranks[i].cnt);
      // }
      this.ranks.some((item, idx) => {
        if (idx == 5) return true;
        // console.log(idx);
        this.name.push(item.dongName);
        this.cnt.push((item.cnt / allCnt) * 100);
      });

      // console.log(this.name);
    },
  },
};
</script>

<style>
.card {
  display: inline-block;
  background-image: url("@/assets/tete.png");
  background-size: cover;
}
.rank {
  margin-top: 150px;
  margin-left: 50px;

  display: inline-block;
}
</style>

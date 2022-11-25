<template>
  <div id="mapCompo">
    <house-search-bar></house-search-bar>
    <kakao-map class="kmap"></kakao-map>
    <!-- <rank-view class="rank"></rank-view> -->
  </div>
</template>
<script>
import HouseSearchBar from "@/components/house/HouseSearchBar.vue";
import KakaoMap from "@/components/house/KaKaoMap.vue";
// import RankView from '@/components/house/RankView.vue';

export default {
  name: "AppHouse",
  components: {
    HouseSearchBar,
    KakaoMap,
    // RankView,
  },
};
</script>
<style>
#mapCompo {
  width: 80%;
  margin: auto;
  margin-top: 50px;
}
/* .kmap {
    width: 80%;
    float: left;
}
.rank {
    width: 20%;
    float: right;
} */
</style>

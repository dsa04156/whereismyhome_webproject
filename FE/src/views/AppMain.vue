<template>
  <div>
    <rank-view></rank-view>
    <carousel-view></carousel-view>
  </div>
</template>

<script>
import RankView from "@/components/house/RankView";
import carouselView from "@/components/carouselView";
export default {
  name: "AppMain",
  components: {
    RankView,
    carouselView,
  },
  props: {},
};
</script>

<style scoped>
div {
  background-color: #d1cdca;
  z-index: 30;
}
.underline-steelblue {
  display: inline-block;
  background: linear-gradient(
    180deg,
    rgba(255, 255, 255, 0) 70%,
    rgba(72, 190, 233, 0.3) 30%
  );
}
</style>

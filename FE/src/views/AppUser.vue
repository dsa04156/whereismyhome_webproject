<template>
  <b-container class="bv-example-row text-center usermain">
    <router-view></router-view>
  </b-container>
</template>

<script>
export default {
  name: "AppUser",
};
</script>

<style scoped>
.usermain {
  margin-top: 180px;
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

<template>
  <b-container class="bv-example-row boardcon">
    <router-view></router-view>
  </b-container>
</template>
<script>
export default {
  name: "AppBoard",
};
</script>
<style scoped>
.boardcon {
  margin-top: 180px;
  background-color: #cad1d9;
}
</style>

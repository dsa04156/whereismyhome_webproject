<template>
  <div id="footer"></div>
</template>

<script>
export default {
  name: "FooterNav",

  data() {
    return {};
  },

  mounted() {},

  methods: {},
};
</script>

<style scoped>
#footer {
  background-image: url(/src/img/footer.png);
  margin-bottom: 0;
  width: 100vw;
  height: 150px;
  position: absolute;
  bottom: 0;
  z-index: 3;
}
</style>

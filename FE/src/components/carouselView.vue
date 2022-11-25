<template>
  <div>
    <b-carousel
      id="carousel-1"
      v-model="slide"
      :interval="4000"
      controls
      indicators
      background="#ababab"
      img-width="1024 "
      img-height="480"
      @sliding-start="onSlideStart"
      @sliding-end="onSlideEnd"
    >
      <!-- Text slides with image -->
      <b-carousel-slide
        img-src="https://img.freepik.com/premium-vector/cute-penguin-in-winter-illustration_16622-171.jpg?w=740"
      ></b-carousel-slide>

      <!-- Slides with custom text -->
      <!-- <b-carousel-slide
        img-src="https://littledeep.com/wp-content/uploads/2020/11/winter-illustration-main-1024x600.png"
      >
      </b-carousel-slide> -->

      <!-- Slides with image only -->

      <!-- Slides with img slot -->
      <!-- Note the classes .d-block and .img-fluid to prevent browser default image alignment -->
    </b-carousel>
  </div>
</template>

<script>
export default {
  data() {
    return {
      slide: 0,
      sliding: null,
    };
  },
  methods: {
    onSlideStart(slide) {
      this.sliding = true;
    },
    onSlideEnd(slide) {
      this.sliding = false;
    },
  },
};
</script>

<style lang="scss" scoped>
/* div {
  width: 100vw;
  height: 100vh;
} */
#carousel-1 {
  display: inline-block;
  margin-left: 200px;
  margin-top: 10px;
  width: 1000px;
  height: 375px;
}
</style>

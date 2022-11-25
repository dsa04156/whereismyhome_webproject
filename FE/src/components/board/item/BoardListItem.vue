<template>
  <b-tr>
    <b-td>{{ articleNo }}</b-td>
    <b-th class="text-left">
      <router-link
        :to="{ name: 'boardview', params: { articleNo: articleNo } }"
        >{{ subject }}</router-link
      >
    </b-th>
    <b-td>{{ hit }}</b-td>
    <b-td>{{ id }}</b-td>
    <b-td>{{ regTime | dateFormat }}</b-td>
  </b-tr>
</template>

<script>
import moment from "moment";

export default {
  name: "BoardListItem",
  props: {
    articleNo: Number,
    id: String,
    subject: String,
    hit: Number,
    regTime: String,
  },
  filters: {
    dateFormat(regTime) {
      return moment(new Date(regTime)).format("YY.MM.DD");
    },
  },
};
</script>

<style></style>

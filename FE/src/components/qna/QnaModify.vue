<template>
  <b-container class="bv-example-row mt-3">
    <h3>글수정</h3>
    <qna-input-item type="modify" />
  </b-container>
</template>

<script>
import QnaInputItem from "@/components/qna/item/QnaInputItem";

export default {
  name: "QnaModify",
  components: {
    QnaInputItem,
  },
};
</script>

<style></style>

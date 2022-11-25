<template>
    <b-tr>
        <b-td>{{ qnaNo }}</b-td>
        <b-th class="text-left">
            <router-link :to="{ name: 'qnaview', params: { qnaNo: qnaNo } }">{{ subject }}</router-link>
        </b-th>
        <!-- <b-td>{{ hit }}</b-td> -->
        <b-td>{{ id }}</b-td>
        <b-td>{{ regTime | dateFormat }}</b-td>
    </b-tr>
</template>

<script>
import moment from 'moment';

export default {
    name: 'QnaListItem',
    props: {
        qnaNo: Number,
        id: String,
        subject: String,
        regTime: String,
        state: String,
    },
    filters: {
        dateFormat(regTime) {
            return moment(new Date(regTime)).format('YY.MM.DD');
        },
    },
};
</script>

<style></style>

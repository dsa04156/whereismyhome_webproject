import Vue from 'vue';
import Vuex from 'vuex';
// import http from '@/api/http';
import createPersistedState from 'vuex-persistedstate';

import memberStore from '@/store/modules/memberStore';
import houseStore from '@/store/modules/houseStore';
import kakaoStore from '@/store/modules/kakaoStore';

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        memberStore,
        houseStore,
        kakaoStore,
    },
    // state: {
    //     sidos: [{ value: null, text: '시도선택' }],
    //     guguns: [{ value: null, text: '구군선택' }],
    //     dongs: [{ value: null, text: '동선택' }],
    //     houses: [],
    //     // house: null,
    // },
    // getters: {
    //     gettersAptList(state) {
    //         return state.houses;
    //     },
    // },
    // mutations: {
    //     /////////////////////////////// House start /////////////////////////////////////
    //     SET_SIDO_LIST(state, sidos) {
    //         sidos.forEach((sido) => {
    //             state.sidos.push({ value: sido.code, text: sido.name });
    //         });
    //     },
    //     SET_GUGUN_LIST(state, guguns) {
    //         guguns.forEach((gugun) => {
    //             state.guguns.push({ value: gugun.code, text: gugun.name });
    //         });
    //     },
    //     SET_DONG_LIST(state, dongs) {
    //         dongs.forEach((dong) => {
    //             state.dongs.push({ value: dong.code, text: dong.name });
    //         });
    //     },
    //     CLEAR_SIDO_LIST(state) {
    //         state.sidos = [{ value: null, text: '시도선택' }];
    //     },
    //     CLEAR_APT_LIST(state) {
    //         state.houses = [];
    //         state.house = null;
    //     },
    //     CLEAR_GUGUN_LIST(state) {
    //         state.guguns = [{ value: null, text: '구군선택' }];
    //     },
    //     CLEAR_DONG_LIST(state) {
    //         state.dongs = [{ value: null, text: '동선택' }];
    //     },
    //     SET_HOUSE_LIST(state, houses) {
    //         // 동코드에 해당하는 아파트 목록
    //         state.houses = houses;
    //         // houses.forEach((house) => {
    //         //     state.houses.push({
    //         //         dongCode: house.dongCode,
    //         //         aptCode: house.aptCode,
    //         //         aptName: house.aptName,
    //         //     });
    //         //     // console.log(house);
    //         // });
    //         // console.log(state.houses);
    //     },
    //     SET_DETAIL_HOUSE(state, house) {
    //         // console.log("Mutations", house);
    //         state.house = house;
    //     },
    //     /////////////////////////////// House end /////////////////////////////////////
    // },
    // actions: {
    //     /////////////////////////////// House start /////////////////////////////////////
    //     getSido({ commit }) {
    //         http.get(`/apt/sido`)
    //             .then(({ data }) => {
    //                 // console.log(data);
    //                 commit('SET_SIDO_LIST', data);
    //             })
    //             .catch((error) => {
    //                 console.log(error);
    //             });
    //     },
    //     getGugun({ commit }, sidoCode) {
    //         http.get(`/apt/gugun/${sidoCode}`)
    //             .then(({ data }) => {
    //                 // console.log(commit, response);
    //                 commit('SET_GUGUN_LIST', data);
    //             })
    //             .catch((error) => {
    //                 console.log(error);
    //             });
    //     },
    //     getDong({ commit }, code) {
    //         http.get(`/apt/dong/${code}`)
    //             .then(({ data }) => {
    //                 commit('SET_DONG_LIST', data);
    //                 // console.log(data);
    //             })
    //             .catch((error) => {
    //                 console.log(error);
    //             });
    //     },
    //     getAptList({ commit }, dongCode) {
    //         // vue cli enviroment variables 검색
    //         //.env.local file 생성.
    //         // 반드시 VUE_APP으로 시작해야 한다.

    //         http.get(`/apt/list/${dongCode}`)
    //             .then(({ data }) => {
    //                 // console.log(commit, data);
    //                 commit('SET_HOUSE_LIST', data);
    //             })
    //             .catch((error) => {
    //                 console.log(error);
    //             });
    //     },
    //     detailHouse({ commit }, house) {
    //         // 나중에 house.일련번호를 이용하여 API 호출
    //         // console.log(commit, house);
    //         commit('SET_DETAIL_HOUSE', house);
    //     },
    //     /////////////////////////////// House end /////////////////////////////////////
    // },
    plugins: [
        createPersistedState({
            // 브라우저 종료시 제거하기 위해 localStorage가 아닌 sessionStorage로 변경. (default: localStorage)
            storage: sessionStorage,
        }),
    ],
});

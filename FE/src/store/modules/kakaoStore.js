import { subwayList, cafeList, cstoreList, drugsList, hospitalList } from '@/api/kakao.js';

const kakaoStore = {
    namespaced: true,

    state: {
        subway: [],
        cafe: [],
        cstore: [],
        drugs: [],
        hospital: [],
    },
    getters: {},
    mutations: {
        CLEAR_SUBWAY_LIST(state) {
            state.subway = [];
        },
        CLEAR_CAFE_LIST(state) {
            state.cafe = [];
        },
        CLEAR_CSTORE_LIST(state) {
            state.cstore = [];
        },
        CLEAR_DRUGS_LIST(state) {
            state.drugs = [];
        },
        CLEAR_HOSPITAL_LIST(state) {
            state.hospital = [];
        },
        SET_SUBWAY_LIST(state, subway) {
            state.subway = subway;
        },
        SET_CAFE_LIST(state, cafe) {
            state.cafe = cafe;
        },
        SET_CSTORE_LIST(state, cstore) {
            state.cstore = cstore;
        },
        SET_DRUGS_LIST(state, drugs) {
            state.drugs = drugs;
        },
        SET_HOSPITAL_LIST(state, hospital) {
            state.hospital = hospital;
        },
    },
    actions: {
        getSubway: ({ commit }, { lng, lat }) => {
            subwayList(
                { lng, lat },
                ({ data }) => {
                    commit('SET_SUBWAY_LIST', data.documents);
                    // console.log(data.documents);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getCafe: ({ commit }, { lng, lat }) => {
            cafeList(
                { lng, lat },
                ({ data }) => {
                    commit('SET_CAFE_LIST', data.documents);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getCstore: ({ commit }, { lng, lat }) => {
            cstoreList(
                { lng, lat },
                ({ data }) => {
                    commit('SET_CSTORE_LIST', data.documents);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getDrugs: ({ commit }, { lng, lat }) => {
            drugsList(
                { lng, lat },
                ({ data }) => {
                    commit('SET_DRUGS_LIST', data.documents);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getHospital: ({ commit }, { lng, lat }) => {
            hospitalList(
                { lng, lat },
                ({ data }) => {
                    commit('SET_HOSPITAL_LIST', data.documents);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
    },
};

export default kakaoStore;

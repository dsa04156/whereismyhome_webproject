import { sidoList, gugunList, dongList, houseList, rankList } from '@/api/house.js';

const houseStore = {
    namespaced: true,
    state: {
        sidos: [{ value: null, text: '시도선택' }],
        guguns: [{ value: null, text: '구군선택' }],
        dongs: [{ value: null, text: '동선택' }],
        houses: [],
        house: null,
        ranks: [],
    },
    getters: {},
    mutations: {
        CLEAR_SIDO_LIST(state) {
            state.sidos = [{ value: null, text: '시도선택' }];
        },
        CLEAR_GUGUN_LIST(state) {
            state.guguns = [{ value: null, text: '구군선택' }];
        },
        CLEAR_DONG_LIST(state) {
            state.dongs = [{ value: null, text: '동선택' }];
        },
        CLEAR_APT_LIST(state) {
            state.houses = [];
            state.houses.splice(0);
            state.house = null;
        },
        CLEAR_RANK_LIST(state) {
            state.ranks = [];
        },
        SET_SIDO_LIST(state, sidos) {
            sidos.forEach((sido) => {
                state.sidos.push({ value: sido.code, text: sido.name });
            });
        },
        SET_GUGUN_LIST(state, guguns) {
            guguns.forEach((gugun) => {
                state.guguns.push({ value: gugun.code, text: gugun.name });
            });
        },
        SET_DONG_LIST(state, dongs) {
            dongs.forEach((dong) => {
                state.dongs.push({ value: dong.code, text: dong.name });
            });
        },
        SET_HOUSE_LIST(state, houses) {
            state.houses = houses;
        },
        SET_DETAIL_HOUSE(state, house) {
            state.house = house;
        },
        SET_RANK_LIST(state, ranks) {
            state.ranks = ranks;
        },
    },
    actions: {
        getSido: ({ commit }) => {
            sidoList(
                ({ data }) => {
                    commit('SET_SIDO_LIST', data);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getGugun: ({ commit }, sidoCode) => {
            const params = { sido: sidoCode };
            gugunList(
                params,
                ({ data }) => {
                    commit('SET_GUGUN_LIST', data);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getDong: ({ commit }, gugunCode) => {
            const params = { gugun: gugunCode };
            dongList(
                params,
                ({ data }) => {
                    commit('SET_DONG_LIST', data);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getHouseList: ({ commit }, dongCode) => {
            const params = {
                dong: dongCode,
            };
            houseList(
                params,
                ({ data }) => {
                    commit('SET_HOUSE_LIST', data);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
        getRank: ({ commit }) => {
            rankList(
                ({ data }) => {
                    commit('SET_RANK_LIST', data);
                },
                (error) => {
                    console.log(error);
                }
            );
        },
    },
};

export default houseStore;

import { apiInstance } from './index.js';

const api = apiInstance();

function sidoList(success, fail) {
    api.get(`/apt/sido`).then(success).catch(fail);
}

function gugunList(params, success, fail) {
    api.get(`/apt/gugun`, { params: params }).then(success).catch(fail);
}

function dongList(params, success, fail) {
    api.get(`/apt/dong`, { params: params }).then(success).catch(fail);
}

function houseList(params, success, fail) {
    api.get(`/apt/list`, { params: params }).then(success).catch(fail);
}

function rankList(success, fail) {
    api.get(`/apt/rank`).then(success).catch(fail);
}

export { sidoList, gugunList, dongList, houseList, rankList };

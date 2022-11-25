import http from '@/api/http';

function subwayList(params, success, fail) {
    http.get(
        `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=SW8&x=${params.lng}&y=${params.lat}&radius=10000`,
        {
            headers: { Authorization: `KakaoAK ${process.env.VUE_APP_API_KAKAO_KEY}` },
        }
    )
        .then(success)
        .catch(fail);
}

function cafeList(params, success, fail) {
    http.get(
        `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=CE7&x=${params.lng}&y=${params.lat}&radius=10000`,
        {
            headers: { Authorization: `KakaoAK ${process.env.VUE_APP_API_KAKAO_KEY}` },
        }
    )
        .then(success)
        .catch(fail);
}

function cstoreList(params, success, fail) {
    http.get(
        `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=CS2&x=${params.lng}&y=${params.lat}&radius=10000`,
        {
            headers: { Authorization: `KakaoAK ${process.env.VUE_APP_API_KAKAO_KEY}` },
        }
    )
        .then(success)
        .catch(fail);
}

function drugsList(params, success, fail) {
    http.get(
        `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=PM9&x=${params.lng}&y=${params.lat}&radius=10000`,
        {
            headers: { Authorization: `KakaoAK ${process.env.VUE_APP_API_KAKAO_KEY}` },
        }
    )
        .then(success)
        .catch(fail);
}

function hospitalList(params, success, fail) {
    http.get(
        `https://dapi.kakao.com/v2/local/search/category.json?category_group_code=HP8&x=${params.lng}&y=${params.lat}&radius=10000`,
        {
            headers: { Authorization: `KakaoAK ${process.env.VUE_APP_API_KAKAO_KEY}` },
        }
    )
        .then(success)
        .catch(fail);
}

export { subwayList, cafeList, cstoreList, drugsList, hospitalList };

import axios from 'axios';

// axios 객체 생성
export default axios.create({
    baseURL: 'http://localhost:80/',
    // baseURL: 'http://192.168.31.66:80/',
    headers: {
        'Content-Type': 'application/json;charset=utf-8',
    },
});

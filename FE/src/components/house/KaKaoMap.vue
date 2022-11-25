<template>
  <div>
    <div id="wrapper">
      <div id="map" style="width: 100%; height: 70vh"></div>

      <div v-if="!isBookMarkList">
        <div v-if="isListVisible" id="showAptList" class="card p-0 bg-light" v-click-outside="onClickOutside">
          <div class="bg-white mb-2">
            <road-view :lat="lat" :lng="lng"></road-view>
            <div class="p-2 d-flex">
              <h4 class="m-0" style="font-weight: bold">{{ house.aptName }}</h4>
            </div>
            <div class="px-3 border-bottom">
              <div class="d-flex py-0">
                <div class="text-secondary w-30">{{ house.buildYear }}년 건설</div>
                <!-- <div align="right">학군 순위</div> -->
              </div>
              <div class="d-flex py-2">
                <div class="text-secondary w-30">{{ house.roadName }} {{ house.jibun }}번지</div>
              </div>
            </div>
            <!-- 매매정보 -->
            <div class="bg-white mb-2">
              <div>
                <h5 class="p-2 m-0" style="font-weight: bold">매매 정보</h5>
              </div>
              <div style="font-weight: bold">
                매매 {{ this.minAmount | toMoney }} ~ {{ this.maxAmount | toMoney }}
                <div class="column">
                  <line-chart :dealYear="dealYear" :avgAmount="avgAmount"></line-chart>
                </div>
              </div>
              <div>
                <!-- <b-button block v-b-toggle.accordion-1 variant="info">Accordion 1</b-button>
                                <b-collapse id="accordion-1" visible accordion="my-accordion" role="tabpanel"> -->
                <table id="itemList" class="w-100">
                  <thead class="bg-light text-black">
                    <tr style="font-weight: bold">
                      <td class="ps-3 py-1">거래일</td>
                      <td>거래금액</td>
                      <td>면적</td>
                      <td>층수</td>
                    </tr>
                  </thead>
                  <tbody class="px-2">
                    <tr v-for="(item, index) in houseDeal" :key="index" class="border-bottom">
                      <td class="ps-3 py-2">{{ item.dealYear }}.{{ item.dealMonth }}.{{ item.dealDay }}</td>
                      <td>{{ item.dealAmount }}만원</td>
                      <td>{{ item.area }}m<sup>2</sup></td>
                      <td>{{ item.floor }}</td>
                    </tr>
                  </tbody>
                </table>
                <b-pagination
                  v-model="currentPage"
                  pills
                  size="sm"
                  :total-rows="rows"
                  align="center"
                  @page-click="pageClick"
                ></b-pagination>
                <!-- </b-collapse> -->
              </div>
            </div>
            <!-- 주변정보 -->
            <div class="bg-white mb-2">
              <div class="border-bottom"><h5 class="p-3 m-0">주변 정보</h5></div>
              <div>
                <b-nav tabs>
                  <b-nav-item @click="getSchoolList">학군</b-nav-item>
                </b-nav>
                <div v-if="isShowSchool" class="px-3 border-bottom">
                  <div v-for="(item, index) in schools" :key="index" class="d-flex py-0">
                    <div div class="d-flex py-2">{{ item.name }} : {{ item.distance | toFixed }}m</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- 관심지역 -->
      <div v-else>
        <div
          v-show="!isListVisible"
          id="showBookMarkList"
          class="card p-0 bg-light bg-white mb-2 px-3"
          v-click-outside="onClickOutside"
        >
          <h4 class="m-0 py-2" style="font-weight: bold">관심 지역</h4>
          <div v-for="(item, index) in bookmarks" :key="index" class="py-0">
            <div class="border-bottom" style="cursor: pointer" @click="gethouses(item.dongCode)">
              <div class="py-3 flex-column text-dark w-30" style="text-align: left">
                <!-- <div class="text-dark w-30"> -->
                {{ item.sidoName }} {{ item.gugunName }} {{ item.dongName }}
                <b-button
                  pill
                  class="deleteBtn"
                  size="sm"
                  variant="outline-secondary"
                  @click="deleteBookMark(item.dongCode)"
                  >삭제</b-button
                >
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { eventBus } from "@/main";
import vClickOutside from "v-click-outside";
import RoadView from "@/components/house/RoadView.vue";
import LineChart from "@/components/house/item/LineChart.vue";

import { mapState, mapActions } from "vuex";

import http from "@/api/http";

const memberStore = "memberStore";
const houseStore = "houseStore";
const kakaoStore = "kakaoStore";

export default {
  name: "KakaoMap",
  components: {
    RoadView,
    LineChart,
  },
  directives: {
    clickOutside: vClickOutside.directive,
  },
  data() {
    return {
      map: null,
      // ps: null, // 장소 검색 객체
      // placeOverlay: null,
      // contentNode: null,
      // currCategory: '',

      markers: [],
      lat: 0,
      lng: 0,
      latitude: 0,
      longitude: 0,
      dongCode: null,
      aptList: [],
      house: null,
      houseDeal: [],
      perPage: 10,
      DealCnt: 0,
      currentPage: 1,
      isListVisible: false, // 맵 좌측에 아파트 상세정보 보여주기
      schools: [],
      isShowSchool: false,
      isAptList: false, // 마커에 해당하는 아파트 리스트 보여주기
      isBookMarkList: false, // 북마크 보여주기

      bookmarks: [],

      chart: [],
      dealYear: [],
      avgAmount: [],
      maxAmount: 0,
      minAmount: 0,

      centerlng: 0,
      centerlat: 0,

      subMarkers: [],
      cafeMarkers: [],
      cstoreMarkers: [],
      drugsMarkers: [],
      hospitalMarkers: [],

      // subways: [],
    };
  },
  computed: {
    ...mapState(memberStore, ["userInfo"]),
    ...mapState(houseStore, ["houses"]),
    ...mapState(kakaoStore, ["subway", "cafe", "cstore", "drugs", "hospital"]),
    rows() {
      return this.DealCnt;
    },
  },
  watch: {
    houses: "setHouseMarkers",
    subway: "setSubWay",
    cafe: "setCafe",
    cstore: "setStore",
    drugs: "setDrugs",
    hospital: "setHospital",
  },
  mounted() {
    if (window.kakao && window.kakao.maps) {
      this.initMap();
    } else {
      const script = document.createElement("script");
      /* global kakao */
      script.onload = () => kakao.maps.load(this.initMap);
      script.src = `//dapi.kakao.com/v2/maps/sdk.js?autoload=false&appkey=46fd494f1be679a30b9f720d1fba5c6c&libraries=services`;
      document.head.appendChild(script);
    }
  },
  created() {
    if (!("geolocation" in navigator)) {
      return;
    }

    // get position
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        this.latitude = pos.coords.latitude;
        this.longitude = pos.coords.longitude;

        if (window.kakao && window.kakao.maps) {
          this.initMap();
        }
      },
      (err) => {
        alert(err.message);
      }
    );

    eventBus.$on("setBookMarkVisible", (isBookMarkList) => {
      this.isBookMarkList = isBookMarkList;

      // 북마크 아파트 정보 가져오자
      http.get(`/apt/bookmark/${this.userInfo.id}`).then(({ data }) => {
        this.bookmarks = data;
      });
    });
  },
  methods: {
    ...mapActions(houseStore, ["getHouseList"]),
    initMap() {
      const container = document.getElementById("map");
      const options = {
        center: new kakao.maps.LatLng(33.450701, 126.570667),
        level: 5,
      };
      var map = new kakao.maps.Map(container, options);
      this.map = map;

      this.displayMarker([[this.latitude, this.longitude]]);

      kakao.maps.event.addListener(map, "center_changed", function () {
        var latlng = map.getCenter();
        // console.log(latlng);
        this.centerlng = latlng.La;
        this.centerlat = latlng.Ma;

        eventBus.$emit("getLngLat", this.centerlng, this.centerlat);
      });
    },

    displayMarker(markerPositions, markerImage) {
      if (this.markers.length > 0) {
        this.markers.forEach((marker) => marker.setMap(null));
      }

      const positions = markerPositions.map((position) => new kakao.maps.LatLng(...position));

      if (positions.length > 0) {
        this.markers = positions.map(
          (position) =>
            new kakao.maps.Marker({
              map: this.map,
              position,
              image: markerImage,
            })
        );

        const bounds = positions.reduce((bounds, latlng) => bounds.extend(latlng), new kakao.maps.LatLngBounds());

        this.map.setBounds(bounds);
      }
    },
    displayInfoWindow() {
      if (this.infowindow && this.infowindow.getMap()) {
        //이미 생성한 인포윈도우가 있기 때문에 지도 중심좌표를 인포윈도우 좌표로 이동시킨다.
        this.map.panTo(this.infowindow.getPosition());
        return;
      }

      var iwContent = '<div style="padding:5px;">현재위치</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
        iwPosition = new kakao.maps.LatLng(33.450701, 126.570667), //인포윈도우 표시 위치입니다
        iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

      this.infowindow = new kakao.maps.InfoWindow({
        map: this.map, // 인포윈도우가 표시될 지도
        position: iwPosition,
        content: iwContent,
        removable: iwRemoveable,
      });

      this.map.panTo(iwPosition);
    },

    makeOverListener(map, marker, infowindow) {
      return function () {
        infowindow.open(map, marker);
      };
    },
    makeOutListener(infowindow) {
      return function () {
        infowindow.close();
      };
    },
    onClickOutside() {
      this.isListVisible = false;
      this.isBookMarkList = false;
      eventBus.$emit("setBookMarkVisible", this.isBookMarkList);
    },
    pageClick(bvEvent, page) {
      this.currentPage = page;
      this.getAptListByPage(page);
    },
    getAptListByPage(page) {
      this.loading = true;
      http.get(`/apt/dealList/${this.house.aptCode}/${page}`).then(({ data }) => {
        this.houseDeal = data;
      });
    },
    setRoadView() {
      var roadviewClient = new kakao.maps.RoadviewClient(); //좌표로부터 로드뷰 파노ID를 가져올 로드뷰 helper객체
      var position = new kakao.maps.LatLng(this.house.lat, this.house.lng);

      roadviewClient.getNearestPanoId(position, 130, function (panoId) {
        this.roadview.setPanoId(panoId, position);
      });
    },
    setPosition(lat, lng) {
      this.lat = lat;
      this.lng = lng;
    },
    getSchoolList() {
      this.isShowSchool = !this.isShowSchool;
      // 아파트 기준, 1km 내 학교 정보 출력
      http.get(`/apt/schoolList`, { params: { lng: this.house.lng, lat: this.house.lat } }).then(({ data }) => {
        this.schools = data;
      });
    },
    setCenter(lat, lng) {
      var moveLatLon = new kakao.maps.LatLng(lat, lng);

      this.map.relayout();
      this.map.panTo(moveLatLon);
    },
    gethouses(dongcode) {
      this.getHouseList(dongcode);
    },
    deleteBookMark(dongcode) {
      http.delete("/apt/deleteBookMark", { params: { id: this.userInfo.id, code: dongcode } }).then(({ data }) => {
        let msg = "삭제 처리시 문제가 발생했습니다.";
        if (data === "success") {
          msg = "삭제 완료되었습니다.";
        }
        alert(msg);
        eventBus.$emit("setBookMarkVisible", this.isBookMarkList);
      });
    },
    setHouseMarkers() {
      this.displayMarker([[this.houses[0].lat, this.houses[0].lng]], markerImage);

      if (this.markers.length > 0) {
        this.markers.forEach((marker) => marker.setMap(null));
      }
      this.markers.forEach((marker) => marker.setMap(null));

      if (this.houses.length == 0) window.alert("해당 지역의 아파트 매매 정보가 없습니다!");

      // 마커 이미지 설정
      var houseMarker =
        "https://user-images.githubusercontent.com/108286046/203690128-51491319-0008-473f-9adb-f95242aa3ec1.png";
      var imageSize = new kakao.maps.Size(40, 45);
      var imageOption = { offset: new kakao.maps.Point(27, 69) };
      var markerImage = new kakao.maps.MarkerImage(houseMarker, imageSize, imageOption);

      this.houses.forEach((item) => {
        let latlng = new kakao.maps.LatLng(item.lat, item.lng);

        const marker = new kakao.maps.Marker({
          map: this.map,
          position: latlng,
          title: item.aptName,
          image: markerImage,
        });
        this.infowindow = new kakao.maps.InfoWindow({
          content: item.aptName,
        });

        this.markers.push(marker);

        kakao.maps.event.addListener(marker, "click", () => {
          this.dealYear.splice(0, this.dealYear.length);
          this.avgAmount.splice(0, this.avgAmount.length);
          // 아파트 매매 정보를 보여준다.
          this.isListVisible = true;
          this.currentPage = 1;

          this.house = item;

          this.lat = Number(this.house.lat);
          this.lng = Number(this.house.lng);

          // 여기서 아파트 정보 가져오자
          http.get(`/apt/dealListSize/${this.house.aptCode}`).then(({ data }) => {
            this.DealCnt = data;
          });
          http.get(`apt/aptAvg/${this.house.aptCode}`).then(({ data }) => {
            this.chart = data;

            this.chart.forEach((item) => {
              item.dealYear = item.dealYear.substr(2, 4);
              item.dealYear = item.dealYear.concat(".", item.dealMonth);

              this.dealYear.push(item.dealYear);
              this.avgAmount.push(parseInt(item.avgAmount) * 1000);
            });
          });
          http.get(`apt/AvgMax/${this.house.aptCode}`).then(({ data }) => {
            this.maxAmount = data;
          });
          http.get(`apt/AvgMin/${this.house.aptCode}`).then(({ data }) => {
            this.minAmount = data;
          });
          http.get(`/apt/dealList/${this.house.aptCode}/1`).then(({ data }) => {
            this.houseDeal = data;
          });

          // 학군 정보도 가져오자
          this.getSchoolList();
        });
      });
    },

    setSubWay() {
      var imageSrc =
        "https://user-images.githubusercontent.com/108286046/203683300-56d2d1a1-5760-4c9b-83e8-22c9dfc99e2c.png"; // 마커 이미지 url, 스프라이트 이미지를 씁니다
      var imageSize = new kakao.maps.Size(35, 40);
      var imageOption = { offset: new kakao.maps.Point(27, 69) };
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

      this.setMarker(this.subMarkers, this.subway, markerImage);
    },

    setCafe() {
            var imageSrc =
            'https://user-images.githubusercontent.com/108286046/203722866-90d47f5b-aaf5-41c9-995d-237708816cc4.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
            var imageSize = new kakao.maps.Size(30, 35);
            var imageOption = { offset: new kakao.maps.Point(27, 69) };
            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

            this.setMarker(this.cafeMarkers, this.cafe, markerImage);
        },

    setStore() {
      var imageSrc =
        "https://user-images.githubusercontent.com/108286046/203690237-a1b862fc-6394-4ca9-b643-decacb7e0aef.png"; // 마커 이미지 url, 스프라이트 이미지를 씁니다
      var imageSize = new kakao.maps.Size(35, 40);
      var imageOption = { offset: new kakao.maps.Point(27, 69) };
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

      this.setMarker(this.cstoreMarkers, this.cstore, markerImage);
    },

    setDrugs() {
      var imageSrc =
        "https://user-images.githubusercontent.com/108286046/203713319-b1d7263f-4d13-476b-b8c4-beed524dc049.png"; // 마커 이미지 url, 스프라이트 이미지를 씁니다
      var imageSize = new kakao.maps.Size(35, 40);
      var imageOption = { offset: new kakao.maps.Point(27, 69) };
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

      this.setMarker(this.drugsMarkers, this.drugs, markerImage);
    },

    setHospital() {
      var imageSrc =
        "https://user-images.githubusercontent.com/108286046/203713457-3d0eec3d-7fd9-4785-87b3-1b19d1487968.png"; // 마커 이미지 url, 스프라이트 이미지를 씁니다
      var imageSize = new kakao.maps.Size(35, 40);
      var imageOption = { offset: new kakao.maps.Point(27, 69) };
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

      this.setMarker(this.hospitalMarkers, this.hospital, markerImage);
    },

    setMarker(markers, items, markerImage) {
      if (markers.length > 0) {
        markers.forEach((marker) => marker.setMap(null));
      }

      items.forEach((item) => {
        let latlng = new kakao.maps.LatLng(item.y, item.x);

        const marker = new kakao.maps.Marker({
          map: this.map,
          position: latlng,
          title: item.aptName,
          image: markerImage,
        });
        this.infowindow = new kakao.maps.InfoWindow({
          content: item.place_name,
        });

        markers.push(marker);

        kakao.maps.event.addListener(marker, "click", () => {
          var iwContent = `<div style="padding:5px;">${item.place_name}</div>`, // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
            iwPosition = new kakao.maps.LatLng(33.450701, 126.570667),
            iwRemoveable = true; //인포윈도우 표시 위치입니다

          // 인포윈도우를 생성합니다
          var infowindow = new kakao.maps.InfoWindow({
            position: iwPosition,
            content: iwContent,
            removable: iwRemoveable,
          });

          infowindow.open(this.map, marker);
        });
      });
    },
  },
  filters: {
    toFixed: function (val) {
      return parseInt(val).toFixed(0);
    },
    toMoney: function (val) {
      return parseInt(val / 10000) + "억" + (val % 10000);
    },
  },
};
</script>

<style>
#wrapper {
  position: relative;
}
#showAptList {
  position: absolute;

  top: 0px;
  bottom: 0px;
  left: 0px;

  border-radius: 10px;

  width: 400px;
  padding: 10px;

  z-index: 100;

  overflow-y: auto;
}
#showBookMarkList {
  position: absolute;

  top: 0px;
  bottom: 0px;
  left: 0px;

  border-radius: 10px;

  width: 400px;
  padding: 10px;

  z-index: 100;

  overflow-y: auto;
}
.deleteBtn {
  float: right;
}
</style>

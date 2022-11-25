<template>
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="collapse navbar-collapse" id="navbarScroll">
          <!-- <div id="apt" style="font-weight: bold">아파트 매매정보</div> -->
          <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll" style="--bs-scroll-height: 100px">
              <li id="apt">
                  <!-- <div id="apt" style="font-weight: bold">아파트 매매정보</div> -->
                  <b-nav-item class="nav-link" style="font-weight: bold">아파트 매매정보</b-nav-item>
              </li>
              <li id="bookmark">
                  <b-nav-item class="nav-link" @click="setBookMarkVisible">관심지역</b-nav-item>
              </li>
              <li>
                  <b-form-select class="option" v-model="sidoCode" :options="sidos" @change="gugunList"></b-form-select>
              </li>
              <li>
                  <b-form-select class="option" v-model="gugunCode" :options="guguns" @change="dongList"></b-form-select>
              </li>
              <li>
                  <b-form-select class="option" v-model="dongCode" :options="dongs" @change="searchApt"></b-form-select>
              </li>
              <li>
                  <b-button variant="outline-secondary" @click="setBookMarkArea">관심지역추가</b-button>
              </li>
              <li class="checkbox">
                  <b-form-group v-slot="{ ariaDescribedby }">
                      <b-form-checkbox-group
                          id="checkbox-group-1"
                          v-model="selected"
                          :options="options"
                          :aria-describedby="ariaDescribedby"
                          name="flavour-1"
                          @change="changeSelected"
                      ></b-form-checkbox-group>
                  </b-form-group>
                  <!-- <div class="form-check form-check-inline">
                      <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="SW8" />
                      <label class="form-check-label" for="inlineCheckbox3">지하철역</label>
                  </div>
                  <div class="form-check form-check-inline">
                      <input class="form-check-input" type="checkbox" id="inlineCheckbox1" value="HP8" />
                      <label class="form-check-label" for="inlineCheckbox1">병원</label>
                  </div>
                  <div class="form-check form-check-inline">
                      <input class="form-check-input" type="checkbox" id="inlineCheckbox3" value="BK9" />
                      <label class="form-check-label" for="inlineCheckbox3">은행</label>
                  </div> -->
              </li>
              <!-- <li>
                  <input
                      class="form-control me-2"
                      type="search"
                      placeholder="아파트 이름을 검색하세요."
                      aria-label="Search"
                      @keyup="keyPress"
                  />

                  <search-item v-if="false"></search-item>
              </li> -->
          </ul>
      </div>
      <!-- </div> -->
  </nav>
</template>

<script>
import { mapState, mapActions, mapMutations } from 'vuex';
import { eventBus } from '@/main';

// import SearchItem from '@/components/house/item/SearchItem.vue';

const memberStore = 'memberStore';
const houseStore = 'houseStore';
const kakaoStore = 'kakaoStore';

import http from '@/api/http';

export default {
  name: 'HouseSearchBar',
  components: {
      // SearchItem,
  },
  data() {
      return {
          sidoCode: null,
          gugunCode: null,
          dongCode: null,
          isAptList: false,
          isBookMarkList: false,

          apts: [],

          centerlng: 0,
          centerlat: 0,

          selected: [],
          options: [
              { text: '지하철역', value: 'SW8' },
              { text: '카페', value: 'CE7' },
              { text: '편의점', value: 'CS2' },
              { text: '약국', value: 'PM9' },
              { text: '병원', value: 'HP8' },
          ],
      };
  },
  computed: {
      ...mapState(houseStore, ['sidos', 'guguns', 'dongs']),
      ...mapState(memberStore, ['userInfo']),
      ...mapState(kakaoStore, ['subway', 'cafe', 'cstore', 'drugs', 'hospital']),
  },
  created() {
      this.CLEAR_SIDO_LIST();
      this.CLEAR_APT_LIST();
      this.getSido();

      this.CLEAR_SUBWAY_LIST();

      eventBus.$on('setBookMarkVisible', (isBookMarkList) => {
          this.isBookMarkList = isBookMarkList;
      });

      eventBus.$on('getLngLat', (lng, lat) => {
          this.selected = [];
          this.centerlng = lng;
          this.centerlat = lat;
          // console.log(this.centerlng, this.centerlat);
      });
  },
  mounted() {
      eventBus.$on('getLngLat', (lng, lat) => {
          this.centerlng = lng;
          this.centerlat = lat;
          // console.log(this.centerlng, this.centerlat);
      });
  },
  methods: {
      ...mapActions(houseStore, ['getSido', 'getGugun', 'getDong', 'getHouseList']),
      ...mapMutations(houseStore, ['CLEAR_SIDO_LIST', 'CLEAR_GUGUN_LIST', 'CLEAR_DONG_LIST', 'CLEAR_APT_LIST']),

      ...mapActions(kakaoStore, ['getSubway', 'getCafe', 'getCstore', 'getDrugs', 'getHospital']),
      ...mapMutations(kakaoStore, [
          'CLEAR_SUBWAY_LIST',
          'CLEAR_CAFE_LIST',
          'CLEAR_CSTORE_LIST',
          'CLEAR_DRUGS_LIST',
          'CLEAR_HOSPITAL_LIST',
      ]),

      gugunList() {
          this.CLEAR_GUGUN_LIST();
          this.CLEAR_DONG_LIST();
          this.gugunCode = null;
          this.dongCode = null;
          if (this.sidoCode) this.getGugun(this.sidoCode);
      },
      dongList() {
          this.CLEAR_DONG_LIST();
          this.dongCode = null;
          if (this.gugunCode) {
              this.getDong(this.gugunCode);
              this.selected = [];
          }
      },
      searchApt() {
          // this.CLEAR_APT_LIST();
          if (this.dongCode) this.getHouseList(this.dongCode);
      },
      setAptVisible() {
          this.isAptList = !this.isAptList;
          eventBus.$emit('setAptVisible', this.isAptList);
      },
      setBookMarkVisible() {
          if (this.userInfo != null) {
              this.isBookMarkList = !this.isBookMarkList;
              eventBus.$emit('setBookMarkVisible', this.isBookMarkList);
          } else {
              window.alert('회원만 이용가능합니다.');
          }
      },
      setBookMarkArea() {
          if (this.userInfo != null) {
              //db에 북마크 추가할겜
              http.post(`/apt/addBookMark`, null, { params: { id: this.userInfo.id, code: this.dongCode } }).then(
                  ({ data }) => {
                      let msg = '등록 처리시 문제가 발생했습니다.';
                      if (data === 'success') {
                          msg = '등록이 완료되었습니다.';
                      }
                      alert(msg);
                  }
              );
          } else {
              window.alert('회원만 이용가능합니다.');
          }
      },
      keyPress: function (e) {
          var text = e.target.value;
          console.log(text);
      },
      changeSelected() {
          // console.log(this.selected);
          this.CLEAR_SUBWAY_LIST();
          this.CLEAR_CAFE_LIST();
          this.CLEAR_CSTORE_LIST();
          this.CLEAR_DRUGS_LIST();
          this.CLEAR_HOSPITAL_LIST();

          if (this.selected.includes('SW8')) {
              this.getSubway({ lng: this.centerlng, lat: this.centerlat });
          }
          if (this.selected.includes('CE7')) {
              this.getCafe({ lng: this.centerlng, lat: this.centerlat });
          }
          if (this.selected.includes('CS2')) {
              this.getCstore({ lng: this.centerlng, lat: this.centerlat });
          }
          if (this.selected.includes('PM9')) {
              this.getDrugs({ lng: this.centerlng, lat: this.centerlat });
          }
          if (this.selected.includes('HP8')) {
              this.getHospital({ lng: this.centerlng, lat: this.centerlat });
          }
      },
  },
};
</script>

<style>
ul {
  padding: 5px 5px 5px 5px;
}
li {
  padding: 0px 5px;
}
.navbar-nav {
  padding: 20px 0 1px 0px;
}
.nav-link {
  padding: 0px 0px 10px 30px;
}
#apt {
  padding: 0px 0px 0px 40px;
}
#bookmark {
  padding: 0px 80px 0px 20px;
}
.option {
  padding: 10px 0px 0px 0px;
}
.checkbox {
  padding: 10px 0px 0px 30px;
}
</style>
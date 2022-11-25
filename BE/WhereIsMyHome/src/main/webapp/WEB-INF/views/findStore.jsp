<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>where Is My Home | Commercial Area</title>
    <%@ include file="/include/head.jsp" %>
    <style>
        .block::-webkit-scrollbar {
            display: none;
        }
    </style>
</head>

<body>
    <%@ include file="/include/nav.jsp" %>

    <!-- Page Header Start -->
    <div class="container-fluid page-header mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center">
            <h1 class="display-4 text-white animated slideInDown mb-4">Find Commercial Area</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <div class="row col-md-12 justify-content-center mb-2">
                        <div class="form-group col-md-2">
                            <select class="form-select bg-secondary text-darks" id="category">
                                <option value="all">카테고리 선택</option>
                                <option value="MT1">대형마트</option>
                                <option value="CS2">편의점</option>
                                <option value="PS3">어린이집 & 유치원</option>
                                <option value="SC4">학교</option>
                                <option value="AC5">학원</option>
                                <option value="PK6">주차장</option>
                                <option value="OL7">주유소 & 충전소</option>
                                <option value="SW8">지하철역</option>
                                <option value="BK9">은행</option>
                                <option value="CT1">문화시설</option>
                                <option value="AG2">중개업소</option>
                                <option value="PO3">공공기관</option>
                                <option value="AT4">관광명소</option>
                                <option value="AD5">숙박</option>
                                <option value="FD6">음식점</option>
                                <option value="CE7">카페</option>
                                <option value="HP8">병원</option>
                                <option value="PM9">약국</option>
                            </select>
                        </div>
                        <button type="button" id="findArea" class="btn btn-outline-primary" style="width: 210px" onclick="clickBtn()">
                            정보 불러 오기
                        </button>
                    </div>
                </ol>
            </nav>
        </div>
    </div>
    <!-- Page Header End -->
    
    <!-- Modal -->
    <div class="modal fade" id="warning" tabindex="-1" aria-labelledby="warningLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="alert alert-danger container" style="margin-bottom: -10px;">
                    <div class="flex-column">
                        <div class="float-end">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="">
                            <strong>주의!</strong> 카테고리를 선택후 정보를 불러주세요.
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-body">
                    <p class="h5 text-white">**주의** 카테고리를 선택하고 정보를 불러 주세요!!</p>
                </div> -->
            </div>
        </div>
    </div>

    <!-- 아파트 전월세, 매매 정보 출력 + 지도 출력 -->
    <!-- Contact Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">
                <div class="col-lg-5 wow fadeIn" data-wow-delay="0.1s" id="houseInfo" style="visibility: none;">
                    <div class="d-inline-block rounded-pill bg-secondary text-primary py-1 px-3 mb-3">지역 선택 -> 카테고리 선택 -> 정보 불러오기</div>
                    <div class="sidebar">
                        <div class="block" id="aptlist"
                            style="overflow:scroll; overflow-x: hidden; width:450px; height:600px;">
                            <h3 class="title pb-2">캠퍼스 정보</h3>
                            <div class="media margin-clear">
                                <div class="media-body">
                                    <h4><a href='javascript:moveCampus("서울시 강남구 테헤란로 212","서울 캠퍼스");'>서울 캠퍼스(멀티 스퀘어)</a></h4>
                                    <h6 class="media-heading" id='deal'>대표전화 : 02-3429-5100</h6>
                                    <h6 class="media-heading" id='deal'>주소: 서울시 강남구 테헤란로 212</h6>
                                </div>
                                <hr>
                                <div class="media-body">
                                    <h4><a href='javascript:moveCampus("대전광역시 유성구 동서대로 98-39","대전 캠퍼스");'>대전 캠퍼스(삼성화재 유성연수원)</a>
                                    </h4>
                                    <h6 class="media-heading" id='deal'>대표전화 : 042-820-7385</h6>
                                    <h6 class="media-heading" id='deal'>주소: 대전광역시 유성구 동서대로 98-39</h6>
                                </div>
                                <hr>
                                <div class="media-body">
                                    <h4><a href='javascript:moveCampus("광주광역시 광산구 하남산단 6번로 107","광주 캠퍼스");'>광주 캠퍼스(삼성전자 광주사업장)</a>
                                    </h4>
                                    <h6 class="media-heading" id='deal'>대표전화 : 02-3429-5100</h6>
                                    <h6 class="media-heading" id='deal'>주소: 광주광역시 광산구 하남산단 6번로 107</h6>
                                </div>
                                <hr>
                                <div class="media-body">
                                    <h4><a href='javascript:moveCampus("경북 구미시 3공단 3로 302","구미 캠퍼스");'>구미 캠퍼스(삼성전자 구미사업장)</a>
                                    </h4>
                                    <h6 class="media-heading" id='deal'>대표전화 : 02-3429-5100</h6>
                                    <h6 class="media-heading" id='deal'>주소: 경북 구미시 3공단 3로 302</h6>
                                </div>
                                <hr>
                                <div class="media-body">
                                    <h4><a href='javascript:moveCampus("부산광역시 강서구 송정동 녹산산업중로 333","부울경 캠퍼스");'>부울경 캠퍼스(삼성전기 부산사업장)</a>
                                    </h4>
                                    <h6 class="media-heading" id='deal'>대표전화 : 02-3429-5100</h6>
                                    <h6 class="media-heading" id='deal'>주소: 부산광역시 강서구 송정동 녹산산업중로 333</h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 카카오 지도 영역 선언 -->
                <div id="map" class="col-lg-6 wow fadeIn" style="width:600px; height: 650px;"></div>
                <script type="text/javascript"src="//dapi.kakao.com/v2/maps/sdk.js?appkey=46fd494f1be679a30b9f720d1fba5c6c&libraries=services"></script>
            </div>
        </div>
    </div>
    <!-- Contact End -->

    <!-- Footer Start -->
    <%@ include file="/include/footer.jsp" %>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>

    <script>

        // 카카오 맵 API 영역 //
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
            level: 4 //지도의 레벨(확대, 축소 정도)
        };
        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

        // 카테고리 마커 클릭시 해당 장소 상세 정보를 보여줄 커스텀 오버레이
        var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}),
        contentNode = document.createElement('div'),
        markers=[],
        currCategory ='';

        // 장소 검색 개체 생성
        var ps = new kakao.maps.services.Places(map);

        // 지도에 idle 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', searchPlaces);

        // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
        contentNode.className = 'placeinfo_wrap';

        // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
        // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
        addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
        addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

        // 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로             호출하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'center_changed', function() {
            let data = document.getElementById('category').value;
            if(data != 'all'){
                searchPlaces(data);
            }
        })

        // 커스텀 오버레이 컨텐츠를 설정합니다
        placeOverlay.setContent(contentNode);

            // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
            function addEventHandle(target, type, callback) {
                if (target.addEventListener) {
                    target.addEventListener(type, callback);
                } else {
                    target.attachEvent('on' + type, callback);
                }
            }

            function clickBtn() {
                let data = document.getElementById('category').value;
                if(data != 'all'){
                    searchPlaces(data);
                }
                else{
                    $('#warning').modal('show');
                    // alert("카테고리 선택을 해주세요!");
                }
            }
            // 카테고리 검색을 요청하는 함수입니다
            function searchPlaces(currCategory) {
                if (!currCategory) {
                    return;
                }

                // 커스텀 오버레이를 숨깁니다 
                placeOverlay.setMap(null);

                // 지도에 표시되고 있는 마커를 제거합니다
                removeMarker();

                ps.categorySearch(currCategory, placesSearchCB, { useMapBounds: true });
            }

            // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
                    displayPlaces(data);
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

                } else if (status === kakao.maps.services.Status.ERROR) {
                    // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요

                }
            }

            // 지도에 마커를 표출하는 함수입니다
            function displayPlaces(places) {

                // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
                // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
                // var order = document.getElementById(currCategory).getAttribute('data-order');



                for (var i = 0; i < places.length; i++) {

                    // 마커를 생성하고 지도에 표시합니다
                    // var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);
                    var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), 1);

                    // 마커와 검색결과 항목을 클릭 했을 때
                    // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
                    (function (marker, place) {
                        kakao.maps.event.addListener(marker, 'click', function () {
                            displayPlaceInfo(place);
                        });
                    })(marker, places[i]);
                }
            }

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            function addMarker(position, order) {
                // var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                var imageSrc = 'https://cdn.pixabay.com/photo/2014/04/03/10/03/google-309739_960_720.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
                
                    imageSize = new kakao.maps.Size(27, 35),  // 마커 이미지의 크기
                    imgOptions = {
                        spriteSize: new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
                        // spriteOrigin: new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        spriteOrigin: new kakao.maps.Point(46, (1 * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
                        offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
                    },
                    // markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize),
                    marker = new kakao.maps.Marker({
                        position: position, // 마커의 위치
                        image: markerImage
                    });

                marker.setMap(map); // 지도 위에 마커를 표출합니다
                markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                return marker;
            }

            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            function removeMarker() {
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers = [];
            }

            // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
            function displayPlaceInfo(place) {

                let content =
                `
                <div class="placeinfo">
                    <a class="title" href=`+ '"' + place.plcae_url + '"' + `target="_blank" title=`+ '"' + place.place_name + '"' + `>` + place.place_name + `</a>
                `;
                if(place.road_address_name){
                    content +=
                    `
                        <span title=`+ '"' + place.road_address_name + '"' + `>` + place.road_address_name + `</span>
                        <span class="jibun" title=`+ '"' + place.address_name + '"' + `>(지번 : ` + place.address_name + `)</span>
                    `;
                }
                else{
                    `
                        <span title=`+ '"' + place.address_name + '"' + `>` + place.address_name + `</span>
                    `;
                }
                content +=
                `
                    <span class="tel">` + place.phone + `</span>
                </div>
                <div class="after"></div>
                `;

                contentNode.innerHTML = content;
                placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
                placeOverlay.setMap(map);
            }


            // 각 카테고리에 클릭 이벤트를 등록합니다
            function addCategoryClickEvent() {
                var category = document.getElementById('category'),
                    children = category.children;

                for (var i = 0; i < children.length; i++) {
                    children[i].onclick = onClickCategory;
                }
            }

        // 지도에서 일반, 스카이뷰 타입을 전송할 컨트롤 생성
        var mapTypeControl = new kakao.maps.MapTypeControl();

        // 지도에 일반/스카이뷰 추가
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

        var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.BOTTOMRIGHT);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
        if (navigator.geolocation) {

            // GeoLocation을 이용해서 접속 위치를 얻어옵니다
            navigator.geolocation.getCurrentPosition(function (position) {

                var lat = position.coords.latitude, // 위도
                    lon = position.coords.longitude; // 경도

                var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                    message = '<div style="padding:5px;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다
                // 마커와 인포윈도우를 표시합니다
                displayMarker(locPosition, message);

            });

        } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

            var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
                message = '위치를 찾을 수 없습니다.'

            displayMarker(locPosition, message);
        }

        // 지도에 마커와 인포윈도우를 표시하는 함수입니다
        function displayMarker(locPosition, message) {

            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: locPosition
            });

            var iwContent = message, // 인포윈도우에 표시할 내용
                iwRemoveable = true;

            // 인포윈도우를 생성합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: iwContent,
                removable: iwRemoveable
            });

            // 인포윈도우를 마커위에 표시합니다 
            infowindow.open(map, marker);

            // 지도 중심좌표를 접속위치로 변경합니다
            map.setCenter(locPosition);
        }
        // 카카오 맵 API 영역 끝//

        function moveCampus(address, nickname) {
            geocoder.addressSearch(address, function(result, status){
                if (status === kakao.maps.services.Status.OK){
                    let coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    let infowindow = new kakao.maps.InfoWindow({
                        content: `<div style="width:150px;text-align:center;padding:6px 0;">` + nickname + `</div>`
                    });
                    infowindow.open(map,marker);

                    map.setCenter(coords);
                    map.setLevel(4);
                }
            });
        }

    </script>
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/parallax/parallax.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>
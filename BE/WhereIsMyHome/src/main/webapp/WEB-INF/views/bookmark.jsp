<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Find APT</title>
    <!--  head Include -->
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <!-- ------------- -->
    <style>
        .block::-webkit-scrollbar {
            display: none;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>

<body>
	<!-- Nave Include -->
    <%@ include file="/WEB-INF/views/include/nav.jsp" %>
    <!-- ------------ -->

    <!-- Page Header Start -->
    <div class="container-fluid page-header mb-5 wow fadeIn" data-wow-delay="0.1s">
        <div class="container text-center">
            <h1 class="display-4 text-white animated slideInDown mb-4">BookMark Area</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <div class="row col-md-12 justify-content-center mb-2">
                        <div class="form-group col-md-2" style="width: 300px">
                            <select class="form-select bg-secondary text-darks" id="bookmark" >
                                <option value="all">관심지역 선택</option>
                            </select>
                        </div>
                        <button type="button" id="list-btn" class="btn btn-outline-primary" style="width: 150px">
                            	정보 가져오기
                        </button>
                        &nbsp;&nbsp;&nbsp;
                        <button type="button" id="btnBDelete" class="btn btn-outline-primary" style="width: 150px">
                            	관심지역 삭제
                        </button>
                    </div>
        </div>
        </ol>
        </nav>
    </div>
    </div>
    <!-- Page Header End -->

    <!-- 아파트 전월세, 매매 정보 출력 + 지도 출력 -->
    <!-- Contact Start -->
    <div class="container-xxl py-5">
        <div class="container">
            <div class="row g-5">

                <div class="col-lg-5 wow fadeIn" data-wow-delay="0.1s" id="houseInfo" style="visibility: none;">
                    <div class="d-inline-block rounded-pill bg-secondary text-primary py-1 px-3 mb-3">관심지역 거래 정보</div>
                    <div class="sidebar">

                        <div class="block" id="aptlist"
                            style="overflow:scroll; cursor:pointer; overflow-x: hidden; width:450px; height:600px;">
                        </div>
                    </div>
                </div>

                <!-- 카카오 지도 영역 선언 -->
                <div id="map" class="col-lg-6 wow fadeIn" style="width:600px; height: 650px;"></div>
                <script type="text/javascript"
                    src="//dapi.kakao.com/v2/maps/sdk.js?appkey=46fd494f1be679a30b9f720d1fba5c6c&libraries=services"></script>
            </div>
        </div>
    </div>
    </div>
    <!-- Contact End -->

    <script>

        // 카카오 맵 API 영역 //
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
        if (navigator.geolocation) {

            // GeoLocation을 이용해서 접속 위치를 얻어옵니다
            navigator.geolocation.getCurrentPosition(function (position) {

                var lat = position.coords.latitude, // 위도
                    lon = position.coords.longitude; // 경도

                var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                // var locPosition = new kakao.maps.LatLng(36.1064011,128.4163183), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
                                message = '<div style="padding:5px;">현재위치</div>'; // 인포윈도우에 표시될 내용입니다
                // 마커와 인포윈도우를 표시합니다
                displayMarker(locPosition, message);

            });

        } else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

            var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
                message = 'geolocation을 사용할수 없어요..'

            displayMarker(locPosition, message);
        }

        // 지도에 마커와 인포윈도우를 표시하는 함수입니다
        function displayMarker(locPosition, message) {

            // 마커를 생성합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: locPosition
            });
			markers.push(marker);
            var iwContent = message, // 인포윈도우에 표시할 내용
                iwRemoveable = true;

            // 인포윈도우를 생성합니다
            var infowindow = new kakao.maps.InfoWindow({
                content: iwContent,
                removable: iwRemoveable
            });
			infows.push(infowindow);
            // 인포윈도우를 마커위에 표시합니다 
            infowindow.open(map, marker);

            // 지도 중심좌표를 접속위치로 변경합니다
            map.setCenter(locPosition);
        }
        // 카카오 맵 API 영역 끝//

        let date = new Date();
     	// 시작시 옵션 추가
        window.onload = function () {
        	let id = `${sessionScope.userInfo.id}`;
        	//let uri = `${root}/apt?action=searchBookMark&id=`+id;
        	
        	let uri = `/apt/bookmark/` + id;
        	
        	fetch(uri)
          	.then((response) => response.json())
          	.then((data) =>{
          		
          		console.log(data);
          		
          		data.forEach(function(item){
          			let opt = document.createElement('option');
          			opt.setAttribute('value',item.dongCode);
          			opt.innerText = item.sidoName+' '+item.gugunName+' '+ item.dongName;
          			document.querySelector('#bookmark').appendChild(opt);
          		});
          		
          	});
        };
        document.querySelector("#btnBDelete").addEventListener("click", function () {
        	let code = document.querySelector("#bookmark");
        	let locationText = code.options[code.selectedIndex].text;
        	code = code[code.selectedIndex].value;
        	let id = `${sessionScope.userInfo.id}`;
        	
        	//let uri = `${root}/apt?action=deleteBookMark&id=`+id+`&code=`+code;
        	
        	let uri = `/apt/deleteBookMark/` + code;
        	fetch(uri, {
        		method : "DELETE",
        	})
          	.then(alert(locationText+' 삭제 완료'));
        	
        	document.querySelector('#bookmark').innerHTML="";
        	let init = document.createElement('option');
        	init.setAttribute('value','all');
        	init.innerText = '관심지역 선택';
        	document.querySelector('#bookmark').appendChild(init);
        	
        	//uri = `${root}/apt?action=searchBookMark&id=`+id;
        	
        	uri = `/apt/bookmark/` + id;
        	
        	fetch(uri)
          	.then((response) => response.json())
          	.then((data) =>{
          		
				console.log(data);
          		
          		data.forEach(function(item){
          			let opt = document.createElement('option');
          			opt.setAttribute('value',item.dongCode);
          			opt.innerText = item.sidoName+' '+item.gugunName+' '+ item.dongName;
          			document.querySelector('#bookmark').appendChild(opt);
          		});
          		

          	});
        });
        var markers = [];
        var infows = [];
        ///////////////////////// 아파트 매매 정보 /////////////////////////
        document.querySelector("#list-btn").addEventListener("click", function () {
        	// 최종적으로 동 까지 코드가 우리가 원하는 전체 code 이므로 dong의 코드를 저장하기.
        	let code = document.querySelector("#bookmark");
        	let dongname = code.options[code.selectedIndex].text;
        	code = code[code.selectedIndex].value;
        	console.log("code : "+ code);
        	document.querySelector("#houseInfo").setAttribute("style", "visibility: ;");
            let tbody = document.querySelector("#aptlist");
            tbody.innerHTML = "";
            
        	//let uri = `${root}/apt?action=searchApt&code=`;
        	
        	let uri = `/apt/bookmarklist/`;
        	
        	fetch(uri+code)
          	.then((response) => response.json())
          	.then((data) =>{
          		
          		
				var cnt = 0;
          	
          		
          		//data.forEach(function (item){
          		for(item in data){
          			
          			cnt++;
          			
          			let tr = document.createElement("div");
                    tr.setAttribute("class", "aptName");

                    let nameTd = document.createElement("h4");
                    let aptName = document.createTextNode(data[item].aptName);
                    
                    let lng = document.createElement("input");
                    lng.setAttribute("type", "hidden");
                    lng.setAttribute("class", "lng");
                    lng.setAttribute("value", data[item].lng);
                    
                    let lat = document.createElement("input");
                    lat.setAttribute("type", "hidden");
                    lat.setAttribute("class", "lat");
                    lat.setAttribute("value", data[item].lat);
                    console.log('lat : ' + data[item].lat);
                    
                    let aptText = document.createElement("input");
                    aptText.setAttribute("type", "hidden");
                    aptText.setAttribute("class", "aptName");
                    aptText.setAttribute("value", data[item].aptName);
                    
                    nameTd.appendChild(aptName);
                    nameTd.appendChild(lng);
                    nameTd.appendChild(lat);                    
                    nameTd.appendChild(aptText);                    
                    
                    nameTd.setAttribute("class", "text-primary aptName");
                    tr.appendChild(nameTd);

                    let areaTd = document.createElement("h6");
                    areaTd.appendChild(document.createTextNode(data[item].area));
                    tr.appendChild(areaTd);

                    let dongTd = document.createElement("h6");
                    dongTd.appendChild(document.createTextNode(dongname));
                    let aptInfo = dongname;
                    aptInfo += data[item].aptName;
                    console.log("aptInfo : "+aptInfo);
                    tr.setAttribute("value", aptInfo);
                    //console.log(aptInfo);
                    tr.appendChild(dongTd);

                    let priceTd = document.createElement("h6");
                    priceTd.appendChild(document.createTextNode("최고 거래금액 : " + data[item].dealAmount+"만원"));
                    priceTd.classList.add("text-end");
                    tr.appendChild(priceTd);

                    tr.appendChild(document.createElement("hr"));

                    tbody.appendChild(tr);
                    console.log(tr);
          		}
          		
          		
          		if(cnt == 0){
          			let tr = document.createElement("div");
          			let nameTd = document.createElement("h4");
                    let aptName = document.createTextNode(dongname+' 은(는) 거래내역이 없습니다.');
                    nameTd.appendChild(aptName);
                    nameTd.setAttribute("class", "text-primary");
                    tr.appendChild(nameTd);
                    tr.appendChild(document.createElement("hr"));
                    tbody.appendChild(tr);
          		}
          		
        	let target = document.querySelectorAll('.text-primary');
        	target.forEach((target)=> target.addEventListener('click',function(e){
        		console.log(this);
            	let lchild = e.path[0].childNodes
            	let aptText = lchild[3].value;
            	console.log(aptText);
            	if(markers.length != 0) { 		
            		markers.forEach((mak)=>{
            			mak.setMap(null);
            		})
            		markers.length = 0;
            	}
            	if(infows.length != 0){
            		infows.forEach((i)=>{
            			i.close();
            		})
            		infows.length = 0;
            	}
            	var locPosition = new kakao.maps.LatLng(lchild[2].value, lchild[1].value),
                message = aptText
             	displayMarker(locPosition, message);
        	}));
          	});
        });
    </script>

    <!-- Footer Start -->
    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/parallax/parallax.min.js"></script>

    <!-- Template Javascript -->
    <script src="/js/main.js"></script>
</body>

</html>
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
            <h1 class="display-4 text-white animated slideInDown mb-4">Find Apartment</h1>
            <nav aria-label="breadcrumb animated slideInDown">
                <ol class="breadcrumb justify-content-center mb-0">
                    <div class="row col-md-12 justify-content-center mb-2">
                        <div class="form-group col-md-2">
                            <select class="form-select bg-secondary text-darks" id="sido">
                                <option value="all">도/광역시</option>
                                <option value="11">서울시</option>
                                <option value="41">경기도</option>
                                <option value="28">인천광역시</option>
                                <option value="26">부산광역시</option>
                                <option value="30">대전광역시</option>
                                <option value="27">대구광역시</option>
                                <option value="31">울산광역시</option>
                                <option value="36">세종시</option>
                                <option value="29">광주광역시</option>
                                <option value="42">강원도</option>
                                <option value="43">충청북도</option>
                                <option value="47">경상북도</option>
                                <option value="48">경상남도</option>
                                <option value="45">전라북도</option>
                                <option value="46">전라남도</option>
                                <option value="50">제주도</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <select class="form-select bg-secondary text-darks" id="gugun">
                                <option value="all">구/군</option>
                            </select>
                        </div>
                        <div class="form-group col-md-2">
                            <select class="form-select bg-secondary text-darks" id="dong">
                                <option value="all">동</option>
                                
                            	<c:forEach var="dong" items="${donglist}">
                            		<option value="${dong.dongcode}"> ${dong.dongname}</option>
                            	</c:forEach>
                            
                            </select>
                        </div>
                        <button type="button" id="list-btn" class="btn btn-outline-primary" style="width: 210px">
                            	아파트매매정보가져오기
                        </button>
                        &nbsp;&nbsp;&nbsp;
                        <c:if test="${sessionScope.userInfo.id ne null }">
                        <button type="button" id="btnAddBookmark" class="btn btn-outline-primary" style="width: 210px">
                            	관심 지역 등록
                        </button>
                        </c:if>
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
                    <div class="d-inline-block rounded-pill bg-secondary text-primary py-1 px-3 mb-3">거래 정보</div>
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
        // 시도가 바뀌면 구군정보 얻기.
        document.querySelector("#sido").addEventListener("change", function () {
        	
        	console.log("시도 변경");
        	
        	// 시/도 값이 변경시 구/군 초기화
        	document.querySelector('#gugun').innerHTML = "";
        	let initgu = document.createElement('option');
        	initgu.setAttribute('value','all');
        	initgu.innerText = '구/군';
            document.querySelector('#gugun').appendChild(initgu);
            
            // 시/도 값이 변경시 동 초기화
            document.querySelector('#dong').innerHTML = "";
        	let initdo = document.createElement('option');
        	initdo.setAttribute('value','all');
        	initdo.innerText = '동';
            document.querySelector('#dong').appendChild(initdo);
            
            if (this[this.selectedIndex].value) {
                let regcode = this[this.selectedIndex].value;
                //let temp = `${root}/apt?action=searchGugun&code=`;
                let temp = `${root}/apt/gugun/`;
                console.log(temp+regcode);
              
                fetch(temp+regcode)
              	.then((response) => response.json())
              	.then((data) =>{
              		
              		data.forEach(function (item){
              			//console.log(item.name);
              			let opt = document.createElement('option');

              			opt.setAttribute('value',item.code);
              			opt.innerText = item.name;
              			document.querySelector('#gugun').appendChild(opt);
              		});
              	});
                
            }
        });

        var now;

        // 구군이 바뀌면 동정보 얻기.
        document.querySelector("#gugun").addEventListener("change", function () {
        	// 구/군 값이 바뀌면 동 초기화
        	document.querySelector('#dong').innerHTML = "";
        	let initdo = document.createElement('option');
        	initdo.setAttribute('value','all');
        	initdo.innerText = '동';
            document.querySelector('#dong').appendChild(initdo);
            
            // 만약 구/군 값이 있다면
            if (this[this.selectedIndex].value) {
            	// 현재 구/군 까지의 코드 확인을 위한 콘솔 출력
            	console.log(this[this.selectedIndex].value);
            	
            	// regcode : 현재 (시/도) + (구/군) 까지의 코드 값
            	let regcode = this[this.selectedIndex].value;
            	
            	// temp : 비동기 uri보낼 문자열
               	//let temp = `${root}/apt?action=searchDong&code=`;
               	
               	let temp = `${root}/apt/dong/`;
                console.log(temp+regcode);
               	
               	// uri 비동기 fetch 사용하여 시작
               	fetch(temp+regcode)
              	.then((response) => response.json())       
              	.then((data) =>{
              		
              		//console.log(data);
              		
              		data.forEach(function (item){
              			//console.log(item);
              			let opt = document.createElement('option');

              			opt.setAttribute('value',item.code);
              			opt.innerText = item.name;
              			document.querySelector('#dong').appendChild(opt);
              		});
              		
              	});
            }
        });
        var markers = [];
        var infows = [];
        ///////////////////////// 아파트 매매 정보 /////////////////////////
        document.querySelector("#list-btn").addEventListener("click", function () {
        	// 최종적으로 동 까지 코드가 우리가 원하는 전체 code 이므로 dong의 코드를 저장하기.
        	let code = document.querySelector("#dong");
        	let dongname = code.options[code.selectedIndex].text;
        	code = code[code.selectedIndex].value;
        	
        	// 코드 확인을 위한 콘솔 출력
        	console.log(dongname);
        	
        	document.querySelector("#houseInfo").setAttribute("style", "visibility: ;");
            let tbody = document.querySelector("#aptlist");
            tbody.innerHTML = "";
            
        	//let uri = `${root}/apt?action=searchApt&code=`;
        	let uri = `${root}/apt/list/`;
        	fetch(uri+code)
          	.then((response) => response.json())
          	.then((data) =>{
          		
          		console.log(data);
          		
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
          		
          		console.log(cnt)
          		
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
		// 관심 지역 등록 버튼
		document.querySelector("#btnAddBookmark").addEventListener("click", function () {
			let code = document.querySelector("#dong");
        	let dongname = code.options[code.selectedIndex].text;
        	
        	let gugunname = document.querySelector("#gugun").options[code.selectedIndex];
        	
        	console.log(gugunname);
        	
        	let sidoname = document.querySelector("#sido").options[code.selectedIndex];
        	code = code[code.selectedIndex].value;
        	
        	console.log(code);
        	
			if(code!='all'){
				//alert('최종 코드 : ' + code);
				let id = `${sessionScope.userInfo.id}`;
				//alert('현재 아이디: '+ id);
				
				//let uri = `${root}/apt?action=addBookMark&id=`+id+`&code=`+code;
				
				let uri = `/apt/addBookMark/`+id+`/`+code;
				
				console.log(uri);
				
				//alert('요청 uri : ' + uri);
	        	fetch(uri)
	          	.then(alert(sidoname+' '+gugunname+' '+dongname+' 등록 완료'));
			}else{
				alert('시, 구/군, 동을 선택하세요');
			}
		});
		//}
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
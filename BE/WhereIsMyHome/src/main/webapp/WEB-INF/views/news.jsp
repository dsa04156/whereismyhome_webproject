<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | News</title>
    <%@ include file="/include/head.jsp" %>
</head>

<body>
    <%@ include file="/include/nav.jsp" %>

	<div class="container-fluid">
	<div class="row bg-dark" style="height: 130px">
    </div> 	
	</div>
<!-- Carousel Start -->
    <div class="container">
        <div class="row">
            <div style="padding-top: 50px;">
                <h1 class="text-center" style="font-family: 'Black Han Sans', sans-serif; font-weight: lighter;">오늘의 뉴스</h1>
                <hr>
            </div>
        </div>
        <div class="row">
            <div class="col-6" style="width: 500px;">
                <div class="d-inline-block rounded-pill bg-secondary text-primary py-1 px-3 mb-3" style="margin-left: 190px;">Hot News</div>
                <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"
                            aria-current="true" aria-label="Slide 1"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
                            aria-label="Slide 2"></button>
                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
                            aria-label="Slide 3"></button>
                    </div>
                    <div class="carousel-inner">
                        <div class="carousel-item active" data-bs-interval="5000">
                            <img src="img/team-1.jpg" class="d-block w-100">
                            <a href="https://land.naver.com/news/newsRead.naver?type=headline&bss_ymd=&prsco_id=417&arti_id=0000850347" target="_blank">
                                <div class="carousel-caption d-none d-md-block" style="padding-top: 250px;">
                                    <p>"LH 땅투기 없다"… 원희룡표 국토부 공공기관 혁신안 나왔다</p>
                                </div>
                            </a>
                        </div>
                        <div class="carousel-item" data-bs-interval="5000">
                            <img src="img/team-2.jpg" class="d-block w-100" alt="...">
                            <a href="https://land.naver.com/news/newsRead.naver?type=headline&bss_ymd=&prsco_id=417&arti_id=0000850361" target="_blank">
                                <div class="carousel-caption d-none d-md-block" style="padding-top: 250px;">
                                    <p>종부세 혜택 18만명, 오는 16~30일 특례 신청</p>
                                </div>
                            </a>
                        </div>
                        <div class="carousel-item">
                            <img src="img/team-3.jpg" class="d-block w-100" alt="...">
                            <a href="https://land.naver.com/news/newsRead.naver?type=headline&bss_ymd=&prsco_id=005&arti_id=0001551758" target="_blank">
                                <div class="carousel-caption d-none d-md-block" style="padding-top: 250px;">
                                    <p>중대형 아파트 입주 물량 역대 최저</p>
                                </div>
                            </a>
                        </div>
                    </div>
                    </div>
            </div>
            <div class="col-6" style="padding-left: 100px; padding-right: 100px; width: 800px;">
                <div class="d-inline-block rounded-pill bg-secondary text-primary py-1 px-3 mb-3 text-center" style="margin-left: 250px;">Other News</div>
                <div class="row">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th scope="col" class="text-center" style="width: 400px;">제목</th>
                                <th scope="col" class="text-center" style="width: 100px;">날짜</th>
                                <th scope="col" class="text-center" style="width: 100px;">발행처</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr onclick='window.open("https://land.naver.com/news/newsRead.naver?type=breaking&bss_ymd=20220908&prsco_id=025&arti_id=0003222736","_blank")'>
                                <td class="align-middle"><a href="">잠실은 4억 떨어졌다, 2030 영끌족 비명…결국 2년 전 집값</a></td>
                                <td class="align-middle text-center">2022.09.08</td>
                                <td class="align-middle text-center">중앙일보</td>
                            </tr>
                            <tr onclick='window.open("https://land.naver.com/news/newsRead.naver?type=breaking&bss_ymd=20220908&prsco_id=243&arti_id=0000030655","_blank")'>
                                <td class="align-middle"><a href="">지역별 잘 나가는 브랜드, 청약시장서 흥행…후속단지도 주목</a></td>
                                <td class="align-middle text-center">2022.09.08</td>
                                <td class="align-middle text-center">이코노<br>미스트</td>
                            </tr>
                            <tr onclick='window.open("https://land.naver.com/news/newsRead.naver?type=breaking&bss_ymd=20220908&prsco_id=032&arti_id=0003172155","_blank")'>
                                <td class="align-middle"><a href="">“내년 2월 ‘1기 신도시 특별법’ 발의”…정부, 마스터플랜 지연 불만 달래기</a></td>
                                <td class="align-middle text-center">2022.09.08</td>
                                <td class="align-middle text-center">경향신문</td>
                            </tr>
                            <tr onclick='window.open("https://land.naver.com/news/newsRead.naver?type=breaking&bss_ymd=20220908&prsco_id=032&arti_id=0003172140","_blank")'>
                                <td class="align-middle"><a href="">서울 아파트값 일주일 새 0.15% 하락…9년 만에 최대 폭</a></td>
                                <td class="align-middle text-center">2022.09.08</td>
                                <td class="align-middle text-center">경향신문</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Carousel End -->

    <!-- Footer Start -->
    <%@ include file="/include/footer.jsp" %>
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
    <script src="js/main.js"></script>
</body>

</html>
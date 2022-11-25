<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Edit Info</title>
    <%@ include file="/WEB-INF/views/include/head.jsp" %>
    <%@ include file="/WEB-INF/views/include/checkSession.jsp" %>
</head>

<body class="bg-dark">
    <%@ include file="/WEB-INF/views/include/nav.jsp" %>

    <div class="bg-dark" style="height: 50px;">

    </div>

    <!-- Carousel Start -->
    <div class="container-fluid pb-5 bg-dark" style="padding-top: 100px;">
        <div class="mask d-flex align-items-center h-100 gradient-custom-3">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                        <div class="card" style="border-radius: 15px;">
                            <div class="card-body p-5">
                                <form method="post" action="/member/editInfo">
                                <input type="hidden" name="act" value="editInfo">
                                <h2 class="text-uppercase text-center mb-5"><img src="https://cdn.pixabay.com/photo/2021/01/04/10/37/icon-5887113_960_720.png"
                                    style="width: 200px; height:200px"></img> </h2>
                                <hr>
                                <p class="text-uppercase text-center lead">My Info Edit</p>
                                <hr>
                                <div class="row">
                                    <div class="col-3">
                                        <p class="text-uppercase text-center lead" style="color: black;">ID </p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text" name="id" readonly="readonly" value="${sessionScope.userInfo.id}">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-3">
                                        <p class="text-uppercase text-center lead" style="color: black;">E-Mail </p>
                                    </div>
                                    <div class="col-9">
                                        <input type="email" name="email" placeholder="xxx@ssafy.com" value="${sessionScope.userInfo.email }">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-3">
                                        <p class="text-uppercase text-center lead" style="color: black;">Password </p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text" name="pw" placeholder="" value="${sessionScope.userInfo.pw }">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-3">
                                        <p class="text-uppercase text-center lead" style="color: black;">Comment </p>
                                    </div>
                                    <div class="col-9">
                                        <input type="text" name="comment" placeholder="" value="${sessionScope.userInfo.comment }">
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                	<div class="col"></div>
                                    <div class="col-3" >
                                        <button type="submit" class="button5 btn-lg" style="border: none; background: linear-gradient(to right, #6A82FB, #FC5C7D); color: white;">확인</button>
                                    </div>
                                    <div class="col-3" >
                                        <a type="button" class="button5 btn-lg align-content-center" style="border: none; background: linear-gradient(to right, #6A82FB, #FC5C7D); color: white;
                                        " href="/member/mypage">취소</a>                                                                        
                                    </div>
                                    <div class="col"></div>
                                </div>
								</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Carousel End -->
    
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Notice Modify</title>
    <%@ include file="/include/head.jsp" %>
    <%@ include file="/include/checkSession.jsp" %>
</head>

<body class="bg-dark">
    <%@ include file="/include/nav.jsp" %>

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

                                <!-- 공지사항 작성 폼 -->
                                <h2 class="text-uppercase text-center mb-5">공지사항 수정</h2>

                                <form id="form-register" method="POST" action="">
                                <input type="hidden" name="action" value="modify">
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="subject">제목</label>
                                        <input type="text" name="subject" id="subject" class="form-control form-control-lg" value="${notice.subject}"/>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="content">본문</label>
                                        <textarea name="content" class="form-control form-control-lg" id="content" cols="30" rows="10">${notice.content}</textarea>
                                    </div>

                                    <div class="d-flex justify-content-center">
                                        <button type="button" id="btn-register"
                                            class="btn btn-success btn-block btn-m gradient-custom-4 text-white">작성 완료</button>
                                    </div>
                                </form>
                                <!-- 공지사항 작성 폼 끝 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Carousel End -->

    <script>
        document.getElementById("btn-register").onclick = function(){
            if($('input[name="subject"').val().trim() == '' || document.getElementById("content").value.length == 0){
                alert("제목 혹은 본문에 공백 입력 불가! 다시 입력하세요.");
            }else{
                //alert("저장되었습니다.");
                //location.href = "${root}/notice?action=notice";
                let form = document.querySelector("#form-register");
                form.setAttribute("action", "${root}/notice");
                form.submit();
            }
        };
    </script>

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
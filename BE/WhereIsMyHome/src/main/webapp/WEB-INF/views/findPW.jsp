<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Find PW</title>
    <%@ include file="/include/head.jsp" %>
</head>

<body class="bg-dark">
	<%@ include file="/include/nav.jsp" %>

    <div class="bg-dark" style="height: 100px;">

    </div>

    <!-- Carousel Start -->
    <div class="container-fluid pt-5 pb-5 bg-dark">
        <div class="mask d-flex align-items-center h-100 gradient-custom-3">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                        <div class="card" style="border-radius: 15px;">
                            <div class="card-body p-5">
                                <h2 class="text-uppercase text-center mb-5">비밀번호 찾기</h2>

                                <form>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="form3Example1cg">ID</label>
                                        <input type="text" id="form3Example1cg" class="form-control form-control-lg" name="id"/>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="form3Example3cg">전자 메일(E-mail)</label>
                                        <input type="email" id="form3Example3cg" class="form-control form-control-lg" name="email"/>
                                    </div>

                                    <p style="color: lightgray;">*비밀번호는 전자 메일로 발송됩니다.</p>

                                    <div class="d-flex justify-content-center">
                                        <button type="button"
                                            class="btn btn-success btn-block btn-lg gradient-custom-4 text-white" id="sendEmail">확인</button>
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

    <script>
        document.getElementById("sendEmail").onclick = function(){

            if($('input[name="id"]').val().trim() != 'ssafy' || $('input[name="email"]').val().trim() != 'ssafy@ssafy.com'){
                alert("ID 혹은 전자메일을 다시 확인해주세요.");
            }else{
                alert("발송되었습니다. 메일함을 확인해주세요.");
                location.href = "index.html";
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
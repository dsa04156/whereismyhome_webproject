<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Sign Up For Admin</title>
    <%@ include file="/include/head.jsp" %>
</head>

<body class="bg-dark">
    <%@ include file="/include/nav.jsp" %>

    <div class="bg-dark" style="height: 50px;">

    </div>

    <!-- Carousel Start -->
    <div class="container-fluid pt-5 pb-5 bg-dark">
        <div class="mask d-flex align-items-center h-100 gradient-custom-3">
            <div class="container h-100">
                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                        <div class="card" style="border-radius: 15px;">
                            <div class="card-body p-5">
                                <h2 class="text-uppercase text-center mb-5">관리자 계정 추가</h2>

                                <form method="post" action="${root}/member" id="registerForm">
									<input type="hidden" name="act" value="regist">
									<input type="hidden" name="level" value="admin">
                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="id">ID</label>
                                        <input type="text" id="id" name="id" class="form-control form-control-lg" required/>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="email">전자 메일(E-mail)</label>
                                        <input type="email" id="email" name="email" class="form-control form-control-lg" required/>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label" for="pw">비밀 번호(Password)</label>
                                        <input type="password" id="pw" name="pw"
                                            class="form-control form-control-lg" required />
                                    </div>

                                    <div class="d-flex justify-content-center">
                                        <a type="button" id='adminjoinBTN'
                                            class="btn btn-success btn-block btn-lg gradient-custom-4 text-white">가입 하기</a>
                                    </div>

                                    <p class="text-center text-muted mt-5 mb-0">관리자 계정 만들기 취소 <a href="${root}/index.jsp"
                                            class="fw-bold text-body"><u>메인화면으로</u></a></p>

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
	document.querySelector("#adminjoinBTN").addEventListener("click", function () {
		let id = document.querySelector("#id");
		let pw = document.querySelector("#pw");
		let email = document.querySelector("#email");
		if(id.value.length < 3){
			alert("ID를 3글자 이상 설정 해야 합니다.");
			return;
		}
		if(pw.value.length < 3){
			alert("PW를 3글자 이상 설정 해야 합니다.");
			return;
		}
		if(!email.value.includes(".")){
			alert(".com or .net 형식을 넣으세요");
			return;
		}
		console.log("id.value : " + id.value);
		let uri = `${root}/member?act=checkId&id=`+id.value;
    	fetch(uri)
      	.then((response) => response.json())
      	.then((data) =>{
      		console.log(data.checkId);
      		if(data.checkId =="true"){
      			alert("이미 존재하는 ID 입니다.");
      			return;
      		}else{
      			alert("회원 가입 성공");
      			document.querySelector("#registerForm").submit();
      		}
      	});
	});
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
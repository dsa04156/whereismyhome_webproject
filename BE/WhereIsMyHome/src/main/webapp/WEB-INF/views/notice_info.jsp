<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Where Is My Home | Notice Info</title>
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
                                 <!-- 공지사항 -->
                                 <h2 class="text-uppercase text-center mb-3">${notice.articleNo}. ${notice.subject}</h2>
                                 <hr>

                                 <div class="col-12">
                                    <p class="lead ps-1" style="text-align:justify">${notice.content}</p>
                                </div>

                                <div style="float: right;">
                                    <button type="button" class="btn btn-primary" id="btn-list">확인</button>
                               		<c:if test="${userInfo.level eq 'admin' && userInfo.id eq notice.id}">
                                		<button type="button" id="btn-mv-modify" class="btn btn-outline-primary">수정</button>
                                    	<button type="button" class="btn btn-outline-primary" id="btn-delete">삭제</button>
                               		</c:if>
                                
                                </div>
                                 <!-- 공지사항 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <form id="form-param" method="get" action="">
      <input type="hidden" id="act" name="action" value="">
    </form>
    <form id="form-no-param" method="get" action="/notice">
      <input type="hidden" id="nact" name="action" value="">
      <input type="hidden" id="articleno" name="articleno" value="${article.articleNo}">
    </form>
    
    <script>
    
    window.onload = function () {
    	
    	console.log(articleno);
    	
		let uri = `/notice/` + articleno;
		
    };
    
      document.querySelector("#btn-list").addEventListener("click", function () {
    	  let form = document.querySelector("#form-param");
    	  document.querySelector("#act").value = "notice";
    	  form.setAttribute("action", "${root}/notice");
          form.submit();
      });
      
      document.querySelector("#btn-mv-modify").addEventListener("click", function () {
    	  let form = document.querySelector("#form-no-param");
    	  document.querySelector("#nact").value = "mvmodify";
    	  form.setAttribute("action", "${root}/notice");
          form.submit();
      });
      
      document.querySelector("#btn-delete").addEventListener("click", function () {
       	if(confirm("정말 삭제하시겠습니까?")) {
       	  let form = document.querySelector("#form-no-param");
       	  document.querySelector("#nact").value = "delete";
      	  form.setAttribute("action", "${root}/notice");
          form.submit();
       	}
      });
    </script>
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
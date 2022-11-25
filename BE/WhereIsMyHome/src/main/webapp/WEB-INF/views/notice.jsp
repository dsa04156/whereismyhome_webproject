<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<title>Where Is My Home | Notice</title>
	<%@ include file="/WEB-INF/views/include/head.jsp" %>
	<%@ include file="/WEB-INF/views/include/checkSession.jsp" %>
	<script>
</script>
</head>


<body>
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>

	<!-- Page Header Start -->
	<div class="container-fluid page-header mb-5 wow fadeIn"
		data-wow-delay="0.1s">
		<div class="container text-center">
			<h1 class="display-4 text-white animated slideInDown mb-4">Notice</h1>
		</div>
	</div>
	<!-- Page Header End -->

	<!-- 공지사항 목록 출력 -->
	<!-- Contact Start -->
	<div class="container-xxl py-5">
		<div class="container">

			<div class="row g-5">
				<div class="col-md-10"
					style="margin-left: auto; margin-right: auto;">
					<!-- <h4>[ 인기글 ]</h4> -->
					<!-- <table class="table table-striped table-hover"> -->
					<table table class="table table-hover">
						<thead class="table-light">
							<!-- <thead> -->
							<tr class="text-center">
								<th>no</th>
								<th>제목</th>
								<th>작성자</th>
								<th>날짜</th>
							</tr>
						</thead>
						<tbody id="notice_info">
<!-- 
							<c:forEach var="notice" items="${notices}">

								<tr>
									<td class="text-center">${notice.articleNo}</td>
									<td><a href="#" class="article-title link-dark"
										data-no="${notice.articleNo}" style="text-decoration: none">${notice.subject}
									</a></td>
									<td class="text-center">${notice.id}</td>
									<td class="text-center">${notice.regTime}</td>
								</tr>

							</c:forEach>
 -->
						</tbody>
					</table>

					<div style="float: right;">
						 <c:if test="${userInfo.level eq 'admin'}"> 
							<button type="button" class="btn btn-primary" id="btn-mv-register">작성</button>
						</c:if>
						
					</div>

					<div
						class="container-fluid row justify-content-center align-items-center">
						<!-- <div class="search-wrap"> -->
						<input style="width: 33%" type="text"
							class="form-control text-center" placeholder="검색어를 입력해주세요.">
						<button type="button" style="width: 6%" type="submit"
							class="btn btn-dark ">검색</button>
						<!-- </div> -->
					</div>

				</div>
			</div>
		</div>
	</div>
	<!-- </div> -->
 	<form id="form-no-param" method="get" action="/notice/list">
      <input type="hidden" id="act" name="action" value="info">
      <input type="hidden" id="articleno" name="articleno" value="">
    </form>
    
	<script>
	
	window.onload = function () {
		let uri = `/notice/list`;
		//console.log(uri);
		
		let tbody = document.querySelector("#notice_info");
		tbody.innerHTML = "";
		
			fetch(uri)
		  	.then((response) => response.json())
		  	.then((data) =>{
		  		
		  		
		  	//	<tr>
			//	<td class="text-center">${notice.articleNo}</td>
			//	<td><a href="#" class="article-title link-dark"
			//		data-no="${notice.articleNo}" style="text-decoration: none">${notice.subject}
			//	</a></td>
			//	<td class="text-center">${notice.id}</td>
			//	<td class="text-center">${notice.regTime}</td>
			//</tr>
		  		
		  		data.forEach(function (item){
		  			//console.log(item);
		  			let tr = document.createElement('tr');
		  			
		  			let noTd = document.createElement("td");
		  			let articleNo = document.createTextNode(item.articleNo);
		  			noTd.setAttribute("class", "text-center");
		  			noTd.appendChild(articleNo);
		  			
		  			let subjectTd = document.createElement("td");
		  			let subjectlink = document.createElement("a");
		  			let subject = document.createTextNode(item.subject);
		  			subjectlink.setAttribute("class", "article-title link-dark");
		  			subjectlink.setAttribute("data-no", item.articleNo);
		  			subjectlink.setAttribute("style", "text-decoration: none");
		  			subjectlink.appendChild(subject);
		  			subjectTd.appendChild(subjectlink);
		  			
		  			let idTd = document.createElement("td");
		  			let id = document.createTextNode(item.id);
		  			idTd.setAttribute("class", "text-center");
		  			idTd.appendChild(id);
		  			
		  			let regTimeTd = document.createElement("td");
		  			let regTime =  document.createTextNode(item.regTime);
		  			regTimeTd.setAttribute("class", "text-center");
		  			regTimeTd.appendChild(regTime);
		  			
		  			tr.appendChild(noTd);
		  			tr.appendChild(subjectTd);
		  			tr.appendChild(idTd);
		  			tr.appendChild(regTimeTd);

					tbody.appendChild(tr);
					//console.log(tr);
		  		});
		  	})
		  	.then((a)=>{
		  		let titles = document.querySelectorAll(".article-title");
		  		console.log(titles);
		  		
		  	    titles.forEach(function (title) {
		  	      title.addEventListener("click", function () {
		  	    	  	console.log("title");
		  	     	 	document.querySelector("#articleno").value = this.getAttribute("data-no");
		  	     	 	document.querySelector("#form-no-param").submit();
		  	     	 	
		  	     		//location.href = "/notice/info";
		  	     	 	location.href = "/notice/" + this.getAttribute("data-no");
		  	      });
		  	    });
		  	});
	};


	
//	let titles = document.querySelectorAll(".article-title");
//	console.log(titles);
//	
//    titles.forEach(function (title) {
//      title.addEventListener("click", function () {
//    	  	console.log("hi");
//     	 	document.querySelector("#articleno").value = this.getAttribute("data-no");
//     	 	document.querySelector("#form-no-param").submit();
//      });
//    });

    document.querySelector("#btn-mv-register").addEventListener("click", function () {
      location.href = "${root}/notice?action=mvwrite";
    });
    
    document.querySelector("#btn-search").addEventListener("click", function () {
  	  let form = document.querySelector("#form-search");
        form.setAttribute("action", "${root}/notice");
        form.submit();
    });
	</script>
	<!-- Contact End -->


	<!-- Footer Start -->
	<%@ include file="/WEB-INF/views/include/footer.jsp" %>
	<!-- Footer End -->


	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
		class="bi bi-arrow-up"></i></a>


	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="lib/wow/wow.min.js"></script>
	<script src="lib/easing/easing.min.js"></script>
	<script src="lib/waypoints/waypoints.min.js"></script>
	<script src="lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="lib/parallax/parallax.min.js"></script>

	<!-- Template Javascript -->
	<script src="/js/main.js"></script>
</body>

</html>
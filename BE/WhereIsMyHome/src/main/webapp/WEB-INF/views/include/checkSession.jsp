<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	<c:if test="${sessionScope.userInfo.id eq null }">
		console.log("세션 만료");
		alert("회원만 볼 수 있습니다.");
		location.href="/";
	</c:if>
</script>
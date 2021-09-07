<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container{
	margin-top: 80px;
	width: 800px;
	background-color: blue;
	color: white; 
}
</style>
</head>
<body>
<div class="container">
<h1>에러 발생 페이지입니다.</h1>
<p>내용을 다시 확인해주세요.</p>
<%--
	<h4><c:out value="${exception.getMessage() }"></c:out></h4>
	<ul>
		<c:forEach items="${exception.getStackTrace() }" var="stack">
			<li><c:out value="${stack }"></c:out></li>
		</c:forEach>
	</ul>
--%>
</div>
</body>
</html>
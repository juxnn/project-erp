<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ma:navbar />
<div class="container">
	<h1>매장 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>매장번호</th>
				<th>매장이름</th>
				<th>매장주소</th>
				<th>전화번호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="store" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${store.STORE_NO }</td>
				<td>${store.STORE_NAME }</td>
				<td>${store.STORE_ADDRESS }</td>
				<td>${store.STORE_PHONE }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>
</html>
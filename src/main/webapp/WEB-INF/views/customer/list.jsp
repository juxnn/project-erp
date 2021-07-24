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
	<h1>고객 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>고객번호</th>
				<th>고객이름</th>
				<th>전화번호</th>
				<th>고객주소</th>
				<th>상세정보</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="customer" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${customer.CUS_NO }</td>
				<td>${customer.CUS_NAME }</td>
				<td>${customer.CUS_PHONE }</td>
				<td>${customer.CUS_ADDRESS }</td>
				<td>${customer.CUS_DETAIL }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>
</html>
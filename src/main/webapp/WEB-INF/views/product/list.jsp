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
	<h1>상품 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>상품번호</th>
				<th>상품이름</th>
				<th>상품타입</th>
				<th>구입가격</th>
				<th>판매가격</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="product" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${product.PRODUCT_NO }</td>
				<td>${product.PRODUCT_NAME }</td>
				<td>${product.PRODUCT_TYPE }</td>
				<td>${product.PRODUCT_IN_PRICE }</td>
				<td>${product.PRODUCT_OUT_PRICE }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>
</html>
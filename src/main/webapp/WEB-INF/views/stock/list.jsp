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
	<h1>재고 목록</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>매장번호</th>
				<th>상품번호</th>
				<th>상품재고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="stock" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${storeList[stock.STORE_NO].STORE_NAME } (${stock.STORE_NO })</td>
				<td>${stock.PRODUCT_NO }</td>
				<td>${stock.STORE_STOCK_EA }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
</head>
<body>
<ma:navbar />
<div class="container">
	<h1>입고서 리스트</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>입고 번호</th>
				<th>상품</th>
				<th>EA</th>
				<th>담당자</th>
				<th>발주 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${inList }" var="in" varStatus="status">
			<tr class='order-list'>
				<td>${status.count }</td>
				<td class="order-no">${in.ORDER_NO }</td>
				<td>${in.PRODUCT_NO }</td>
				<td>${in.ORDER_EA }</td>
				<td>${in.EMP_CODE }</td>
				<td><fmt:formatDate value="${in.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
	
	
	<h1>미입고 리스트 조회</h1>
	<h3>발주 승인(1)된 애들</h3>
	체크하면 입고완료.
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>발주 번호</th>
				<th>상품</th>
				<th>EA</th>
				<th>처리 상태</th>
				<th>담당자</th>
								<th>발주 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orderList }" var="order" varStatus="status">
			<tr class='order-list'>
				<td>${status.count }</td>
				<td class="order-no">${order.ORDER_NO }</td>
				<td>${order.PRODUCT_NO }</td>
				<td>${order.ORDER_EA }</td>
				<td>${order.ORDER_STATUS }</td>
				<td>${order.EMP_CODE }</td>
				<td><fmt:formatDate value="${order.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
	
	
</div>
</body>
</html>
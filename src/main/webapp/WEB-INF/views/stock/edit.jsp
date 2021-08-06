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
<style>
html, body{
	height: 100%;
}
.box {
	display: flex;
	height: 100%;
}
.side-box-A {
	background-color: white;
	width: 220px;
	padding-top: 20px;
	border-right-color: #C0C0C0;
	border-right-style: solid;
	border-right-width: 1px;
	hight: 500px;
}
.side-box-name {
	background-color: #DCDCDC;
	height: 100px;
	padding: 30px;
	font-size: 25px;
	margin-top: -20px;
	text-align: center;
}

.side-box-content {
	height: 70px;
	font-size: 20px;
	padding: 15px;
	border-top-color: #C0C0C0;
	border-top-style: solid;
	border-top-width: 1px;
	text-align: center;
}
.container{
	margin-top: 50px;
}
.title-box {
	text-align: center;
	margin-bottom: 50px;
}
</style>
</head>
<body>
<ma:navbar />
<ma:navbar-b />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-b2 />
<div class="container">
	<h1>재고관리 페이지입니다.</h1>
	<h3>아래는 상품 데이터 리스트입니다.</h3>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>상품번호</th>
				<th>상품이름</th>
				<th>상품타입</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="product" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${product.PRODUCT_NO }</td>
				<td>${product.PRODUCT_NAME }</td>
				<td>${product.PRODUCT_TYPE }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</div>
</body>
</html>
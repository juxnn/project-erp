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
	height: 100%
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
<ma:side-box-b1 />
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
</div>
</body>
</html>
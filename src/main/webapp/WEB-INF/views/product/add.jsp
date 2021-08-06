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

.title-box {
	text-align: center;
	margin-bottom: 50px;
}
.container{
	margin-top: 80px;
}
.title-box {
	text-align: center;
	margin-bottom: 50px;
}
.input-group-text {
	width: 126px;
	align-content: center;
	justify-content: center;
}
.form-div{

	max-width: 400px;
	margin: auto;
}

</style>
</head>
<body>
<ma:navbar />
<ma:navbar1 />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box3 />
<div class="container">
	<div class="title-box">
		<h1>상품 등록</h1>
	</div>
	<div class="form-div">
	<form action="${appRoot }/product/add" method="post" enctype="multipart/form-data">
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상품 NO</span>
	</div>
	<input type="text" class="form-control" name="PRODUCT_NO" placeholder="상품 넘버를 입력하세요.">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상품 이름</span>
	</div>
	<input type="text" class="form-control" name="PRODUCT_NAME" placeholder="상품 이름을 입력하세요.">
</div>	
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상품 타입</span>
	</div>
	<input type="text" class="form-control" name="PRODUCT_TYPE" placeholder="상품 타입을 입력하세요.">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상품 타입</span>
	</div>
	<input type="number" class="form-control" name="PRODUCT_IN_PRICE" placeholder="구입가를 입력하세요.">
</div>			
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상품 타입</span>
	</div>
	<input type="number" class="form-control" name="PRODUCT_IN_PRICE" placeholder="판매가를 입력하세요.">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">디테일</span>
	</div>
	<input type="text" class="form-control" name="PRODUCT_DETAIL" placeholder="상세 정보를 입력하세요.">
</div>
<div class="custom-file mb-3">
  <input type="file" class="custom-file-input" name="file" accept="image/*">
  <label class="custom-file-label" for="validatedCustomFile"> 파일 이미지를 업로드하세요.</label>
</div>

<button id="submit-btn" type="submit" class="btn btn-primary">상품정보 생성</button>
		
	</form>
</div>	<!-- .form-div -->	
</div> <!-- container -->
</div> <!-- .box -->
</body>
</html>
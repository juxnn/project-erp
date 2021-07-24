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
	<h1>상품 등록</h1>
	<form action="${appRoot }/product/add" method="post">
		PRODUCT_NO: <input type="text" id="input1" name="PRODUCT_NO"><br>
		PRODUCT_NAME: <input type="text" id="input2" name="PRODUCT_NAME"><br>
		PRODUCT_TYPE: <input type="text" id="input3" name="PRODUCT_TYPE"><br>
		PRODUCT_IN_PRICE: <input type="text" id="input4" name="PRODUCT_IN_PRICE"><br>
		PRODUCT_OUT_PRICE: <input type="text" id="input5" name="PRODUCT_OUT_PRICE"><br>
		PRODUCT_DETAIL: <input type="text" id="input6" name="PRODUCT_DETAIL"><br>	
		
		
		<input type="submit" value="생성">
	</form>
</div>
</body>
</html>
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
	<h1>매장등록</h1>
	<form action="${appRoot }/store/add" method="post">
		STORE_NO: <input type="number" id="input1" name="STORE_NO"><br>
		STORE_NAME: <input type="text" id="input2" name="STORE_NAME"><br>
		STORE:ADDRESS: <input type="text" id="input2" name="STORE_ADDRESS"><br>
		STORE:PHONE: <input type="text" id="input2" name="STORE_PHONE">
		<input type="submit" value="생성">
	</form>
</div>
</body>
</html>
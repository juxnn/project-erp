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
<ma:navbar></ma:navbar>
<div class="container">
	<h1>고객 등록</h1>
	<form action="${appRoot }/customer/add" method="post">
		CUS_NO: <input type="text" id="input1" name="CUS_NO"><br>
		CUS_NAME: <input type="text" id="input2" name="CUS_NAME"><br>
		CUS_PHONE: <input type="text" id="input3" name="CUS_PHONE"><br>
		CUS_ADDRESS: <input type="text" id="input4" name="CUS_ADDRESS"><br>
		CUS_DETAIL: <input type="text" id="input5" name="CUS_DETAIL"><br>	
		<input type="submit" value="생성">
	</form>
</div>
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
<h1>비밀번호 재설정 페이지</h1>
	${employee.EMP_CODE }<br>
	${employee.EMP_NAME }<br>
	<form action="${appRoot }/employee/pw-change" method="post">
		사번 :<input type="number" name="EMP_CODE" value="${employee.EMP_CODE }" readonly="readonly">
		비밀번호 입력 : <input name="EMP_PASSWORD" type="password"><br>
		비밀번호 재입력 : <input name="passwordCheck" type="password"><br>
		<button type="submit">변경</button>
	</form>
</div>
</body>
</html>
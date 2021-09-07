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
.container {
	width: 500px;
	margin-top: 60px;
	margin-bottom: 100px;
}
.input-group-text {
	width: 126px;
	align-content: center;
	justify-content: center;
}
</style>
</head>
<body>
<ma:navbar-main />
<div class="container">

	<form action="${appRoot }/employee/pw-change" method="post">
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">이름</span>
			</div>
			<input type="text" class="form-control" name="EMP_NAME" value="${employee.EMP_NAME }" readonly="readonly">
		</div>	
		<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">사번</span>
				</div>
				<input type="text" class="form-control" name="EMP_CODE" value="${employee.EMP_CODE }" readonly="readonly">
		</div>
		<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">비밀번호</span>
				</div>
				<input type="password" class="form-control" name="EMP_PASSWORD" placeholder="새로운 비밀번호를 입력해주세요.">
		</div>
		<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">재입력</span>
				</div>
				<input type="password" class="form-control" name="passwordCheck" placeholder="비밀번호를 재입력 입력해주세요.">
		</div>
		<button type="submit" class="btn btn-primary">비밀번호 재설정</button>
	</form>
	
	

	
	
</div>
</body>
</html>
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
<div class="row justify-content-center">
		<div class="col-md-6 col-12">
			<h1>로그인</h1>
			<form action="${appRoot }/login" method="post">
				<div class="form-group">
					<label for="input1">사번</label>				
					<input id="input1" class="form-control" name="username" />
				</div>
				<div class="form-group">
					<label for="input2">패스워드</label>
					<input id="input2" type="password" 
					class="form-control" name="password" />
				</div>
				<input class="btn btn-primary" type="submit" value="로그인">
			</form>
			<br>
			
			<a href="${appRoot }/employee/findpw" 
				onclick="window.open(this.href, '_blank', 'width=600px,height=600px,toolbars=no,scrollbars=no'); return false;">
				비밀번호를 잊으셨나요?</a>

<!-- 			<from action="" method="post">
				<input class="btn btn-warning" type="submit" value="비밀번호 찾기">
			</from> -->
		</div>
	</div>	
</div>
</body>
</html>



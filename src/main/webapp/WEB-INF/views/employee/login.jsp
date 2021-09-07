<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<style>
#div1{
	margin-top: 100px;
}
#div2{
	margin-top: 50px;
}
</style>
<script type="text/javascript">
function test2(empCode){
	$("#empCode").val(empCode);
	$("#pw-reset-form").submit();
}

</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<ma:navbar-main />
<div class="container">
<div class="row justify-content-center" id="div1">
		<div class="col-md-6 col-12">
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

 		<form id="pw-reset-form" action="${appRoot }/employee/pw-reset" method="post">
			<input type="number" id="empCode" name="empCode" hidden="hidden"/>
			<input class="btn btn-warning" type="submit" value="비밀번호 찾기" hidden="hidden">
		</form>
		</div>
</div>
<!-- 예시용 계정 -->
<div class="row justify-content-center" id="div2" >
	<div>

		본사 관리부 부장 : 2000010193<br>
		명동 영업부 부장 : 2010050592<br>
		명동 영업부 대리 : 2006081990<br>
		창고 물류부 부장 : 2004061053<br>
		창고 물류부 사원 : 2007090697<br>
		<br>
		비밀번호: 123
	</div>
</div>
</div>
</body>
</html>



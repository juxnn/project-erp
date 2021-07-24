<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>

<script>
$(document).ready(function(){
	$("#send-email-btn").click(function(e){
		
		var email = $("#email").val();
		var empCode = $("#empCode").val();
		
		var codeMessageElem = $("#code-message");
		var emailMessageElem = $("#email-message");
		
		if(email == "" || empCode == ""){
			alert('입력해주세요.');
		}
		else{
			var data = {empCode: empCode, email: email};
			$.ajax({
				type: "post",
				url: "${appRoot}/employee/sendemail",
				data: data,
				success: function(data){
					if(data == "noCode"){
						//console.log("사원정보가 없습니다.");
						//codeMessageElem.text("사원정보가 없습니다.");
						alert('사원정보가 없습니다.');
					}else if(data=="noEmail"){
						//console.log("이메일 정보가 다릅니다.");
						//emailMessageElem.text("이메일 정보가 다릅니다.");
						alert('이메일 정보가 다릅니다.');
					}else if(data=="success"){
						$("#email-certi-input").removeAttr('hidden');
						$("#email-certi-check").removeAttr('hidden');
						$("#send-email-btn").attr('hidden', 'hidden');
					}
				},
					error: function(){
						console.log("실패");
					}
			})	
		}
		
	})
})
</script>

</head>
<body>
<div class="container">
	<h1>비밀번호 찾기</h1>
	
	<form id="form" action="${appRoot }/employee/newpw" method="post">
	
		<div class="form-group">
			<label for="empCode">사번</label>
			<input id="empCode" class="form-control" type="number" placeholder = "사번을 입력하세요.">
		</div>
		<small id="code-message" class="form-text"></small>
		<div class="form-group">
			<label for="email">이메일</label>
			<input id="email" class="form-control" type="email" placeholder = "이메일 주소를 입력하세요.">
		</div>
		<small id="email-message" class="form-text"></small>
		
		<button id="send-email-btn" class="btn btn-secondary" type="button">인증번호 전송</button><br>
		
		<input id="email-certi-input" class="form-control" type="text" name="checkAuth" placeholder = "인증번호를 입력하세요." hidden="hidden"><br>
		
		<input id="email-certi-check" class="btn btn-primary" type="button" value="인증번호 확인" hidden="hidden">
		
		<button type="submit" class="btn btn-success" hidden="hidden">비밀번호 재설정</button>
	</form>
	
</div>
</body>
</html>
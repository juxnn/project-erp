<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<%@ include file="/WEB-INF/subModules/script1.jsp"%>

<title>Insert title here</title>
</head>
<body>
<ma:navbar />
<div class="container">
	<c:if test="${not empty param.error }">
		<div id="alert1" class="alert alert-danger" role="alert">
			등록에 실패하였습니다.
		</div>
	</c:if>
	
<h1>직원 등록</h1>



	<form method="post" action="${appRoot }/employee/register">
		사번: <input type="text" class="form-control" id="signup-input1" name="EMP_CODE" >
		<button class="btn btn-outline-secondary" type="button" id="id-dup-btn">중복 체크</button>
		<small id="id-message" class="form-text"></small>
		비밀번호: <input type="password" class="form-control" id="register-input2" name="EMP_PASSWORD">
		비번확인: <input type="password" class="form-control" id="register-input3">
		<small id="password-message" class="form-text text-danger"></small>
		이름: <input type="text" class="form-control" id="register-input4" name="EMP_NAME">
		성별: <input type="text" class="form-control" id="register-input9" name="EMP_SEX">
		
		입사일: <input type="text" class="form-control" id="register-input12" name="EMP_DATE" autocomplete="off" readonly="readonly">
		<br>
		<select class="form-control" name="STORE_NO">
			<option value="">매장선택</option>
			<c:forEach items="${storeList }" var="store">
				<option value="${store.STORE_NO }">${store.STORE_NAME }</option>
			</c:forEach>
		</select>
		<select class="form-control" name="RANK_NO">
			<option value="">직급선택</option>
			<c:forEach items="${rankList }" var="rank">
				<option value="${rank.RANK_NO }">${rank.RANK_NAME }</option>
			</c:forEach>
		</select>
		<select class="form-control" name="DEPT_NO">
			<option value="">부서선택</option>
			<c:forEach items="${deptList }" var="department">
				<option value="${department.DEPT_NO }">${department.DEPT_NAME }</option>
			</c:forEach>
		</select>
		
		생년월일: <input type="text" class="form-control" id="register-input13" name="EMP_BIRTH" autocomplete="off" readonly="readonly">
		<br>
		
		전번: <input type="text" class="form-control" id="register-input8" name="EMP_PHONE">

		<input type="text" id="sample6_postcode" placeholder="우편번호">
		<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
		<input type="text" id="sample6_address" placeholder="주소" name="EMP_ADDRESS"><br>
		<input type="text" id="sample6_detailAddress" placeholder="상세주소" name="EMP_ADDRESS_SUB">
		<input type="text" id="sample6_extraAddress" placeholder="참고항목">
		<br>
		메일: <input type="text" class="form-control" id="register-input10" name="EMP_EMAIL">
		체크:<input type="text" class="form-control" id="register-input11" name="CHECK_RESIGNATION" value="1" readonly>
	
		<button type="submit" class="btn btn-primary" id="signup-btn1">회원 가입</button>
	</form>
</div>
</body>
</html>

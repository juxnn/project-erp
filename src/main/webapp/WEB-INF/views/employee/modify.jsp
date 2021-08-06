<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/script1.jsp"%>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
<style>
.box {
	display: flex;
}

.side-box1 {
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
#submit-btn {
	margin-left: 380px;
	align-content: center;
}

</style>
<script>
$(document).ready(function(){
	
	var sexValue = "<c:out value='${employee.EMP_SEX}'/>";	
	document.getElementById("sex-"+sexValue)
	.setAttribute('selected', 'selected');
	
	var storeValue = "<c:out value='${employee.STORE_NO}'/>";	
	document.getElementById("store-"+storeValue)
	.setAttribute('selected', 'selected');
	
	
	var rankValue = "<c:out value='${employee.RANK_NO}'/>";	
	document.getElementById("rank-"+rankValue)
	.setAttribute('selected', 'selected');
	
	var deptValue = "<c:out value='${employee.DEPT_NO}'/>";	
	document.getElementById("dept-"+deptValue)
	.setAttribute('selected', 'selected');
})
</script>
</head>
<body>
<ma:navbar />
<ma:navbar1 />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box1 />
<!-- ********************************* 입력 폼 ********************************* -->
<div class="container">
	
<div class="title-box">
	<h1>사원 정보 수정</h1>
</div>
	<form method="post" action="${appRoot }/employee/edit">

		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">사번</span>
			</div>
			<input type="text" class="form-control" name="EMP_CODE" value="${employee.EMP_CODE }" readonly>
		</div>
		
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">이름</span>
			</div>
			<input type="text" class="form-control" value="${employee.EMP_NAME }" readonly>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">성별</span>
			</div>
			<select class="form-control" id="exampleFormControlSelect1" name="EMP_SEX">
				<option value="" disabled selected hidden="hidden">성별을 선택하세요</option>
				<option id="sex-1" value="1">남성</option>
				<option id="sex-2" value="2">여성</option>
			</select>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">매장</span>
			</div>
			<select class="form-control" name="STORE_NO">
				<option value="" disabled selected hidden="hidden">매장을 선택하세요</option>
				<c:forEach items="${storeList }" var="store">
					<option id="store-${store.STORE_NO }" value="${store.STORE_NO }">${store.STORE_NAME }</option>
				</c:forEach>
			</select>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text" id="basic-addon1">직급</span>
			</div>
			<select class="form-control" name="RANK_NO">
				<option value="" disabled selected hidden="hidden">직급을 선택하세요</option>
				<c:forEach items="${rankList }" var="rank">
					<option id="rank-${rank.RANK_NO }" value="${rank.RANK_NO }">${rank.RANK_NAME }</option>
				</c:forEach>
			</select>
		</div>	
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">부서</span>
			</div>
			<select class="form-control" name="DEPT_NO">
				<option value="" disabled selected hidden="hidden">부서를 선택하세요</option>
				<c:forEach items="${deptList }" var="department">
					<option id="dept-${department.DEPT_NO }" value="${department.DEPT_NO }">${department.DEPT_NAME }</option>
				</c:forEach>
			</select>
		</div>	
		

		
		
		<div class="form-group">
			<div class="input-group date" id="datetimepicker2" data-target-input="nearest">
				<div class="input-group-prepend">
					<span class="input-group-text">생년월일</span>
				</div>
				<input type="text" id="EMP_BIRTH" name="EMP_BIRTH" class="form-control datetimepicker-input" data-target="#datetimepicker2" value="1980-01-01">
				<div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker">
					<div class="input-group-text" style="width:40px;">
						<i class="fa fa-calendar"></i>
					</div>
				</div>
			</div>
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">전화번호</span>
			</div>
			<input type="text" class="form-control" name="EMP_PHONE" value="${employee.EMP_PHONE }">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">이메일</span>
			</div>
			<input type="email" class="form-control" name="EMP_EMAIL" value="${employee.EMP_EMAIL }">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<input type="button"  class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
			</div>
			<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호">
			<input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">주소</span>
			</div>
			<input type="text" class="form-control" id="sample6_address" placeholder="주소" name="EMP_ADDRESS">
		</div>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="input-group-text">상세주소</span>
			</div>
			<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="EMP_ADDRESS_SUB">
		</div>
		<input type="number" name="CHECK_RESIGNATION" value="1" hidden>
		<button id="modify-btn1" type="submit" class="btn btn-primary">정보 수정</button>
	</form>
</div>
</div>
</body>
</html>

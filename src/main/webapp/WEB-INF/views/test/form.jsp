<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<!-- 달력 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<meta charset="UTF-8">
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
				<h1>사원등록</h1>
			</div>
			<div class="form-group">
				<div class="input-group date" id="datetimepicker1"
					data-target-input="nearest">
					<div class="input-group-prepend">
						<div class="input-group-text">입사 날짜</div>
					</div>
					<input type="text"
						class="form-control datetimepicker-input"
						data-target="#datetimepicker1" value="2010-01-01">
					<div class="input-group-append" data-target="#datetimepicker1"
						data-toggle="datetimepicker">
						<div class="input-group-text" style="width:40px;">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<button class="btn btn-secondary" type="button"
						id="button-addon1" style="width:126px;">사번생성</button>
				</div>
				<input type="text" class="form-control" placeholder=""
					aria-label="Example text with button addon"
					aria-describedby="button-addon1">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">비밀번호</span>
				</div>
				<input type="password" class="form-control"
					placeholder="비밀번호를 입력하세요." aria-label="Username"
					aria-describedby="basic-addon1">
			</div>

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">비밀번호 확인</span>
				</div>
				<input type="password" class="form-control"
					placeholder="비밀번호를 재입력하세요." aria-label="Username"
					aria-describedby="basic-addon1">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">이름</span>
				</div>
				<input type="text" class="form-control" placeholder="이름을 입력하세요.">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">성별</span>
				</div>
				<select class="form-control" id="exampleFormControlSelect1">
					<option>남성</option>
					<option>여성</option>
				</select>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">매장</span>
				</div>
				<select class="form-control" id="exampleFormControlSelect1">
					<option>매장1</option>
					<option>매장2</option>
				</select>
			</div>

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">부서</span>
				</div>
				<select class="form-control" id="exampleFormControlSelect1">
					<option>부서1</option>
					<option>부서2</option>
				</select>
			</div>

			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">직급</span>
				</div>
				<select class="form-control" id="exampleFormControlSelect1">
					<option>직급1</option>
					<option>직급2</option>
				</select>
			</div>





			<div class="form-group">
				<div class="input-group date" id="datetimepicker1"
					data-target-input="nearest">
					<div class="input-group-prepend">
						<span class="input-group-text">생년월일</span>
					</div>
					<input type="text" id="EMP_DATE"
						class="form-control datetimepicker-input"
						data-target="#datetimepicker1" value="2010-01-01">
					<div class="input-group-append" data-target="#datetimepicker1"
						data-toggle="datetimepicker">
						<div class="input-group-text" style="width:40px;">
							<i class="fa fa-calendar"></i>
						</div>
					</div>
				</div>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text">이메일</span>
				</div>
				<input type="email" class="form-control" id="inputEmail4" placeholder="이메일을 입력해주세요.">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<button class="btn btn-outline-secondary" type="button"
						id="button-addon1">우편번호 찾기</button>
				</div>
				<input type="text" class="form-control" id="inputAddress"
					placeholder="1234 Main St">
			</div>
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="inputAddress2"
					placeholder="">
			</div>
			<div class="input-group mb-3">
				<input type="text" class="form-control" id="inputAddress2"
					placeholder="상세 주소를 입력하세요.">
			</div>
			<button id="submit-btn" type="submit" class="btn btn-primary">사원등록</button>
		</div>
	</div>
</body>
</html>
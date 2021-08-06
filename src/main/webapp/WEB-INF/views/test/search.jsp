<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

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
	margin-top: 60px;
	margin-bottom: 100px;
}

.input-group-text{
	width: 60px;
	justify-content: center;
}
.btn-class{
	display: flex;
	justify-content: center;
}


</style>


</head>
<body>
	<ma:navbar />
	<ma:navbar1 />
	<div class="box">
		<ma:side-box1 />
		<div class="container" style="width: 800px;">
			<div class="title-box">
				<h1>사원조회</h1>
			</div>
			<!--  검색창 시작 -->
			<div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">매장</span>
					</div>
					<select class="form-control" id="exampleFormControlSelect1">
						<option>매장1</option>
						<option>매장2</option>
					</select>
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
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">이름</span>
					</div>
					<input type="password" class="form-control"
						placeholder="이름을 입력하세요." aria-label="Username"
						aria-describedby="basic-addon1">
				</div>

				<div class="form-group">
					<div class="input-group date" id="datetimepicker1"
						data-target-input="nearest">
						<div class="input-group-prepend" data-target="#datetimepicker1"
							data-toggle="datetimepicker">
							<div class="input-group-text">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
						<input type="text" id="EMP_DATE"
							class="form-control datetimepicker-input"
							data-target="#datetimepicker1" value="2010-01-01">
						<div class="input-group-prepend" data-target="#datetimepicker1"
							data-toggle="datetimepicker">
							<div class="input-group-text">
								<i class="fa fa-calendar"></i>
							</div>
						</div>
						<input type="text" id="EMP_DATE"
							class="form-control datetimepicker-input"
							data-target="#datetimepicker1" value="2010-01-01">
					</div>
				</div>
				<div class='btn-class'>
					<button id="submit-btn" type="submit" class="btn btn-secondary" style="width:100px">사원 조회</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
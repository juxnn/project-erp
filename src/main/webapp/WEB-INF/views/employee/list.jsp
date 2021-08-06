<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>



<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/employee-list-script.jsp"%>
<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>
<style>
html, body{
	height: 100%;
}
.box {
	display: flex;
	height: 100%
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
	margin-top: 60px;
	margin-bottom: 100px;
}
#search-div{
	max-width: 600px;
	margin: auto;
	
}
.btn-class{
	display: flex;
	justify-content: center;
}
#table-search{
	margin-top: 80px;
}

</style>

</head>
<body>
<ma:navbar />
<ma:navbar1 />

<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box1 />
<div class="container">
<!-- ********************************* 타이틀 ********************************* -->
<div class="title-box">
	<h1>사원조회</h1>
</div>
<!-- ********************************* 검색창 시작********************************* -->
<div id="search-div">
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">매장</span>
	</div>
	<select class="form-control" id="store-select">
		<option value="">전체 매장</option>
		<c:forEach items="${storeList}" var="store">
			<option value="${store.STORE_NO }">${store.STORE_NAME }</option>
		</c:forEach>
	</select>
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">부서</span>
	</div>
	<select class="form-control" id="dept-select">
		<option value="">전체 부서</option>
		<c:forEach items="${deptList}" var="dept">
			<option value="${dept.DEPT_NO }">${dept.DEPT_NAME }</option>
		</c:forEach>
	</select>
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">직급</span>
	</div>
	<select class="form-control" id="rank-select">
		<option value="">전체 직급</option>
		<c:forEach items="${rankList}" var="rank">
			<option id="" value="${rank.RANK_NO}">${rank.RANK_NAME }</option>
		</c:forEach>
	</select>
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">이름</span>
	</div>
	<input type="text" class="form-control" placeholder="이름을 입력하세요." id="name-select">
</div>
<!-- ********************************* 검색창 달력 ********************************* -->
<div class="row justify-content-between">
	<div class='col'>
		<div class="form-group">
			<div class="input-group date" id="datetimepicker1"
				data-target-input="nearest">
				<div class="input-group-prepend" data-target="#datetimepicker1"
					data-toggle="datetimepicker">
					<div class="input-group-text">
						<i class="fa fa-calendar"></i>
					</div>
				</div>
				<input type="text" id="min-date-select"
					class="form-control datetimepicker-input"
					data-target="#datetimepicker1" value="1900-01-01">
			</div>
		</div>
	</div>
	<div class='col'>
		<div class="form-group">
			<div class="input-group date" id="datetimepicker2"
				data-target-input="nearest">
				<div class="input-group-prepend" data-target="#datetimepicker2"
					data-toggle="datetimepicker">
					<div class="input-group-text">
						<i class="fa fa-calendar"></i>
					</div>
				</div>
				<input type="text" id="max-date-select"
					class="form-control datetimepicker-input"
					data-target="#datetimepicker2" value="2021-12-31">
			</div>
		</div>
	</div>
</div>
<div class='btn-class'>
	<button id="submit-btn" type="button" class="btn btn-secondary" onclick="searchEmployee()">사원 조회</button>
</div>
</div>
<!-- ********************************* 검색창 끝********************************* -->
<!-- ********************************* 검색 테이블 ********************************* -->
<table class="table table-hover" id="table-search">
	<thead>
		<tr>
			<th>#</th>
			<th>사번</th>
			<th>이름</th>
			<th>매장</th>
			<th>직급</th>
			<th>부서</th>
		</tr>
	</thead>
	<tbody id="employee-table-body">
	</tbody>
</table>
<!-- ********************************* 검색 테이블 끝 ********************************* -->
</div> <!-- .container -->
</div> <!--  .box -->
<!-- ********************************* 모달 시작 ********************************* -->
<div class="modal fade" id="employee-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">직원 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<table class="table table-bordered" id="table-detail">
		  <thead>
		  </thead>
		  <tbody>
		    <tr>
		      <td>사번</td>
		      <td id="modal-emp-code">Mark</td>
		    </tr>
		    <tr>
		      <td>이름</td>
		      <td id="modal-emp-name">Jacob</td>
		    </tr>
		    <tr>
		      <td>부서 / 지점 / 직급</td>
		      <td id="modal-emp-dept">Jacob</td>
		    </tr>
		    <tr>
		      <td>이메일</td>
		      <td id="modal-emp-email">Jacob</td>
		    </tr>
		    <tr>
		    <tr>
		      <td>연락처</td>
		      <td id="modal-emp-phone">Jacob</td>
		    </tr>
		    <tr>
		      <td>입사일</td>
		      <td id="modal-emp-date">Jacob</td>
		    </tr>
		    <tr>
		      <td>성별</td>
		      <td id="modal-emp-sex">Jacob</td>
		    </tr>
		    <tr>
		      <td>생년월일</td>
		      <td id="modal-emp-birth"></td>
		    </tr>
		    <tr>
		      <td>주소</td>
		      <td id="modal-emp-address">Jacob</td>
		    </tr>
		  </tbody>
		</table>
      </div>
      <div class="modal-footer">
      	<form action="${appRoot }/employee/modify" method="post">
      		<input id="modify-emp-code" type="number" name=empCode hidden>
	        <button type="submit" id="modify-btn" class="btn btn-warning">정보 수정</button>  	
      	</form>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- ********************************* 모달 끝 ********************************* -->
</body>
</html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>



<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>


<title>Insert title here</title>

<!-- 캘린더 -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>
/* 캘린더 위젯 적용 */

/* 설정 */
const config = {
		dateFormat: 'yy-mm-dd',
		showOn: "button",
		buttonText: "입사일선택",
	prevText: '이전 달',
	nextText: '다음 달',
	monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
	dayNames: ['일','월','화','수','목','금','토'],
	dayNamesShort: ['일','월','화','수','목','금','토'],
	dayNamesMin: ['일','월','화','수','목','금','토'],
	yearSuffix: '년',
changeMonth: true,
changeYear: true	
}

/* 캘린더 */
$(function() {
	$( "input[name='EMP_DATE']" ).datepicker(config);
});


function changeTypeSelect() { 
	var typeSelect = document.getElementById("type-select");
	
	var type = typeSelect.options[typeSelect.selectedIndex].value;
	console.log(type);
	
	return type;
}

function searchEmployee(){
	
	$('.removeTr').remove();
	var tableBody = $("#employee-table-body");

	var dept = $("#dept-select option:selected").val();
	var store = $("#store-select option:selected").val();
	var rank = $("#rank-select option:selected").val();
	var name = $("#name-select").val();
	var code = $("#code-select").val();
	var date = $("#date-select").val();
	
	console.log(dept);
	console.log(store);
	console.log(rank);
	console.log(name);
	console.log(code);
	console.log(date);
	
	
	
	var data = {DEPT_NO: dept,
				STORE_NO: store,
				RANK_NO: rank,
				EMP_NAME: name,
				EMP_CODE: code,
				EMP_DATE: date,
				CHECK_RESIGNATION: 1};
	
	var employeeList = "";
	
	var request = $.ajax({
		type: "post",
		url: "${appRoot}/employee/search",
		data: data,
		success: function(data){
			console.log("성공");
		},
		error:function(){
			console.log("실패");
		}
	});
			
	request.done(function(data){
		console.log(data);
		if(data.length>0){
			for(i=0; i<data.length; i++){	//검색값이 있을 경우
				employeeList += "<tr class='removeTr'>";
				employeeList += "<td>"+ (i+1) +"</td>";
				employeeList += "<td>" + data[i].emp_CODE + "</td>";
				employeeList += "<td>" + data[i].emp_NAME + "</td>";
				employeeList += "<td>" + data[i].store_NAME + "</td>";
				employeeList += "<td>" + data[i].rank_NAME + "</td>"
				employeeList += "<td>" + data[i].dept_NAME + "</td>";
				employeeList += "<td>" + data[i].emp_PHONE + "</td>";
				employeeList += "<td>" + data[i].emp_SEX + "</td>";
				employeeList += "<td>" + data[i].emp_EMAIL + "</td>";				
				employeeList += "</tr>";
			}
		}else{
			$('.removeTr').remove();	//검색값이 없을 경우
		}
		tableBody.append(employeeList);
	})
}
</script>

</head>
<body>
<ma:navbar />
<div class="container">

<h1>사원 조회</h1>

	부서/지점
	<select id="dept-select">
		<option value="">부서를 선택하세요</option>
		<c:forEach items="${deptList}" var="dept">
			<option value="${dept.DEPT_NO }">${dept.DEPT_NAME }</option>
		</c:forEach>	
	</select>
	<select id="store-select">
		<option value="">지점을 선택하세요</option>
		<c:forEach items="${storeList}" var="store">
			<option value="${store.STORE_NO }">${store.STORE_NAME }</option>
		</c:forEach>	
	</select>
	<br>
	직급/이름
	<select id="rank-select">
		<option value="">직급 선택하세요</option>
		<c:forEach items="${rankList}" var="rank">
			<option id="" value="${rank.RANK_NO}">${rank.RANK_NAME }</option>
		</c:forEach>	
	</select>
	<input id="name-select" type="text" placeholder="직원명을 입력해주세요."/>
	<br>
	사번/입사
	<input id="code-select" type="number" placeholder="사원번호를 입력해주세요." size="50"/>
	<input id="date-select" type="text" name="EMP_DATE" autocomplete="off" readonly="readonly" placeholder="년도-월-일">
	<br>
	<button type="button" id="search-btn" onclick="searchEmployee()">검색</button>
	<hr>
	<br>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>사번</th>
				<th>이름</th>
				<th>매장</th>
				<th>직급</th>
				<th>부서</th>
				<th>번호</th>
				<th>성별</th>
				<th>이메일</th>
			</tr>
		</thead>
		<tbody id="employee-table-body">
		</tbody>
	</table>
</div>
</body>
</html>
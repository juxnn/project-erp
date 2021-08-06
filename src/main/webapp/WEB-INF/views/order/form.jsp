<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

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
.side-box-A {
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
.container{
	margin-top: 50px;
}
.title-box {
	text-align: center;
	margin-bottom: 50px;
}

</style>

<script>
$(document).ready(function(){
	
	$("#today-date").text(getToday())
	
	$("#product-add-btn").click(function(){
		var html ="";
		
		html += "<tr>";
		html += "<td>";
		html += "<select id='product-type-select' onchange='changeTypeSelect(this)'>";
		html += "<option value=''>상품 TYPE</option>";
		html += "<c:forEach items='${productTypeList }' var='type'>";
		html += "<option id='${type.PRODUCT_TYPE }' value='${type.PRODUCT_TYPE }'>${type.PRODUCT_TYPE }</option>";
		html += "</c:forEach>";
		html += "</select>";
		html += "</td>";
		html += "<td>";
		html += "<select class='product-product-select' name='products'>";
		html += "<option value=''>타입을 먼저 선택하세요.</option>"
		html += "</select>";
		html += "</td>";
		html += "<td><input type='number' name='ORDER_EA'></td>";
		html += "</tr>";

		$("#product-table-body").append(html);
	})
})


function changeTypeSelect(elem) {

	var selectTo = $(elem).closest("tr").find(".product-product-select");

	var type = $(elem).val();
	var pno = "";
	var pname ="";
	
	var data = {PRODUCT_TYPE: type,
				PRODUCT_NO: pno,
				PRODUCT_NAME: pname}
	
	var selectOption= ""
	
	var request = $.ajax({
		type: "post",
		url: "${appRoot}/order/search-product",
		data: data,
		success: function(data){
				console.log("성공");
		},
		error:function(){
			console.log("실패");
		}
	});
	

	selectTo.empty();
	
	request.done(function(data){
		console.log(data);
		//검색값이 있을 경우
		if(data.length>0){
			selectOption += "<option class='removeOption' value=''>상품을 선택하세요</option>";
			for(i=0; i<data.length; i++){
				selectOption += "<option class='removeOption' value='" + data[i].product_NO + "'>";
				selectOption += "";
				selectOption += data[i].product_NO;
				selectOption += "(";
				selectOption += data[i].product_NAME;
				selectOption += ")";
				selectOption += "</option>";
				selectOption += "";
			}
			
		//검색값이 없을 경우
		}else{
			$('.removeOption').remove();
			selectOption += "<option class='removeOption' value=''>타입을 먼저 선택하세요.</option>";
		}
		//셀렉 옵션 정해주기.
		selectTo.append(selectOption);
	})
}
function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	
	return year + "-" + month + "-" + day;
}

</script>

</head>
<body>
<ma:navbar />
<ma:navbar-c />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-c2 />

<div class="container">
<!-- ********************************* 타이틀 ********************************* -->
	<div class="title-box">
		<h1>외부 발주서 작성 폼</h1>
	</div>
	<form method="post" action="${appRoot }/order/add">
		<table class="table table-striped">
			<thead>
			</thead>
			<tbody id="product-table-body">
				<tr>
					<td>사원코드: ${pinfo.employee.EMP_CODE }
						<input type="number" name='EMP_CODE' readonly="readonly" value="${employee.EMP_CODE }" hidden>
					</td>
					<td>발주자: ${pinfo.employee.EMP_NAME }</td>
					<td id="today-date"></td>
				</tr>
				<tr>
					<th>타입</th>
					<th>상품명</th>
					<th>수량</th>
				</tr>
				<tr>
					<td>
						<select id="product-type-select" onchange="changeTypeSelect(this)">
							<option value="">상품 TYPE</option>
							<c:forEach items="${productTypeList }" var="type">
								<option id="${type.PRODUCT_TYPE }" value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
							</c:forEach>	
						</select>
					</td>
					<td>
						<select class="product-product-select" name='products'>
							<option value="">타입을 먼저 선택하세요</option>
						</select>	
					</td>
					<td><input type='number' name='ORDER_EA'> </td>
				</tr>
			</tbody>
		</table>
		<button id="product-add-btn" type="button">상품 추가</button>
		<button type="submit">제출</button>
	</form>	
</div>
</div>    




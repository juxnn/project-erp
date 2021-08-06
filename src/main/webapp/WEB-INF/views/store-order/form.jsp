<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>

<script>
$(document).ready(function(){
	$("#product-add-btn").click(function(){
		var html ="";
		
		html += "<tr class='d-flex'>";
		html += "<td class='col-3'>";
		html += "<select id='product-type-select' onchange='changeTypeSelect(this)'>";
		html += "<option value=''>상품 TYPE</option>";
		html += "<c:forEach items='${productTypeList }' var='type'>";
		html += "<option id='${type.PRODUCT_TYPE }' value='${type.PRODUCT_TYPE }'>${type.PRODUCT_TYPE }</option>";
		html += "</c:forEach>";
		html += "</select>";
		html += "</td>";
		html += "<td class='col-7'>";
		html += "<select class='product-product-select' name='products' style='width:100%'>";
		html += "<option value=''>타입을 먼저 선택하세요.</option>"
		html += "</select>";
		html += "</td>";
		html += "<td class='col-2'><input type='number' name='ORDER_EA'"
		+ "onchange='this.value = Math.floor(Math.max(this.value,1))' style='width:50px'></td>";
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
</script>

<style>
html, body{
	height: 100%;
}
.box {
	display: flex;
	height: 100%;
}
.side-box-A {
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
.container{
	margin-top: 50px;
	max-width: 800px;
}
.title-box {
	text-align: center;
	margin-bottom: 50px;
}
.basic-info{
	max-width: 400px;
	margin: auto;
}
.input-group-text {
	width: 126px;
	align-content: center;
	justify-content: center;
}

</style>

</head>
<body>
<ma:navbar />
<ma:navbar-b />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-b1 />
<div class="container">
	<div class="title-box">
		<h1>발주서 작성(매장->창고 요청)</h1>
	</div>
	
	<div class="basic-info">
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text">작성자</span>
		</div>
		<input type="text" class="form-control" value="${employee.EMP_NAME }" readonly="readonly" style = "text-align:center;">
	</div>
	<div class="input-group mb-3">
		<div class="input-group-prepend">
			<span class="input-group-text">발주매장</span>
		</div>
		<input type="text" class="form-control" value="${employee.STORE_NAME }" readonly="readonly" style = "text-align:center;">
	</div>	
	</div>
<!-- ********************************* 상품 테이블 박스 form ********************************* -->
<form method="post" action="${appRoot }/store-order/order">
	<table class="table table-striped">
		<thead>
		</thead>
		<tbody id="product-table-body">
			<tr class="d-flex">
				<th class="col-3">타입</th>
				<th class="col-7">상품명</th>
				<th class="col-2">수량</th>
			</tr>
			<tr class="d-flex">
				<td class="col-3">
					<select id="product-type-select" onchange="changeTypeSelect(this)">
						<option value="">상품 TYPE</option>
						<c:forEach items="${productTypeList }" var="type">
							<option id="${type.PRODUCT_TYPE }"
								value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
						</c:forEach>
					</select>
				</td>
				<td class="col-7">
					<select class="product-product-select" name='products' style='width:100%'>
						<option value="">타입을 먼저 선택하세요</option>
					</select>
				</td>
				<td class="col-2">
					<input type='number' name='ORDER_EA' onchange='this.value = Math.floor(Math.max(this.value,1))' style="width:50px">
				</td>
			</tr>
		</tbody>
	</table>
	<button id="product-add-btn" type="button">상품 추가하기</button>
	<input type="number" value="${employee.STORE_NO }" hidden>
	<input type="number" name="EMP_CODE" value="${employee.EMP_CODE }" hidden>
	<button type="submit">제출</button>
</form>
		</div>    

</div><!-- .box -->
</body>
</html>


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
		html += "<td><input type='number' name='inEA'></td>";
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

		if(data.length>0){	//검색값이 있을 경우
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
		}else{	//검색값이 없을 경우					
			$('.removeOption').remove();
			selectOption += "<option class='removeOption' value=''>타입을 먼저 선택하세요.</option>";
		}
		//셀렉 옵션 정해주기.
		selectTo.append(selectOption);
	})
}
</script>
</head>
<body>
<ma:navbar />
<div class="container">
<h1>입고서 작성 폼</h1>
	<form method="post" action="${appRoot}/stock/in-submit">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>사원번호</th>
					<th>사원이름</th>
					<th>정보</th>
				</tr>
			</thead>
			<tbody id="product-table-body">
				<tr>
					<td><input type="number" name='EMP_CODE' readonly="readonly" value="${employee.EMP_CODE }"></td>
					<td>${employee.EMP_NAME }</td>
					<td>정보1</td>
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
					<td><input type='number' name='inEA'> </td>
				</tr>
			</tbody>
		</table>
		<button id="product-add-btn" type="button">상품 추가</button>
		<input type="number" name="STORE_NO" value="${employee.STORE_NO }">
		<button type="submit">제출</button>
	</form>	
	
	
	
	
	
</div>
</body>
</html>
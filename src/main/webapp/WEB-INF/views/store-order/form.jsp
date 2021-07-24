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


</script>

</head>
<body>
<ma:navbar />
<div class="container">
	<h1>발주서 작성(매장->창고 요청)</h1>
	<form method="post" action="${appRoot }/store-order/order">
		<!-- 테이블로 작성 -->
		<table class="table table-striped">
			<thead>
			</thead>
			<tbody id="product-table-body">
				<tr>
					<td>로그인유저:<input type="number" value="2001" name='EMP_CODE' readonly="readonly"></td>
					<td>로그인유저: ${employee.EMP_NAME }</td>
					<td>발주넘버: 자동생성</td>
				</tr>
				<tr>
					<td>매장넘버<input type="text" name="STORE_NO" value="${employee.STORE_NO }"></td>
					<td>매장 이름(로그인한 담당자 매장 번호)</td>
					<td>매장 정보</td>
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
		<button id="product-add-btn" type="button">상품 추가하기</button>
		<button type="submit">제출</button>
	</form>
</div>    





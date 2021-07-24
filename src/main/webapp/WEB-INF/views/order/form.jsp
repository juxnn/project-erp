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
	<h1>재고 발주서 작성 폼</h1>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#product-search-modal">모달버튼</button>
	
	<form method="post" action="${appRoot }/order/add">
		<!-- 테이블로 작성 -->
		<table class="table table-striped">
			<thead>
			</thead>
			<tbody id="product-table-body">
				<tr>
					<td><input type="number" name='EMP_CODE' readonly="readonly" value="${employee.EMP_CODE }"></td>
					<td>사원이름: ${employee.EMP_NAME }</td>
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
					<td><input type='number' name='ORDER_EA'> </td>
				</tr>
			</tbody>
		</table>
		<button id="product-add-btn" type="button">상품 추가</button>
		<button type="submit">제출</button>
	</form>	
	<!-- 모달 다시 도전! -->
	
<div class="modal fade" id="product-search-modal" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상품 조회</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      상품타입:
		<select id="type-select" onchange="changeTypeSelect()" class="form-control" name="PRODUCT_TYPE">
		<option value="">상품타입 선택</option>
		<c:forEach items="${productTypeList }" var="type" varStatus="status">
		<option id="${type.PRODUCT_TYPE }" value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
		</c:forEach>
		</select>
		상품번호:
		<input id="pno" class="form-control mr-sm-2" type="search" placeholder="상품번호" aria-label="Search"><br>
		상품이름:
		<input id="pname" class="form-control mr-sm-2" type="search" placeholder="상품이름" aria-label="Search"><br>
		<button id="product-search-btn"class="btn btn-outline-success my-2 my-sm-0" type="button">조회</button>
      
		<div class="form-group">
			<br>
			<h3>상품 List</h3>
			<form action="" method="post">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>#</th>
						<th><input type="checkbox" name="product" value="selectall" onclick="selectAll(this)"></th>
						<th>상품타입</th>
						<th>상품번호</th>
						<th>상품이름</th>
						<th width='10%' style="word-break:break-all">갯수</th>
					</tr>
				</thead>
				<tbody id="search-modal-body">
				</tbody>
			</table>
			</form>
			<button id="products-select-btn" type="button" class="btn btn-primary">상품선택</button>
		</div>
        <p>Modal body text goes here.</p>
      </div>
    
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">상품추가</button>
      </div>
    </div>
  </div>
</div>

	
	
</div>    
<%-- 상품검색 모달 --%>

<script>
$(document).ready(function(){
	//모달에서 검색버튼 실행
	$("#product-search-btn").click(function(e){
		
		$('.removeTr').remove();
		
		var type = changeTypeSelect();
		var pno = $("#pno").val();
		var pname = $("#pname").val();
		
		var data = {PRODUCT_TYPE: type, 
					PRODUCT_NO: pno,
					PRODUCT_NAME: pname}
		
		var html = "";
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
		
		request.done(function(data){
			
			console.log(data);
			//검색값이 있을 경우
			if(data.length > 0){
				for(i=0; i<data.length; i++){
					var x = i + 1
					html += "<tr class='removeTr'>"
					html += "<td>" + x + "</td>";
					html += "<td><input type='checkbox' name='product'></td>";
					html += "<td>" + data[i].product_TYPE + "</td>";
					html += "<td>" + data[i].product_NO + "</td>";
					html += "<td>" + data[i].product_NAME + "</td>";
					html += "<td><input type='number'></td>"
					html += "</tr>"
				}
			//검색값이 없을 경우
			}else{
				$('.removeTr').remove();
			}
			//테이블 그려주기
			$("#search-modal-body").append(html);
			
			
		})
		
		
	})	
})

//체크박스 전체 선택 함수
function selectAll(selectAll)  {
	const checkboxes 
	     = document.getElementsByName('product');
	
	checkboxes.forEach((checkbox) => {
	  checkbox.checked = selectAll.checked;
	})
}


//상품 타입 선택시 value 값 정해주기.
/* function changeTypeSelect(){
	var typeSelect = document.getElementById("product-type-select");
	
	var typeId = typeSelect.options[typeSelect.selectedIndex].value;
	console.log(typeId);
	
	return typeId;
	
} */
</script>





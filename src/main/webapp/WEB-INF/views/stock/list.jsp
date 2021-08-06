<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
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

function searchStock(){
	$('.stockTr').remove();
	
	var store =$("#store-select option:selected").val();
	var ptype =$("#type-select option:selected").val();
	var pname =$("#product-select").val();
	
	var stockList = "";

	var data = {
			STORE_NO: store,
			PRODUCT_TYPE: ptype,
			PRODUCT_NAME: pname
	}
	
	console.log(data);
	
	var request = $.ajax({
		type: "post",
		url: "${appRoot}/stock/search",
		data: data,
		success:function(data){
			console.log("성공");
		},
		error:function(){
			console.log("실패");
		}
	});
	
	request.done(function(data){
	
		if(data.length>0){
			for(i=0; i<data.length; i++){
				
				stockList += "<tr class='stockTr' style='cursor:pointer;'>";
				stockList += "<td>" +(i+1) + "</td>";
				stockList += "<td>" + data[i].store_NAME + "</td>";
				stockList += "<td>" + data[i].product_NAME + "</td>";
				stockList += "<td>" + data[i].store_STOCK_EA + "</td>";
				stockList += "</tr>";
			}
			
		}else{
			$('.stockTr').remove();
		}
		$("#stock-table-body").append(stockList);
		
		
	})

}

</script>

</head>
<body>
<ma:navbar />
<ma:navbar-b />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-b2 />
<div class="container">
<!-- ********************************* 타이틀 ********************************* -->
<div class="title-box">
	<h1>재고 목록</h1>
</div>



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
		<span class="input-group-text" id="basic-addon1">상품타입</span>
	</div>
	<select class="form-control" id="type-select">
		<option value="">전체 타입</option>
		<c:forEach items="${productTypeList }" var="type">
			<option id="${type.PRODUCT_TYPE }" value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
		</c:forEach>
	</select>	
	<div class="input-group-prepend">
		<span class="input-group-text" id="basic-addon1">상품명</span>
	</div>
	<input type="text" class="form-control" placeholder="상품명을 입력하세요." id="product-select">
</div>
<div class='btn-class'>
	<button id="search-stock-btn" type="button" class="btn btn-secondary" onclick="searchStock()">재고 검색</button>
</div>
</div>		
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>매장</th>
				<th>상품</th>
				<th>재고</th>
			</tr>
		</thead>
		<tbody id="stock-table-body">
<%-- 			<c:forEach items="${list }" var="stock" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${storeList[stock.STORE_NO].STORE_NAME } (${stock.STORE_NO })</td>
				<td>${stock.PRODUCT_NO }</td>
				<td>${stock.STORE_STOCK_EA }</td>
			</tr>
			</c:forEach>	 --%>
		</tbody>
	</table>
</div>
</div>
</body>
</html>
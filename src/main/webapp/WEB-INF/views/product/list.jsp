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



<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script>
$(document).ready(function(){
	
	var productProfit = 0;
	var averageProfit = 0;
	
// ********************** table 클릭시 동작 **********************
	$("#product-table-body").on("click", ".productTr", function(){
		
		$("#modal-product-img").empty();
		
		var productNo = $(this).find(".productNo").val();
		console.log(productNo)
		var data = {productNo: productNo}
		
		var request = $.ajax({
			type: "post",
			url: "${appRoot}/product/detail",
			data: data,
			success: function(data){
				console.log("성공");
				console.log(data);
			},
			error: function(){
				console.log("실패");
			}
		})
		
		request.done(function(data){
			console.log("done", data);
			$("#modal-product-no").text(data.product_NO);	
			$("#modal-product-name").text(data.product_NAME);
			$("#modal-product-type").text(data.product_TYPE);
			$("#modal-product-in-price").text(data.product_IN_PRICE);
			$("#modal-product-out-price").text(data.product_OUT_PRICE);
			$("#modal-product-detail").text(data.product_DETAIL);
			
			productProfit = data.product_PROFIT;
			averageProfit = data.average_PROFIT;
			
			var html = "";
			
			if(data.file_NAME){
				html += "<div>";
				html += "<img class='img-fluid' src='"
				html += '${imgRoot}' + data.product_NO;
				html += "/";
				html += data.file_NAME;
				html += "'>";
				html += "</div>"
			}
			
			$("#modal-product-img").append(html);


			new Chart(document.getElementById("bar-chart"), {
			    type: 'bar',
			    data: {
			      labels: ["평균 수익률", "상품 수익률"],
			      datasets: [
			        {
			          label: "수익률(%)",
			          backgroundColor: ["#3e95cd", "#3cba9f"],
			          data: [averageProfit, productProfit, 0]
					}
			      ]
			    },
			    options: {
			      legend: { display: false },
			      title: {
			        display: true,
			        text: '컴노스 상품별 수익률 계산 그래프'
			      }
			    }
			});
			
			
			$('#product-detail-modal').modal('show');
		})
	})
	

})



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

</head>
<body>
<ma:navbar />
<ma:navbar1 />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box3 />
<div class="container">
	<div class="title-box">
		<h1>상품 목록</h1>
	</div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>상품타입</th>
				<th>상품번호</th>
				<th>상품이름</th>
			</tr>
		</thead>
		<tbody id="product-table-body">
			<c:forEach items="${list }" var="product" varStatus="status">
			<tr class='productTr' style="cursor:pointer;">
				<td>${status.count }</td>
				<td>${product.PRODUCT_TYPE }</td>
				<td>${product.PRODUCT_NO }<input class="productNo" type="text" value="${product.PRODUCT_NO }" hidden="hidden"></td>
				<td>${product.PRODUCT_NAME }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>


<!-- 모달 -->
<div class="modal fade" id="product-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">상품 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div id="modal-product-img"></div>
		<table class="table table-bordered" id="table-detail">
		  <thead>
		  </thead>
		  <tbody>
		  	<tr>
		      <td>상품넘버</td>
		      <td id="modal-product-no"></td>
		    </tr>
		    <tr>
		      <td>상품명</td>
		      <td id="modal-product-name"></td>
		    </tr>
		   	<tr>
		      <td>상품타입</td>
		      <td id="modal-product-type"></td>
		    </tr>
		    <tr>
		      <td>상세정보</td>
		    <td id="modal-product-detail"></td>
		    </tr>
		    <tr>
		      <td>원가</td>
		      <td id="modal-product-in-price"></td>
		    </tr>
		    <tr>
		      <td>판매가</td>
		      <td id="modal-product-out-price"></td>
		    </tr>
		    <tr>
		      <td colspan="2">
		   
				<canvas id="bar-chart" width="200" height="30"></canvas>
		      
		      </td>
		    </tr>
		  </tbody>
		</table>
      </div>
      <!-- 지도 -->
	  <div id="map" hidden="hidden"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning">정보 수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</div><!-- .box -->


</body>
</html>
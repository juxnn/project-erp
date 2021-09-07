<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
$(function(){
	$("#in-list-table-body").on("click", ".in-list", function(){
		
		$('.removeTr').remove();
		
		var ono = $(this).find(".order-no").text();		
		var data = {ono: ono}
		
		var html = "";
		
		var request = $.ajax({
		
			type: "post",
			url: "${appRoot}/stock/in-list-detail",
			data: data,
			success: function(data){
				console.log("성공");
			},
			error: function(){
				console.log("실패");
			}
			
		})
		
		request.done(function(data){
			//javascript date format
			var order_date = new Date(data[0].order_DATE);
			
			String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
			String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
			Number.prototype.zf = function (len) { return this.toString().zf(len); };
			
			const formatDate = (date)=>{
				let formatted_date = date.getFullYear() + "-" + (date.getMonth() + 1).zf(2) + "-" + date.getDate().zf(2);
			 	return formatted_date;
			}
			
			$("#order-detail-date").text(formatDate(order_date));
			$("#order-detail-no").text(data[0].order_NO);
			$("#order-detail-store").text(data[0].store_NAME);
			$("#order-detail-emp").text(data[0].emp_NAME);

			for(i=0; i<data.length; i++){
				
				html += "<tr class='removeTr'>";
				html += "<td>" + (i+1) + "</td>";
				html += "<td>" + data[i].product_TYPE + "</td>";
				html += "<td>" + data[i].product_NO + "</td>";
				html += "<td>" + data[i].product_NAME+ "</td>";
				html += "<td>" + data[i].order_EA + "</td>";
				html += "</tr>"
				
			}
			
			$("#order-detail-product-list").append(html);
			
		})
		
		$("#order-detail-modal").modal('show');
	})
	
	
})



</script>
</head>
<body>
<sec:authorize access="hasRole('ROLE_MASTER')">
	<ma:navbar1 />
</sec:authorize>
<ma:navbar-b />
<sec:authorize access="hasRole('ROLE_MASTER')">
	<ma:navbar-c />
</sec:authorize>
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-b2 />
<div class="container">
	<h1>입고서 리스트</h1>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>입고 번호</th>
				<th>담당자</th>
				<th>발주 날짜</th>
			</tr>
		</thead>
		<tbody id="in-list-table-body">
			<c:forEach items="${inList }" var="in" varStatus="status">
			<tr class='in-list' style="cursor:pointer;">
				<td>${status.count }</td>
				<td class="order-no">${in.ORDER_NO }</td>
				<td>${in.EMP_NAME }</td>
				<td><fmt:formatDate value="${in.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
	
	
<%-- 	<h1>미입고 리스트 조회</h1>
	<h3>발주 승인(1)된 애들</h3>
	체크하면 입고완료.
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>발주 번호</th>
				<th>상품</th>
				<th>EA</th>
				<th>처리 상태</th>
				<th>담당자</th>
								<th>발주 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orderList }" var="order" varStatus="status">
			<tr class='order-list'>
				<td>${status.count }</td>
				<td class="order-no">${order.ORDER_NO }</td>
				<td>${order.PRODUCT_NO }</td>
				<td>${order.ORDER_EA }</td>
				<td>${order.ORDER_STATUS }</td>
				<td>${order.EMP_CODE }</td>
				<td><fmt:formatDate value="${order.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table> --%>
	
	
	
	
</div>
</div>



<!-- Modal -->
<div class="modal fade" id="order-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">입고서 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
<!-- 	<div id="order-detail-cost">총 가격: <span>값</span></div> -->
		<div id="order-detail-products">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td>입고서 번호</td>
					<td id="order-detail-no"></td>
				</tr>
				<tr>
					<td>입고 날짜</td>
					<td id="order-detail-date"></td>
				</tr>
				<tr>
					<td>입고 매장 </td>
					<td id="order-detail-store"></td>
				</tr>
				<tr>
					<td>담당자 </td>
					<td id="order-detail-emp"></td>
				</tr>
			</tbody>
		</table>
			<div class="form-group">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>상품타입</th>
							<th>상품번호</th>
							<th>상품이름</th>
							<th>갯수</th>
						</tr>
					</thead>
					<tbody id="order-detail-product-list">
					</tbody>
				</table>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <form id="order-confirm-form" method="post" action="${appRoot }/order/status-update">
        	<input id="order-confirm-value" type="text" readonly="readonly" name="ORDER_NO" hidden>
        	<input id="order-status-change" type="number" value="1" readonly="readonly" name="ORDER_STATUS" hidden>
	    	<button id="order-refuse-btn" type="button" class="btn btn-warning" hidden>발주 반려</button>
	        <button id="order-confirm-btn" type="submit" class="btn btn-primary" hidden>발주 승인</button>
        </form>
      </div>
    </div>
  </div>
</div>




</body>
</html>
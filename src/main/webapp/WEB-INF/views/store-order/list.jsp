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

<script>
$(document).ready(function(){
	
	//해당하는 table 클릭하면 모달 실행
	$(".order-list").click(function(){

		$('.removeTr').remove();
		
		var ono = $(this).find(".order-no").text();
		var data = {ono: ono}
		var html = "";
		
		//읽어오는 AJAX
		var request= $.ajax({
			type: "post",
			url: "${appRoot}/store-order/detail",
			data: data,
			success: function(data){
				console.log("성공");
			},
			error: function(){
				console.log("실패");
			}
		})
		
		request.done(function(data){
			console.log(data);
			//읽은 값을 넣어준다.

			$("#order-detail-no").text(data[0].order_NO);
			$("#order-detail-date").text(data[0].order_DATE);
			$("#order-detail-store").text(data[0].store_NO);
			$("#order-detail-emp").text(data[0].emp_CODE);
			$("#order-detail-status").text(data[0].order_STATUS);
				
			$("#order-confirm-value").val(data[0].order_NO);
			
			for(i=0; i<data.length; i++){
				html += "<tr class='removeTr'>";
				html += "<td>0</td>";
				html += "<td>상품타입</td>";
				html += "<td>" + data[i].product_NO + "</td>";
				html += "<td>상품이름</td>";
				html += "<td>" + data[i].order_EA + "</td>";
				html += "</tr>"
			}
			//테이블 그려주기
			$("#order-detail-product-list").append(html);
		})
		
		$("#order-detail-modal").modal('show');
		
	})
	
	//반려 버튼
	$("#order-refuse-btn").click(function(){
		$("#order-status-change").val("2")
		$("#order-confirm-form").submit();
	})
	
})
</script>

</head>
<body>
<ma:navbar />
<div class="container">
	<h1>발주서 목록(창고->매장)</h1>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>발주 번호</th>
				<th>처리 상태</th>
				<th>담당자</th>
				<th>발주 날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="order" varStatus="status">
			<tr class='order-list'>
				<td>${status.count }</td>
				<td class="order-no">${order.ORDER_NO }</td>				
				<td>${order.ORDER_STATUS }</td>
				<td>${order.EMP_CODE }</td>
				<td><fmt:formatDate value="${order.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>

<!-- Modal -->
<div class="modal fade" id="order-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">발주서 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<div id="order-detail-no">발주 번호:</div>
      	<div id="order-detail-date">발주 날짜:</div>
      	<div id="order-detail-store">발주매장:</div>
      	<div id="order-detail-emp">담당자:</div>
      	<div id="order-detail-status">처리상태:</div>
<!-- 	<div id="order-detail-cost">총 가격: <span>값</span></div> -->
		<div id="order-detail-products">상품List
			<div class="form-group">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>#</th>
							<th>상품타입</th>
							<th>상품번호</th>
							<th>상품이름</th>
							<th>갯수</th>
<!-- 						<th>구입가격</th> -->
						</tr>
					</thead>
					<tbody id="order-detail-product-list">
					</tbody>
				</table>
			</div>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <form id="order-confirm-form" method="post" action="${appRoot}/store-order/status-update">
        	<input id="order-confirm-value" type="text" readonly="readonly" name="ORDER_NO" >
        	<input id="order-status-change" type="number" value="1" readonly="readonly" name="ORDER_STATUS">
	    	<button id="order-refuse-btn" type="button" class="btn btn-warning">발주 반려</button>
	        <button id="order-confirm-btn" type="submit" class="btn btn-primary">발주 승인</button>
        </form>
      </div>
    </div>
  </div>
</div>

</html>
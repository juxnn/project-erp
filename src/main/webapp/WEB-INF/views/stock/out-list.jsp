<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
$(function(){
	$("#out-list-table-body").on("click", ".out-list", function(){
		
		$('.removeTr').remove();
		
		var ono = $(this).find(".order-no").text();		
		var data = {ono: ono}
		
		var html = "";
		
		var request = $.ajax({
		
			type: "post",
			url: "${appRoot}/stock/out-list-detail",
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
	<ma:navbar-b />
</sec:authorize>
<ma:navbar-c />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-c1 />
<div class="container">
	<h1>출고서 목록</h1>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>출고서 NO</th>
				<th>출고 매장</th>
				<th>담당자</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody id="out-list-table-body">
			<c:forEach items="${list }" var="out" varStatus="status">
			<tr class='out-list' style="cursor:pointer;">
				<td>${status.count }</td>
				<td class='order-no'>${out.ORDER_NO }</td>
				<td>${out.STORE_NAME }</td>
				<td>${out.EMP_NAME }</td>
				<td><fmt:formatDate value="${out.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>	
</div>
</div>
<!-- Modal -->
<div class="modal fade" id="order-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">출고서 상세 내역</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<div id="order-detail-products">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td>출고서 번호</td>
					<td id="order-detail-no"></td>
				</tr>
				<tr>
					<td>출고 날짜</td>
					<td id="order-detail-date"></td>
				</tr>
				<tr>
					<td>출고 매장 </td>
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
      </div>
    </div>
  </div>
</div>



</body>
</html>
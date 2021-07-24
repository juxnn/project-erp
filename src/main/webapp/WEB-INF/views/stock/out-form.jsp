<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<%@ include file="/WEB-INF/subModules/stock-out-form-script.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ma:navbar />
<div class="container">
	<h1>출고 등록</h1>
	(창고에서 매장으로 출고)<br>
	출고서 번호(자동채번)<br>
	날짜(알아서)<br>
	<hr>
	매장: ${employee.STORE_NO }<br>
	담당자(로그인) : ${employee.EMP_NAME }<br>	
	<br>
	<!-- 
	창고에서 모달로 제품리스트들을 가져오는데 재고도 확인이 되어야 한다.
	 -->
	상품NO<br>
	상품EA<br>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#add-product-modal">직접출고하기</button>
	<hr>
	<h3>발주서중 처리상태 1인 애들만 가져옴.</h3>
	<h4>상품 재고랑 갯수 확인하고 알아서 발주하는 버튼 만들까?</h4>
	
	
<!-- **************************************** 발주서 List(status:1) **************************************** -->		
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>발주 번호</th>
				<th>처리 상태</th>
				<th>발주 날짜</th>
				<th>확인 하기</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="order" varStatus="status">
			<tr class='order-list'>
				<td>${status.count }</td>
				<td class="order-no">${order.ORDER_NO }</td>				
				<td>${order.ORDER_STATUS }</td>
				<td><fmt:formatDate value="${order.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
				<td><button class="store-order-btn" name="store-order" value='${order.ORDER_NO }'>확인</button></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
	
<!-- **************************************** 직접 출고하기  **************************************** -->
<!-- **************************************** 모달  **************************************** -->		
	<div class="modal fade" id="add-product-modal" tabindex="-1">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
		    <div class="modal-header">
		      <h5 class="modal-title">(창고)재고 조회</h5>
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
				    
				    
<!-- **************************************** 모달 재고 목록 부분 **************************************** -->				    
				<div class="form-group">
					<h3>재고 List</h3>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>#</th>
								<th><input type="checkbox" value="selectall" onclick="selectAll(this)"></th>
								<th>상품번호</th>
								<th>상품이름</th>
								<th>갯수</th>
								<th>재고</th>
							</tr>
						</thead>
						<tbody id="add-product-modal-body"></tbody>
					</table>
					<button id="product-select-btn" type="button" class="btn btn-primary">상품선택</button>
				</div>
				
<!-- **************************************** 모달 출고서 부분 **************************************** -->			
				<div class="form-group">
				<h3>출고서</h3>
					<input id="store-order-value" type="number" name="STORE_NO">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>#</th>
								<th><input type="checkbox" value="selectall2" onclick="selectAll2(this)"></th>
								<th>상품번호</th>
								<th>상품이름</th>
								<th>갯수</th>
							</tr>
						</thead>
						<tbody id="add-out-product-modal-body">
						</tbody>
					</table>
					<button id="product-remove-btn" type="button" class="btn btn-primary">선택삭제</button>		
				</div>
				<p>Modal body text goes here.</p>
		    </div>
<!-- **************************************** 모달 아래 버튼 부분 **************************************** -->			    
		    <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" class="btn btn-primary" id='out-order-submit-btn'>선택 출고서 제출</button>
		    </div>
		  </div>
		</div>
	</div>
	
<!-- **************************************** 발주서 확인  **************************************** -->
<!-- **************************************** 모달  **************************************** -->		
	
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
        <form id="order-confirm-form" method="post" action="${appRoot }/stock/complete-order">
        	<input id="out-confirm-value" type="text" readonly="readonly" name="ORDER_NO" >
        	<input id="order-status-change" type="number" value="3" readonly="readonly" name="ORDER_STATUS">
	        <button id="out-confirm-btn" type="submit" class="btn btn-primary">그대로 출고 하기</button>
        </form>
      </div>
    </div>
  </div>
</div>




	
	
	
	
</div>
</body>
</html>
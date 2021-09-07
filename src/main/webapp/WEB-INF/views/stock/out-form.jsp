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
<sec:authorize access="hasRole('ROLE_MASTER')">
	<ma:navbar1 />
	<ma:navbar-b />
</sec:authorize>
<ma:navbar-c />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box-c1 />
<div class="container">
<!-- ********************************* 타이틀 ********************************* -->
<div class="title-box">
	<h1>출고등록</h1>
</div>

	<!-- 
	창고에서 모달로 제품리스트들을 가져오는데 재고도 확인이 되어야 한다.
	 -->
	<h1>미출고 발주 리스트</h1>
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
				<td>${order.STATUS_NAME }</td>
				<td><fmt:formatDate value="${order.ORDER_DATE}" pattern="yyyy-MM-dd" /></td>
				<td><button class="store-order-btn" name="store-order" value='${order.ORDER_NO }'>확인</button></td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
	<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#add-product-modal">직접출고하기</button>
<!-- **************************************** 직접 출고하기  **************************************** -->
<!-- **************************************** 모달  **************************************** -->		
	<div class="modal fade" id="add-product-modal" tabindex="-1">
		<div class="modal-dialog modal-xl">
		  <div class="modal-content">
		    <div class="modal-header">
		      <h5 class="modal-title">출고서 직접 작성하기</h5>
		      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		        <span aria-hidden="true">&times;</span>
		      </button>
		    </div>
		    <div class="modal-body">
			
			<h5>재고 조회</h5>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">상품타입</span>
				</div>
				<select class="form-control" id="type-select" name="PRODUCT_TYPE">
					<option value="">전체 타입</option>
					<c:forEach items="${productTypeList }" var="type">
						<option id="${type.PRODUCT_TYPE }" value="${type.PRODUCT_TYPE }">${type.PRODUCT_TYPE }</option>
					</c:forEach>
				</select>
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">상품코드</span>
				</div>
				<input type="text" class="form-control" placeholder="상품코드를 입력하세요." id="pno">	
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">상품명</span>
				</div>
				<input type="text" class="form-control" placeholder="상품명을 입력하세요." id="pname">
				
				<div class="input-group-appepend">
					<button id="product-search-btn"class="btn btn-primary my-2 my-sm-0" type="button">조회</button>
				</div>
			</div>

				
				    
				    
<!-- **************************************** 모달 재고 목록 부분 **************************************** -->				    
				<div class="form-group">
					<table class="table table-hover">
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
					<button id="product-select-btn" type="button" class="btn btn-secondary">상품 선택</button>
				</div>
				
<!-- **************************************** 모달 출고서 부분 **************************************** -->			
				<h5>출고서</h5>
				<div class="form-group">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text" id="basic-addon1">출고 매장 선택</span>
					</div>
					<select class="form-control" id="store-select" name="STORE_NO">
							<c:forEach items="${storeList}" var="store">
							<option value="${store.STORE_NO }">${store.STORE_NAME }</option>
						</c:forEach>
					</select>
				
				<div class="input-group-prepend">
					<span class="input-group-text">작성일</span>
				</div>
				<input type="text" id="today-date" class="form-control" value="" readonly>
				
				<div class="input-group-prepend">
					<span class="input-group-text" id="basic-addon1">작성자</span>
				</div>
				<input type="text" class="form-control" value="${pinfo.employee.EMP_NAME }" readonly>
				</div>
				
				
				
					<table class="table table-hover">
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
			        <button id="product-remove-btn" type="button" class="btn btn-secondary">선택 삭제</button>	
				</div>
		    </div>
<!-- **************************************** 모달 아래 버튼 부분 **************************************** -->			    
		    <div class="modal-footer">
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
      
      
      
		<div class="form-group">
		<table class="table table-bordered" >
		  <thead>
		  </thead>
		  <tbody>
		  	<tr>
		      <td>발주 번호</td>
		      <td id="order-detail-no"></td>
		    </tr>
		    <tr>
		      <td>발주 날짜</td>
		      <td id="order-detail-date"></td>
		    </tr>
		   	<tr>
		      <td>발주 매장</td>
		      <td id="order-detail-store"></td>
		    </tr>
		    <tr>
		      <td>담당자</td>
		      <td id="order-detail-emp"></td>
		    </tr>
		    <tr>
		      <td>처리 상태</td>
		      <td id="order-detail-status"></td>
		    </tr>
		  </tbody>
		</table>
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
      <div class="modal-footer">
        <form id="order-confirm-form" method="post" action="${appRoot }/stock/complete-order">
        	<input id="out-confirm-value" type="text" readonly="readonly" name="ORDER_NO" hidden>
        	<input id="order-status-change" type="number" value="3" readonly="readonly" name="ORDER_STATUS" hidden>
	        <button id="out-confirm-btn" type="submit" class="btn btn-primary">그대로 출고 하기</button>
        </form>
      </div>
      </div>
    </div>
  </div>
</div>




	
	
	
</div>	
</body>
</html>
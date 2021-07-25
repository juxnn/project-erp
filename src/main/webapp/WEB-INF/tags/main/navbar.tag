<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/main/home" var="mainUrl">
</c:url>


<c:url value="/store/list" var="storeListUrl">
</c:url>
<c:url value="/store/add" var="storeAddUrl">
</c:url>

<c:url value="/product/list" var="productListUrl">
</c:url>
<c:url value="/product/add" var="productAddUrl">
</c:url>


<c:url value="/customer/list" var="customerListUrl">
</c:url>
<c:url value="/customer/add" var="customerAddUrl">
</c:url>


<c:url value="/employee/list" var="employeeListUrl">
</c:url>
<c:url value="/employee/register" var="registerUrl">
</c:url>

<c:url value="/stock/list" var="stockListUrl">
</c:url>
<c:url value="/stock/edit" var="stockEditUrl">
</c:url>

<c:url value="/order/form" var="orderFormUrl">
</c:url>

<c:url value="/order/list" var="orderListUrl">
</c:url>



<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${mainUrl }">1주차 작업</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">

     
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          사원관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <a class="dropdown-item" href="${employeeListUrl }">사원 목록</a>
          <a class="dropdown-item" href="${registerUrl }">사원 등록</a>
          <a class="dropdown-item" href="${appRoot }/employee/test">사원 정보수정</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          매장관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${storeListUrl }">매장 목록</a>
          <a class="dropdown-item" href="${storeAddUrl }">매장 등록</a>
          <a class="dropdown-item" href="#">매장 정보수정</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          상품관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${productListUrl }">상품 목록</a>
          <a class="dropdown-item" href="${productAddUrl }">상품 등록</a>
          <a class="dropdown-item" href="#">정보 수정</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          재고관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${stockListUrl }">재고 목록</a>
          <a class="dropdown-item" href="${stockEditUrl }">재고 관리</a>
          <a class="dropdown-item" href="${appRoot }/store-order/form">발주서 작성(창고->매장)</a>
          <a class="dropdown-item" href="${appRoot }/store-order/list">발주서 목록(창고->매장)</a>
          <a class="dropdown-item" href="${appRoot }/stock/in-form">입고 등록</a>
          <a class="dropdown-item" href="${appRoot }/stock/in-list">입고 조회</a>
          <a class="dropdown-item" href="${appRoot }/stock/out-form">출고 등록</a>
          <a class="dropdown-item" href="${appRoot }/stock/out-list">출고 조회</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          발주관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${orderFormUrl }">발주서 작성</a>
          <a class="dropdown-item" href="${orderListUrl }">발주 리스트/검토</a>
          <a class="dropdown-item" href="#">발주 검토</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          고객관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${customerListUrl }">고객 목록</a>
          <a class="dropdown-item" href="${customerAddUrl }">고객 등록</a>
          <a class="dropdown-item" href="#">고객 정보수정</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="">빈칸임</a>
      </li>
      
      
	  <sec:authorize access="!isAuthenticated()">
	  	<li class="nav-item">
	  		<a class="nav-link" href="${registerUrl }">사원등록</a>
	  	</li>
	  </sec:authorize>
    </ul>
  </div>
  
  <sec:authorize access="!isAuthenticated()">
	<a href="${appRoot }/employee/login" class="btn btn-outline-primary">로그인</a>  
  </sec:authorize>
  
  <sec:authorize access="isAuthenticated()">
	  <form action="${appRoot }/logout" method="post">
	  	<input type="submit" class="btn btn-outline-secondary" value="로그아웃">
	  </form>
  </sec:authorize>
</nav>






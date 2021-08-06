<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/main/home" var="mainUrl"></c:url>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="">물류부</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
     <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          발주관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <a class="dropdown-item" href="${appRoot }/store-order/list">발주 조회</a>
        <a class="dropdown-item" href="${appRoot }/stock/out-form">출고 등록</a>
        <a class="dropdown-item" href="${appRoot }/store-order/list">발주 반려</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
 		  외부 발주관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${appRoot }/order/form">외부 발주서 작성</a>
          <a class="dropdown-item" href="${appRoot }/order/list">외부 발주 list 확인</a>
        <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      
	  <sec:authorize access="!isAuthenticated()">
	  	<li class="nav-item">
	  		<a class="nav-link" href=""> 뭘할까 </a>
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






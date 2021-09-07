<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/main/home" var="mainUrl"></c:url>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${mainUrl }"> 영업부</a>
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
        <a class="dropdown-item" href="${appRoot }/store-order/form">발주서 작성</a>
          <a class="dropdown-item" href="${appRoot }/store-order/list">발주 list 확인</a>
        </div>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
 		  재고관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${appRoot }/stock/list">재고조회</a>
          <a class="dropdown-item" href="${appRoot }/stock/in-list">입고조회</a>
          <a class="dropdown-item" href="${appRoot }/stock/in-form">입고등록</a>          
        </div>
      </li>
      
    </ul>
  </div>
  
  <sec:authorize access="isAuthenticated()">
  	  <div>${pinfo.employee.DEPT_NAME }(${pinfo.employee.RANK_NAME }) ${pinfo.employee.EMP_NAME }님 안녕하세요</div>
	  <form action="${appRoot }/logout" method="post">
	  	<input type="submit" class="btn btn-outline-secondary" value="로그아웃">
	  </form>
  </sec:authorize>
</nav>






<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/main/home" var="mainUrl"></c:url>

<c:url value="/employee/list" var="employeeListUrl"></c:url>
<c:url value="/employee/register" var="registerUrl"></c:url>
<c:url value="/employee/resign" var="resignUrl"></c:url>

<c:url value="/store/list" var="storeListUrl"></c:url>
<c:url value="/store/add" var="storeAddUrl"></c:url>

<c:url value="/product/add" var="productAddUrl"></c:url>
<c:url value="/product/list" var="productListUrl"></c:url>




<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${mainUrl }"> 관리부</a>
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
        <a class="dropdown-item" href="${employeeListUrl }">사원 조회</a>
          <a class="dropdown-item" href="${registerUrl }">사원 등록</a>
          <a class="dropdown-item" href="${resignUrl }">퇴사자 관리</a>
        </div>
      </li>
      
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
 		  부서관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${storeListUrl }">매장 관리</a>
          <a class="dropdown-item" href="${storeAddUrl }">매장 등록</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <i class="fas fa-list"></i>
          상품관리
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="${productListUrl }">상품 조회</a>
          <a class="dropdown-item" href="${productAddUrl }">상품 등록</a>
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






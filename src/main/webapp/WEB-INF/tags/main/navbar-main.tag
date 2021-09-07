<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<c:url value="/main/home" var="mainUrl">
</c:url>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="${mainUrl }">컴노스</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
  </div>
  
  
  <sec:authorize access="!isAuthenticated()">
	<a href="${appRoot }/employee/login" class="btn btn-outline-primary">로그인</a>  
  </sec:authorize>
  <sec:authorize access="isAuthenticated()">
	  <form action="${appRoot }/logout" method="post">
	  	<input type="submit" class="btn btn-outline-secondary" value="로그아웃">
	  </form>
  </sec:authorize>
<%--   <sec:authorize access="hasRole('ROLE_RESIGN')">
	  <form action="${appRoot }/logout" method="post">
	  	<input type="submit" class="btn btn-outline-secondary" value="로그아웃">
	  </form>
  </sec:authorize> --%>
</nav>






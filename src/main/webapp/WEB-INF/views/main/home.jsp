<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<style>
#main-title{
	margin-top: 100px;
}
</style>

<title>Insert title here</title>
</head>
<body>
<sec:authorize access="!isAuthenticated()">
	<ma:navbar-main />
</sec:authorize>

<sec:authorize access="hasRole('ROLE_MASTER')">
	<ma:navbar1 />
	<ma:navbar-b />
	<ma:navbar-c />
</sec:authorize>

<sec:authorize access="hasRole('ROLE_MTEAM')">
	<ma:navbar1 />
</sec:authorize>

<sec:authorize access="hasRole('ROLE_STEAM')">
	<ma:navbar-b />
</sec:authorize>

<sec:authorize access="hasRole('ROLE_LTEAM')">
	<ma:navbar-c />
</sec:authorize>

<div class="container">
	<h1 id="main-title">컴노스 물류 관리 홈페이지 입니다.</h1>
</div>
</body>
</html>
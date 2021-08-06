<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ma:navbar />

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
	<h1>메인페이지 HOME 입니다.</h1>
</div>
</body>
</html>
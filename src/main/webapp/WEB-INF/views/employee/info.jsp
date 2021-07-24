<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">

<h1>회원정보</h1>
	
<h5>${employee.EMP_CODE }</h5>
<h5>${employee.EMP_NAME }</h5>
<h5>${employee.EMP_SEX }</h5>
<h5>${employee.DEPT_NO }</h5>
	
</div>
</body>
</html>
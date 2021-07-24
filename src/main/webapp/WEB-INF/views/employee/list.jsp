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
<div class="container">
<h1>직원 목록</h1>
<%-- ${storeList }
${rankList }
${deptList } --%>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>사번</th>
				<th>이름</th>
				<th>매장</th>
				<th>직급</th>
				<th>부서</th>
				<th>번호</th>
				<th>성별</th>
				<th>이메일</th>
				<th>퇴사여부</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="employee" varStatus="status">
			<tr>
				<td>${status.count }</td>
				<td>${employee.EMP_CODE }</td>
				<td>${employee.EMP_NAME }</td>
				<td>${storeList[employee.STORE_NO].STORE_NAME }</td>
				<td>${rankList[employee.RANK_NO - 1].RANK_NAME}</td>
				<td>${deptList[employee.DEPT_NO - 1].DEPT_NAME}</td>
				<td>${employee.EMP_PHONE }</td>
				<td>${employee.EMP_SEX }</td>
				<td>${employee.EMP_EMAIL }</td>
				<td>${employee.CHECK_RESIGNATION }</td>				
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>
</body>
</html>
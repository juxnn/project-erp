<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<div class="side-box1">
	<div class="side-box2">
		<div class="side-box-name">사원관리</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/employee/list'">사원조회</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/employee/register'">사원등록</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/employee/resign'">퇴사자 관리</div>
	</div>
</div>
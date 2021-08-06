<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="side-box-A">
	<div class="side-box-B">
		<div class="side-box-name">상품관리</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/product/list'">상품조회</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/product/add'">상품등록</div>
	</div>
</div>
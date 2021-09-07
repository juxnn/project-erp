<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="side-box-A">
	<div class="side-box-B">
		<div class="side-box-name">발주관리</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/store-order/form'">발주서 작성</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/store-order/list'">발주조회</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/stock/out-form'">출고등록</div>
	</div>
</div>
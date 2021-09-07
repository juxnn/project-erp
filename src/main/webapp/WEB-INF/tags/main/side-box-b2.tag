<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="side-box-A">
	<div class="side-box-B">
		<div class="side-box-name">재고관리</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/stock/list'">재고조회</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/stock/in-list'">입고조회</div>
		<div class="side-box-content" style="cursor:pointer;" onclick="location.href='${appRoot}/stock/in-form'">입고등록</div>
	</div>
</div>
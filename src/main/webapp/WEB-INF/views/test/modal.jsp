<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.modal-body {
	
}

.modal-body-content {
	width: 900px;
	justify-content: center;
}

.input-group-text {
	width: 100px;
	justify-content: center;
}
</style>
</head>
<body>
	<ma:navbar />
	<ma:navbar1 />
	<div class="container">



		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal"
			data-target="#staticBackdrop">test</button>

		<!-- Modal -->
		<div class="modal fade" id="staticBackdrop" data-backdrop="static"
			data-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="staticBackdropLabel">발주서 상세내역</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body d-flex justify-content-center">
						<div class="modal-body-content">
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1"">발주서 NO</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1"">발주 날짜</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
							</div>

							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">지점</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">담당자</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
							</div>
							
							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1"">예비</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
							</div>





							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">처리상태</span>
								</div>
								<input type="password" class="form-control"
									placeholder="이름을 입력하세요." aria-label="Username"
									aria-describedby="basic-addon1">
							</div>






							<div class="input-group mb-3">
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">상품타입</span>
								</div>
								<select class="form-control" id="exampleFormControlSelect1">
									<option>타입1</option>
									<option>타입2</option>
								</select>
								
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">상품종류</span>
								</div>
								<select class="form-control" id="exampleFormControlSelect1" style="width:170px">
									<option>상품1</option>
									<option>상품2</option>
								</select>
								
								<div class="input-group-prepend">
									<span class="input-group-text" id="basic-addon1">EA</span>
								</div>
								<input type="number" class="form-control" aria-describedby="basic-addon1">
							</div>




							<button type="button" class="btn btn-secondary"
								style="width: 100px;">상품 추가</button>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Understood</button>
					</div>
				</div>
			</div>
		</div>






	</div>
</body>
</html>
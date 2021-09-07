<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
/* 카카오 주소 API */
function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

</script>


<meta charset="UTF-8">
<title>Insert title here</title>
<style>
html, body{
	height: 100%;
}
.box {
	display: flex;
	height: 100%;
}
.side-box-A {
	background-color: white;
	width: 220px;
	padding-top: 20px;
	border-right-color: #C0C0C0;
	border-right-style: solid;
	border-right-width: 1px;
	hight: 500px;
}
.side-box-name {
	background-color: #DCDCDC;
	height: 100px;
	padding: 30px;
	font-size: 25px;
	margin-top: -20px;
	text-align: center;
}

.side-box-content {
	height: 70px;
	font-size: 20px;
	padding: 15px;
	border-top-color: #C0C0C0;
	border-top-style: solid;
	border-top-width: 1px;
	text-align: center;
}
.container{
	margin-top: 80px;
}
.form-div{
	max-width: 600px;
	margin: auto;
}
.title-box {
	text-align: center;
	margin-bottom: 50px;
}
.input-group-text {
	width: 126px;
	align-content: center;
	justify-content: center;
}

</style>
</head>
<body>
<ma:navbar1 />
<sec:authorize access="hasRole('ROLE_MASTER')">
	<ma:navbar-b />
	<ma:navbar-c />
</sec:authorize>
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box2 />
<div class="container">
<div class="title-box">
	<h1>매장등록</h1>
</div>
	<div class="form-div">
	
	<form action="${appRoot }/store/add" method="post">
	
	
<div class="input-group mb-3">
	<div class="input-group-prepend">
	<span class="input-group-text" id="basic-addon1">매장넘버</span></div>
	<input type="number" class="form-control" name="STORE_NO" placeholder="매장 넘버를 입력하세요.">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
	<span class="input-group-text" id="basic-addon1">매장이름</span></div>
	<input type="text" class="form-control" name="STORE_NAME" placeholder="매장 이름을 입력하세요.">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
	<span class="input-group-text" id="basic-addon1">전화번호</span></div>
	<input type="text" class="form-control" name="STORE_PHONE" placeholder="매장 전화번호를 입력하세요.">
</div>

<!--  주소 -->
<div class="input-group mb-3">
<div class="input-group-prepend">
	<input type="button"  class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
	</div>
	<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호">
	<input type="text" class="form-control" id="sample6_extraAddress" placeholder="참고항목">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">주소</span>
	</div>
	<input type="text" class="form-control" id="sample6_address" placeholder="주소" name="STORE_ADDRESS">
</div>
<div class="input-group mb-3">
	<div class="input-group-prepend">
		<span class="input-group-text">상세주소</span>
	</div>
	<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소" name="STORE_ADDRESS_SUB">
</div>

		<button type="submit" class="btn btn-primary">매장정보 생성</button>
	</form>
</div>
</div>
</div><!-- .box -->
</body>
</html>
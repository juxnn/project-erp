<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ma" tagdir="/WEB-INF/tags/main" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5cb0c7b1fb2bc26a7816dec9cdcd048e&libraries=services"></script>

<style>
html, body{
	height: 100%;
}
.box {
	display: flex;
	height: 100%
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

.title-box {
	text-align: center;
	margin-bottom: 50px;
}
#map{
	margin: auto;
}

</style>

<script>
$(document).ready(function(){
	
// ********************** 지도 **********************

var coords_position;

function mapAddress(storeAddress){
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 4 // 지도의 확대 레벨
	    };
	
	mapContainer.style.width = '700px';
    mapContainer.style.height = '400px'; 
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
		
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(storeAddress, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	        
	        coords_position = marker.getPosition();
	       	        
	    } 
	});
	return map;
}
	
// ********************** table 클릭시 동작 **********************
	$("#store-table-body").on("click", ".storeTr", function(){
		
		var storeNo = $(this).find(".storeNo").val();
		console.log(storeNo)
		var data = {storeNo: storeNo}
		
		var request = $.ajax({
			type: "post",
			url: "${appRoot}/store/detail",
			data: data,
			success: function(data){
				console.log("성공");
			},
			error: function(){
				console.log("실패");
			}
		})
		
		request.done(function(data){
			
			$("#modal-store-name").text(data.store_NAME);	
			$("#modal-store-no").text(data.store_NO);
			$("#modal-store-address").text(data.store_ADDRESS);
			$("#modal-store-phone").text(data.store_PHONE);
			$("#modal-emp-count").text(data.emp_COUNT);
		
			var showMap = mapAddress(data.store_ADDRESS);
			
			$('#store-detail-modal').modal('show');
			$("#store-detail-modal").on("shown.bs.modal", function() {
				showMap.relayout();
				showMap.setCenter(coords_position); //넣어줘야하는데
			})		
		})
	})
})




</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<ma:navbar />
<ma:navbar1 />
<div class="box">
<!-- ********************************* 사이드 박스 ********************************* -->
<ma:side-box2 />

<div class="container">
	<h1>매장 목록</h1>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>#</th>
				<th>매장(번호)</th>
				<th>주소</th>
				<th>연락처</th>
			</tr>
		</thead>
		<tbody id="store-table-body">
			<c:forEach items="${list }" var="store" varStatus="status">
			<tr class='storeTr' style="cursor:pointer;">
				<td>${status.count }<input class="storeNo" type="number" value="${store.STORE_NO }" hidden="hidden"></td>
				<td>${store.STORE_NAME } (${store.STORE_NO })</td>
				<td>${store.STORE_ADDRESS }</td>
				<td>${store.STORE_PHONE }</td>
			</tr>
			</c:forEach>	
		</tbody>
	</table>
</div>

<!-- 모달 -->
<div class="modal fade" id="store-detail-modal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">매장 정보</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<table class="table table-bordered" >
		  <thead>
		  </thead>
		  <tbody>
		  	<tr>
		      <td>매장넘버</td>
		      <td id="modal-store-no"></td>
		    </tr>
		    <tr>
		      <td>매장명</td>
		      <td id="modal-store-name"></td>
		    </tr>
		    <tr>
		      <td>주소</td>
		      <td id="modal-store-address"></td>
		    </tr>
		    <tr>
		      <td>연락처</td>
		      <td id="modal-store-phone"></td>
		    </tr>
		    <tr>
		      <td>총 사원 수</td>
		      <td id="modal-emp-count"></td>
		    </tr>
		  </tbody>
		</table>
      </div>
      <!-- 지도 -->
	  <div id="map"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning">정보 수정</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</div><!-- .box -->

</body>

</html>
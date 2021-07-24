<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>









<script>
$(document).ready(function(){
	//모달에서 검색버튼 실행
	$("#product-search-btn").click(function(e){
		
		$('.removeTr').remove();
		
		var type = changeTypeSelect();
		var pno = $("#pno").val();
		var pname = $("#pname").val();
		
		var data = {PRODUCT_TYPE: type, 
					PRODUCT_NO: pno,
					PRODUCT_NAME: pname}
		
		var html = "";
		var request = $.ajax({
			type: "post",
			url: "${appRoot}/order/search-product",
			data: data,
			success: function(data){
					console.log("성공");
			},
			error:function(){
				console.log("실패");
			}
		});
		
		request.done(function(data){
			
			console.log(data);
			//검색값이 있을 경우
			if(data.length > 0){
				for(i=0; i<data.length; i++){
					var x = i + 1
					html += "<tr class='removeTr'>"
					html += "<td>" + x + "</td>";
					html += "<td><input type='checkbox' name='product'></td>";
					html += "<td>" + data[i].product_TYPE + "</td>";
					html += "<td>" + data[i].product_NO + "</td>";
					html += "<td>" + data[i].product_NAME + "</td>";
					html += "<td><input type='number'></td>"
					html += "</tr>"
				}
			//검색값이 없을 경우
			}else{
				$('.removeTr').remove();
			}
			//테이블 그려주기
			$("#search-modal-body").append(html);
			
			
		})
		
		
	})	
})

//체크박스 전체 선택 함수
function selectAll(selectAll)  {
	const checkboxes 
	     = document.getElementsByName('product');
	
	checkboxes.forEach((checkbox) => {
	  checkbox.checked = selectAll.checked;
	})
}


//상품 타입 선택시 value 값 정해주기.
function changeTypeSelect(){
	var typeSelect = document.getElementById("product-type-select");
	
	var typeId = typeSelect.options[typeSelect.selectedIndex].value;
	console.log(typeId);
	
	return typeId;
	
}
</script>










































</head>
<body>
<div class="container">
	
</div>
</body>
</html>
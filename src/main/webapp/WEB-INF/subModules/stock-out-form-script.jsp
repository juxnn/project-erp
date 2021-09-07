<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <script>
$(document).ready(function(){
	$("#today-date").val(getToday());
	
	$("#product-search-btn").click(function(){
	//모달에서'조회' 버튼 클릭시	
		$('.removeTr').remove();
		var modalBody = $("#add-product-modal-body");

		var type = changeTypeSelect();
		var type2 = 0;	//창고(0)의 재고를 조회해서 가져온다.
		var pno = $("#pno").val();
		var pname =$("#pname").val();
		
		var data = {type: type,
					type2: type2,
					keyword1: pno,
					keyword2: pname};
		
		console.log(data);
		
		var searchStockList = "";
		
		var request = $.ajax({
			type: "post",
			url: "${appRoot}/stock/search-product",
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
			if(data.length>0){
				for(i=0; i<data.length; i++){	//검색값이 있을 경우
					searchStockList += "<tr class='removeTr'>";
					searchStockList += "<td>"+ (i+1) +"</td>";
					searchStockList += "<td><input type='checkbox' name='product' value='"
											+ data[i].product_NO + "'></td>";
					searchStockList += "<td>" + data[i].product_NO + "</td>";
					searchStockList += "<td>" + data[i].product_NAME + "</td>";
					searchStockList += "<td> <input type='number' name='ea' value='1'"
					+ " onchange='this.value = Math.floor(Math.max(this.value,1))'> </td>";
					searchStockList += "<td>" + data[i].store_STOCK_EA + "</td>";
					searchStockList += "</tr>";
				}
			}else{
				$('.removeTr').remove();	//검색값이 없을 경우
			}
			modalBody.append(searchStockList);
		})
	})
	
	$("#product-select-btn").click(function(){	//모달-상품선택 버튼 클릭시
		getCheckboxValue();
	})
	
	$("#product-remove-btn").click(function(){	//모달-삭제 버튼 클릭시
		removeCheckboxValue();
	})
	
	$("#out-order-submit-btn").click(function(){	//모달-출고서 제출버튼 클릭시
		submitCheckboxValue();		
	})
	
	$(".store-order-btn").click(function(){		//내부발주서 확인버튼
		var ono = $(this).val()
		checkStoreOrder(ono);
	})

	
})
//검색에서 옵션 값이 바뀌면 그 값을 가져오는 함수
function changeTypeSelect() { 
	var typeSelect = document.getElementById("type-select");
	
	var type = typeSelect.options[typeSelect.selectedIndex].value;
	console.log(type);
	
	return type;
}

//체크박스 전체 선택 함수 (재고에서)
function selectAll(selectAll)  {
	const checkboxes 
	     = document.getElementsByName('product');
	
	checkboxes.forEach((checkbox) => {
	  checkbox.checked = selectAll.checked;
	})
}

//체크박스 전체 선택 함수 (선택된 출고서에서)
function selectAll2(selectAll2)  {
	const checkboxes 
	     = document.getElementsByName('out-product');
	
	checkboxes.forEach((checkbox) => {
	  checkbox.checked = selectAll2.checked;
	})
}


//'상품선택 버튼' = 체크된 체크박스의 value 값을 가져와서 테이블을 만들어준다.
function getCheckboxValue() {
	var obj =  $("[name=product]");
	var chkArray = new Array();
	var chkedList = "";
	
	console.log("length:" +$('input:checkbox[name=product]:checked').length);
	
	$('input:checkbox[name=product]:checked').each(function(){
		chkArray.push(this.value);
	});
	
	alert(chkArray);
	
	var chkbox = $('input:checkbox[name=product]:checked');	//체크된 체크박스를 가져온다.
	
	chkbox.each(function(i){
		var tr = chkbox.parent().parent().eq(i);
		var td = tr.children();
		
		var pno = td.eq(2).text();
		var pname = td.eq(3).text();
		var ea = td.eq(4).children().val();
		
		chkedList += "<tr>";
		chkedList += "<td>"+ (i+1) +"</td>";
		chkedList += "<td><input type='checkbox' name='out-product' value='"
								+ pno + "'></td>";
		chkedList += "<td>" + pno + "</td>";
		chkedList += "<td>" + pname + "</td>";
		chkedList += "<td> <input type='number' name='out-ea' value='" + ea + 
		"' onchange='this.value = Math.floor(Math.max(this.value,1))'> </td>";
		chkedList += "</tr>";
		
	})
	
	$('#add-out-product-modal-body').append(chkedList);
}


//모달-삭제 버튼시 출고서 선택list 에서 삭제.
function removeCheckboxValue(){
	var chkbox = $('input:checkbox[name=out-product]:checked');
	
	chkbox.each(function(i){
		var tr = chkbox.parent().parent();
		var td = tr.children();
		tr.remove();
	})
}

function submitCheckboxValue(){
	var chkbox = $('input:checkbox[name=out-product]:checked');
	
	var pnoArray = new Array();
	var peaArray = new Array();
	var STORE_NO = $('#store-select').val();
	console.log(STORE_NO);
	
	chkbox.each(function(i){
		var tr = chkbox.parent().parent().eq(i);
		var td = tr.children();
		
		var pno = td.eq(2).text();
		var pea = td.eq(4).children().val();
		
		pnoArray.push(pno);
		peaArray.push(pea);
	
	})
	
		var data = { products: pnoArray,
					 outEA: peaArray,
					 STORE_NO: STORE_NO};
	
		//ajax수정해야함
		$.ajax({
			type: "post",
			url: "${appRoot}/stock/out-submit",
			data: data,
			success: function(data){
					console.log("성공");
			},
			error:function(){
				console.log("실패");
			}
		});
//	}
	
	alert("제출되었습니다.");
}
//내부 발주서에서 확인 버튼 눌렀을 때
function checkStoreOrder(ono){
	
	$('.removeTr').remove();
	//console.log($(this));
	//var ono = $(this).find(".order-no").text();
	console.log(ono);
	var data = {ono: ono}
	var html = "";
	
	//읽어오는 AJAX
	var request= $.ajax({
		type: "post",
		url: "${appRoot}/store-order/detail",
		data: data,
		success: function(data){
			console.log("성공");
		},
		error: function(){
			console.log("실패");
		}
	})
	
	request.done(function(data){
		
		//javascript date format
		var order_date = new Date(data[0].order_DATE);
		
		String.prototype.string = function (len) { var s = '', i = 0; while (i++ < len) { s += this; } return s; };
		String.prototype.zf = function (len) { return "0".string(len - this.length) + this; };
		Number.prototype.zf = function (len) { return this.toString().zf(len); };
		
		const formatDate = (date)=>{
			let formatted_date = date.getFullYear() + "-" + (date.getMonth() + 1).zf(2) + "-" + date.getDate().zf(2);
		 	return formatted_date;
		}
		
		$("#order-detail-date").text(formatDate(order_date));		
		$("#order-detail-no").text(data[0].order_NO);
		$("#order-detail-store").text(data[0].store_NO);
		$("#order-detail-emp").text(data[0].emp_NAME);
		$("#order-detail-status").text(data[0].status_NAME);
			
		$("#out-confirm-value").val(data[0].order_NO);
		
		for(i=0; i<data.length; i++){
			html += "<tr class='removeTr'>";
			html += "<td> " + (i+1) + " </td>";
			html += "<td>" + data[i].product_TYPE + "</td>";
			html += "<td>" + data[i].product_NO + "</td>";
			html += "<td>" + data[i].product_NAME + " </td>";
			html += "<td>" + data[i].order_EA + "</td>";
			html += "</tr>"
		}
		//테이블 그려주기
		$("#order-detail-product-list").append(html);
	})
	
	$("#order-detail-modal").modal('show');
	
}

function getToday(){
	var date = new Date();
	var year = date.getFullYear();
	var month = ("0" + (1 + date.getMonth())).slice(-2);
	var day = ("0" + date.getDate()).slice(-2);
	
	return year + "-" + month + "-" + day;
}
</script>

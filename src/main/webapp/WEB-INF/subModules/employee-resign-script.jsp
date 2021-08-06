<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 캘린더 -->    
<!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>     -->

<!--  달력 -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script>
$(function () {
	$('#datetimepicker1').datetimepicker({ 
		format: 'YYYY-MM-DD',
		viewMode: 'years'
	});
	$('#datetimepicker2').datetimepicker({  
		format: 'YYYY-MM-DD',
		viewMode: 'years',
		useCurrent: false
	});
	 
	$("#datetimepicker1").on("change.datetimepicker", function (e) {
		$('#datetimepicker2').datetimepicker('minDate', e.date);
	});
		
	$("#datetimepicker2").on("change.datetimepicker", function (e) {
		$('#datetimepicker1').datetimepicker('maxDate', e.date);
	});
});

function searchEmployee(){
	$('.employeeTr').remove();
	var tableBody = $("#employee-table-body");
	var dept = $("#dept-select option:selected").val();
	var store = $("#store-select option:selected").val();
	var rank = $("#rank-select option:selected").val();
	var name = $("#name-select").val();
	var code = $("#code-select").val();
	var date = $("#date-select").val();
	
	var minDate = $("#min-date-select").val();	
	var maxDate = $("#max-date-select").val();
	
	console.log(minDate);	
	console.log(maxDate);
	
	var data = {DEPT_NO: dept,
				STORE_NO: store,
				RANK_NO: rank,
				EMP_NAME: name,
				EMP_CODE: code,
				MIN_DATE: minDate,
				MAX_DATE: maxDate,
				CHECK_RESIGNATION: 1};
	
	console.log(data);
	var employeeList = "";
	
	var request = $.ajax({
		type: "post",
		url: "${appRoot}/employee/search",
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
				employeeList += "<tr class='employeeTr' style='cursor:pointer;'>";
				employeeList += "<td>"+ (i+1) +"</td>";
				employeeList += "<td class='employeeNo'>"+ data[i].emp_CODE +"</td>";
				employeeList += "<td>" + data[i].emp_NAME + "</td>";
				employeeList += "<td>" + data[i].store_NAME + "</td>";
				employeeList += "<td>" + data[i].rank_NAME + "</td>"
				employeeList += "<td>" + data[i].dept_NAME + "</td>";				
				employeeList += "</tr>";
			}
		}else{
			$('.employeeTr').remove();	//검색값이 없을 경우
		}
		tableBody.append(employeeList);
	})
}


$(document).ready(function(){

})

</script>




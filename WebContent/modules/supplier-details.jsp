<%@ include file ="/includes/header.jsp" %>
<div class = "container">
		<div class = "row  my-4">
			<div class = "col-sm-2">
			<h1> Suppliers </h1>
			</div>	
			<div class = "col-sm-4"><div id="msgBox" style="display:none;"></div></div>
			<div class = "col-sm-6 ">
				<button class = "btn btn-primary btn-lg float-right ml-2" type = "button" id = "btnNewSupplier"> New</button>
				<button class = "btn btn-success btn-lg float-right ml-2" type = "button" id = "btnSaveSuppliers" style = "display:none;"> Save</button>
				<button class = "btn btn-danger btn-lg float-right ml-2" type = "button" id = "btnCancelSuppliers" style = "display:none;"> Cancel</button>
			</div>	
		</div>	
		<div class = "row">
			<div class = "col-sm-3">
				<h3> S.No </h3>
			</div>
			<div class = "col-sm-3">
				<h3> Supplier Name </h3>
			</div>
			<div class = "col-sm-3">
				<h3> GST Number </h3>
			</div>	
		</div>	
	<div id="container-suppliers"  class = "table-data-container" ></div>
	<div class = " py-3">
		<nav aria-label="Page navigation example">
		  <ul id = "pagination-box" class="pagination pagination-sm justify-content-end"> </ul>
		</nav>
	</div>
</div>

<script>
$(document).ready(function(){
	
	loadSuppliers();
	
	$("#btnNewSupplier").on("click",function(){
		 $("#btnSaveSuppliers").fadeIn(200,function(){ 
			 console.log("save btn appeared....");
			 $("#btnCancelSuppliers").fadeIn(200,function(){ 
				 console.log("cancel btn appeared....");
				 addNewSupplier();
				 $("#container-suppliers").animate({ scrollTop: $("#container-suppliers").get(0).scrollHeight}, 2000);
			 }); 
		 }); 
		 $(this).text("Add more");
	});
	
	$("#btnCancelSuppliers").on("click",function(){
		$("#btnCancelSuppliers").fadeOut(200,function(){ 
			console.log("cancel btn disappeared....");
			$("#btnSaveSuppliers").fadeOut(200,function(){ 
				console.log("save btn disappeared....");
				$(".new-record").remove();
				 $('#btnNewSupplier').text("New");
				 $("#container-suppliers").animate({ scrollTop: $("#container-suppliers").get(0)}, 2000);
			}); 
		}); 
	});
	
	$("#btnSaveSuppliers").on("click",function(){
		$("#btnCancelSuppliers").fadeOut(200,function(){ 
			$('#btnNewSupplier').text("New");
			saveSuppliers();
		});
		 
	});
	
});



var oldValue = "";
var newValue = "";

function setOldValue(textInputObject) {		
	oldValue = $(textInputObject).val().trim();
	console.log("old : " + oldValue);
}

function setNewValue(textInputObject) {		
	newValue = $(textInputObject).val().trim();
	console.log("new : " + newValue);
	$(textInputObject).val(newValue);
}

function trackInput(textInputObject) {
	
	if(oldValue != newValue ) {
		$(textInputObject).css("border","1px solid violet").css("width","100%");
		
		$.ajax({
			url : "<%=baseURL%>put-supplier",
			method : "post",
			data : {
				
				"sid" :  $(textInputObject).parent().parent().attr("id"),
				"colName" :   $(textInputObject).attr("col") ,
				"value" : newValue
				
			},
			success : function(responseData) {
				//var jsonData = $.parseJSON(responseData);
				//alert("dddd");
				if(responseData == "true") {
					$(textInputObject).css("border","1px solid #00ff00").css("width","100%");
				} else {
					$(textInputObject).css("border","1px solid violet").css("width","100%");
				}
				
			}
		
		});

	}
	
}


var tabIndex = 1;

function loadSuppliers() {
	paginationObject = new Paginator();
	console.log("Paginator initialized : " + paginationObject);
	paginationObject.getTotalRecords("<%=baseURL%>get-suppliers-count", function(responseData){
		console.log("this.totalRecords : responseData : " + responseData);
		paginationObject.setTotalRecords(responseData);
		paginationObject.calculateNumberOfPages(paginationObject.recordsPerPage, paginationObject.totalRecords);
		paginationObject.generatePaninationLinks(paginationObject.currentPage, function(activePage){
			var pageHTMLString = '';
			pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href= "#"  onclick ="javascript: paginationObject.gotoFirstPage();paginationObject.gotoPage(\'<%=baseURL%>get-suppliers\',paginationObject.startRecord, paginationObject.recordsPerPage, getSuppliers);return false;">First</a></li>' 
			pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href="#"  onclick ="javascript: paginationObject.loadPreviousPage();paginationObject.gotoPage(\'<%=baseURL%>get-suppliers\',paginationObject.startRecord, paginationObject.recordsPerPage, getSuppliers);return false;" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>';
			console.log("paginationObject.totalPages : : " + paginationObject.totalPages);
			for(i = 1; i <= paginationObject.totalPages;  i++) {
				pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == i )  ? 'active' : '' ) + ' " href="#" onclick = "paginationObject.gotoPage(\'<%=baseURL%>get-suppliers\'' + ', ' + ((i-1) * paginationObject.recordsPerPage ) +', ' + paginationObject.recordsPerPage + ', getSuppliers);paginationObject.setCurrentPage(' + i + ');return false;">'+ i +'</a></li>';
			}
			
			pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript: paginationObject.loadNextPage();paginationObject.gotoPage(\'<%=baseURL%>get-suppliers\',paginationObject.startRecord, paginationObject.recordsPerPage, getSuppliers);return false;" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>';
			pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript:paginationObject.gotoLastPage();paginationObject.gotoPage(\'<%=baseURL%>get-suppliers\',paginationObject.startRecord, paginationObject.recordsPerPage, getSuppliers);return false;" >Last</a></li>';

			$("#pagination-box").empty();
			$("#pagination-box").append(pageHTMLString);
			
			$(".page-item").click(function(){
				console.log("page link is clicked.");
				$(".new-record").remove();
				$('#btnNewSupplier').text("New");
				$("#btnSaveSuppliers").fadeOut();
				$("#btnCancelSuppliers").fadeOut(); 
			});
		});
		paginationObject.gotoPage('<%=baseURL%>get-suppliers', 0, paginationObject.recordsPerPage,getSuppliers);
			
	});
}

function  getSuppliers(recordsJSON){
	var jsonData = $.parseJSON(recordsJSON);
	var outStr = "";
	var rowCount = 1;
	
	$(jsonData).each(function(index,object){ // index
		outStr += '<div id ="'+object.sid+'" class = "row" style="background-color:' + ((rowCount % 2)?  '#eeedfe' : '#efe' ) + '">';
		outStr += '<div class = "col-sm-3" col = "sid" >'+object.sid+'</div>';
		outStr += '<div class = "col-sm-3   editable"  ><input col = "supplier_name" type ="text" id = "'+rowCount+'c'+1+'" tabindex = "'+ tabIndex +'" value = "'+object.name+'"/></div>';
		 tabIndex ++; 
		outStr += '<div class = "col-sm-3 editable pl-4"><input  col = "gst_number" type ="text" id = "'+rowCount+'c'+1+'"  tabindex = "'+ tabIndex +'" value = "'+object.gstno+'"/></div>';
		tabIndex ++; 
		outStr += '</div>';
		
		rowCount++;
	});
	
	$("#container-suppliers").empty();
	$("#container-suppliers").append(outStr);
	$("#container-suppliers").fadeIn(2000,function(){ console.log("done....")});
	
	
	
	$(".editable input").on("focus", function(){
		setOldValue(this);
	});
	
	
	$(".editable input").on("blur", function(){
		setNewValue(this);
		trackInput(this);
	});
	
}

function addNewSupplier() {
	
	var outStr = "";
	
	
		outStr += '<div  class = "row new-record">';
		outStr += '<div class = "col-sm-3" col = "sid" >*</div>';
		outStr += '<div class = "col-sm-3   editable"  ><input col = "supplier_name" type ="text"  tabindex = "'+ tabIndex +'" value = ""/></div>';
		 tabIndex ++; 
		outStr += '<div class = "col-sm-3 editable  pl-4" ><input col = "gst_number" type ="text" tabindex = "'+ tabIndex +'" value = ""/></div>';
		tabIndex ++; 
		outStr += '</div>';
		
		$("#container-suppliers").append(outStr);
		$(".new-record div input ").css("border","2px solid white").css("width","100%").css("padding","3px");
		$($(".new-record div input ")[0]).focus();
}

function saveSuppliers() {
	//$("#btnSaveSuppliers").attr("disabled","disabled");
	var inputJSON = "[";
	$(".new-record").each(function(index,newRecord){
		inputJSON += "{";
		$(newRecord).find("div.editable").each(function(i,column){
			inputJSON += "\"" + $(column).find("input").attr("col") + "\":\"" + $(column).find("input").val() + "\"" ;
			inputJSON += ",";
		});
		inputJSON = inputJSON.substring(0,(inputJSON.length-1));
		inputJSON += "}";
		inputJSON += ",";
	});
	inputJSON = inputJSON.substring(0,(inputJSON.length-1));
	inputJSON += "]";
	
	$.ajax({
		url : "<%=baseURL%>put-supplier",
		method : "post",
		data : {"rows": ""+inputJSON},
		success : function(responseData) {
			loadSuppliers();
			$("#btnSaveSuppliers").hide();
			//$("#msgBox").text("Saved....").fadeIn("1500",function(){});
			//window.location.reload();
			//console.log(responseData);
		}
	});
	console.log(inputJSON);
}


</script>

<%@ include file ="/includes/footer.jsp" %>
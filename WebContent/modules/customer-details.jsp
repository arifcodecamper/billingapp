<%@ include file ="/includes/header.jsp" %>
<div class = "container">
	<div class = "row  my-4">
			<div class = "col-sm-2">
				<h1> Customers </h1>
			</div>	
			<div class = "col-sm-4"> </div>
			<div class = "col-sm-6 ">
				<button class = "btn btn-primary btn-lg float-right ml-2" type = "button" id = "btnNewCustomer"> New</button>
				<button class = "btn btn-success btn-lg float-right ml-2" type = "button" id = "btnSaveCustomers" style = "display:none;"> Save</button>
				<button class = "btn btn-danger btn-lg float-right ml-2" type = "button" id = "btnCancelCustomers" style = "display:none;"> Cancel</button>
			</div>	
	</div>	
		<div class = "row">
			<div class = "col-sm-3">
				<h3> S.No </h3>
			</div>
			<div class = "col-sm-3">
				<h3> Customer Name </h3>
			</div>
			<div class = "col-sm-3">
				<h3> GST Number </h3>
			</div>	
		</div>	
	<div id="container-customer"  class = "table-data-container"></div>
	<div class = " py-3">
		<nav aria-label="Page navigation example" class = " pull-right">
		  <ul id = "pagination-box" class="pagination pagination-sm justify-content-end"> </ul>
		</nav>
	</div>
</div>

<script>
$(document).ready(function(){
		
		loadCustomers();
		
		$("#btnNewCustomer").on("click",function(){
			 $("#btnSaveCustomers").fadeIn(200,function(){ 
				 console.log("save btn appeared....");
				 $("#btnCancelCustomers").fadeIn(200,function(){ 
					 console.log("cancel btn appeared....");
					 addNewCustomer();
					 $("#container-customer").animate({ scrollTop: $("#container-customer").get(0).scrollHeight}, 2000); 
					 
				 });
			 });
			 $(this).text("Add more");
		});
		
		$("#btnCancelCustomers").on("click",function(){
			$("#btnCancelCustomers").fadeOut(200,function(){ 
				console.log("cancel btn disappeared....");
				$("#btnSaveCustomers").fadeOut(200,function(){ 
					console.log("save btn disappeared....");
					$(".new-record").remove();
					 $('#btnNewCustomer').text("New");
					 $("#container-customer").animate({ scrollTop: $("#container-customer").get(0)}, 2000);
				}); 
			}); 
		});
		
		$("#btnSaveCustomers").on("click",function(){
			$("#btnCancelCustomers").fadeIn(200,function(){
				$('#btnNewCustomer').text("New");
				saveCustomers();
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
					url : "<%=baseURL%>put-customer",
					method : "post",
					data : {
						
						"cid" :  $(textInputObject).parent().parent().attr("id"),
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
		
		function loadCustomers() {
			paginationObject = new Paginator();
			console.log("Paginator initialized : " + paginationObject);
			paginationObject.getTotalRecords("<%=baseURL%>get-customers-count", function(responseData){
				console.log("this.totalRecords : responseData : " + responseData);
				paginationObject.setTotalRecords(responseData);
				paginationObject.calculateNumberOfPages(paginationObject.recordsPerPage, paginationObject.totalRecords);
				paginationObject.generatePaninationLinks(paginationObject.currentPage, function(activePage){
					var pageHTMLString = '';
					pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href= "#"  onclick ="javascript: paginationObject.gotoFirstPage();paginationObject.gotoPage(\'<%=baseURL%>get-customers\',paginationObject.startRecord, paginationObject.recordsPerPage, getCustomers);return false;">First</a></li>' 
					pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href="#"  onclick ="javascript: paginationObject.loadPreviousPage();paginationObject.gotoPage(\'<%=baseURL%>get-customers\',paginationObject.startRecord, paginationObject.recordsPerPage, getCustomers);return false;" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>';
					console.log("paginationObject.totalPages : : " + paginationObject.totalPages);
					for(i = 1; i <= paginationObject.totalPages;  i++) {
						pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == i )  ? 'active' : '' ) + ' " href="#" onclick = "paginationObject.gotoPage(\'<%=baseURL%>get-customers\'' + ', ' + ((i-1) * paginationObject.recordsPerPage ) +', ' + paginationObject.recordsPerPage + ', getCustomers);paginationObject.setCurrentPage(' + i + ');return false;">'+ i +'</a></li>';
					}
					
					pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript: paginationObject.loadNextPage();paginationObject.gotoPage(\'<%=baseURL%>get-customers\',paginationObject.startRecord, paginationObject.recordsPerPage, getCustomers);return false;" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>';
					pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript:paginationObject.gotoLastPage();paginationObject.gotoPage(\'<%=baseURL%>get-customers\',paginationObject.startRecord, paginationObject.recordsPerPage, getCustomers);return false;" >Last</a></li>';

					$("#pagination-box").empty();
					$("#pagination-box").append(pageHTMLString);
					
					$(".page-item").click(function(){
						console.log("page link is clicked.");
						$(".new-record").remove();
						$('#btnNewCustomer').text("New");
						$("#btnCancelCustomers").fadeOut();
						$("#btnSaveCustomers").fadeOut(); 
					});
					
				});
				paginationObject.gotoPage('<%=baseURL%>get-customers', 0, paginationObject.recordsPerPage,getCustomers);
					
			});
		}
		
		function  getCustomers(recordsJSON){
			
			var jsonData = $.parseJSON(recordsJSON);
			var outStr = "";
			var rowCount = 1;
			
			$(jsonData).each(function(index,object){ // index
				outStr += '<div id ="'+object.cid+'" class = "row" style="background-color:' + ((rowCount % 2)?  '#eeedfe' : '#efe' ) + '">';
				outStr += '<div class = "col-sm-3" col = "customer_id" >'+object.cid+'</div>';
				outStr += '<div class = "col-sm-3   editable"  ><input col = "customer_name" type ="text" id = "'+rowCount+'c'+1+'" tabindex = "'+ tabIndex +'" value = "'+object.name+'"/></div>';
				 tabIndex ++; 
				outStr += '<div class = "col-sm-3 editable  pl-4"><input  col = "gst_number" type ="text" id = "'+rowCount+'c'+1+'"  tabindex = "'+ tabIndex +'" value = "'+object.gstno+'"/></div>';
				tabIndex ++; 
				outStr += '</div>';
				
				rowCount++;
			});
			
			$("#container-customer").empty();
			$("#container-customer").append(outStr);
			$("#container-customer").fadeIn(2000,function(){ console.log("done....")});
			
			$(".editable input").on("focus", function(){
				setOldValue(this);
			});
			
			$(".editable input").on("blur", function(){
				setNewValue(this);
				trackInput(this);
			});
		}
		
		function addNewCustomer() {
			
			var outStr = "";
				outStr += '<div  class = "row new-record">';
				outStr += '<div class = "col-sm-3" col = "customer_id" >*</div>';
				outStr += '<div class = "col-sm-3   editable"  ><input col = "customer_name" type ="text"  tabindex = "'+ tabIndex +'" value = ""/></div>';
				 tabIndex ++; 
				outStr += '<div class = "col-sm-3 editable  pl-4" ><input col = "gst_number" type ="text" tabindex = "'+ tabIndex +'" value = ""/></div>';
				tabIndex ++; 
				outStr += '</div>';
				$("#container-customer").append(outStr);
				$(".new-record div input ").css("border","2px solid white").css("width","100%").css("padding","3px");
				$($(".new-record div input ")[0]).focus();
		}
		
		
		
		function saveCustomers() {
			$("#btnSaveCustomers").hide();
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
				url : "<%=baseURL%>put-customer",
				method : "post",
				data : {"rows": ""+inputJSON},
				success : function(responseData) {
					window.location.reload();
					console.log(responseData);
				}
			});
			console.log(inputJSON);
		}
		
</script>


<%@ include file ="/includes/footer.jsp" %>
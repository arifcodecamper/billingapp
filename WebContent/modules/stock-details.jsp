<%@ include file ="/includes/header.jsp" %>

<div class = "container">
	
		<div class = "row  my-4">
			<div class = "col-sm-2">
			<h1> Stock </h1>
			</div>	
			<div class = "col-sm-4"> </div>
			<div class = "col-sm-6 ">
				<button class = "btn btn-primary btn-lg float-right ml-2" type = "button" id = "btnNewStock"> New</button>
				<button class = "btn btn-success btn-lg float-right ml-2" type = "button" id = "btnSaveStocks" style = "display:none;"> Save</button>
				<button class = "btn btn-danger btn-lg float-right ml-2" type = "button" id = "btnCancelStock" style = "display:none;"> Cancel</button>
			</div>	
		</div>	
		
		<div class = "row">
			<div class = "col-sm-12">
				<table class="table table-sm">
				  <thead>
				    <tr>
				      <th>#</th>
				      <th>Product</th>
				      <th>HSN&nbsp;Code  </th>
				      <th>Price</th>
				      <th>Quantity</th>
				      <th>GST %</th>
				      <th>Date</th>
				      <th>Supplier</th>
				    </tr>
				  </thead>
				  <tbody id="container-stock" class = "table-data-container"></tbody>
				</table>
			</div>	
		</div>	
		
	<div class = " py-3">
		<nav aria-label="Page navigation example" class = " pull-right">
		  <ul id = "pagination-box" class="pagination pagination-sm justify-content-end"> </ul>
		</nav>
	</div>
</div>

<script>

$(document).ready(function(){
	loadStock();
	
	$("#btnNewStock").on("click",function(){
		 $("#btnSaveStocks").fadeIn(1000,function(){ 
			 console.log("save btn appeared....");
			 $("#btnCancelStock").fadeIn(200,function(){ 
				 console.log("cancel btn appeared....");
				 addNewStock();
				 $("#container-stock").animate({ scrollTop: $("#container-stock").get(0).scrollHeight}, 2000);
			 });
		 });
		 $(this).text("Add more");
	});
	
	$("#btnCancelStock").on("click",function(){
		$("#btnCancelStock").fadeOut(200,function(){ 
			console.log("cancel btn disappeared....");
			$("#btnSaveStocks").fadeOut(200,function(){ 
				console.log("save btn disappeared....");
				$(".new-record").remove();
				 $('#btnNewStock').text("New");
				 $("#container-stock").animate({ scrollTop: $("#container-stock").get(0)}, 2000);
			}); 
		}); 
	});
	
	
	$("#btnSaveStocks").on("click",function(){
		$("#btnCancelStock").fadeIn(200,function(){
			$('#btnNewStock').text("New");
			saveStocks();
		});
	});
	
});

var tabIndex = 1;

function loadStock() {
	var getPageURL = jsVarbaseURL + '/get-stocks';
	var getRecordCountURL = '<%=baseURL%>get-stocks-count';
	paginationObject = new Paginator();
	console.log("Paginator initialized : " + paginationObject);
	paginationObject.getTotalRecords(getRecordCountURL,  function(responseData){
		console.log("this.totalRecords : responseData : " + responseData);
		paginationObject.setTotalRecords(responseData);
		paginationObject.calculateNumberOfPages(paginationObject.recordsPerPage, paginationObject.totalRecords);
		
		if( paginationObject.totalPages > 1) {
			paginationObject.generatePaninationLinks(paginationObject.currentPage, function(activePage){
				var pageHTMLString = '';
				pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href= "#"  onclick ="javascript: paginationObject.gotoFirstPage();paginationObject.gotoPage('+ "'/sofiya-agencies/get-stocks'" + ',paginationObject.startRecord, paginationObject.recordsPerPage, getStock);return false;">First</a></li>' 
				pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == 1 )  ? 'disable' : '' ) + ' " href="#"  onclick ="javascript: paginationObject.loadPreviousPage();paginationObject.gotoPage('+ "'/sofiya-agencies/get-stocks'" + ',paginationObject.startRecord, paginationObject.recordsPerPage, getStock);return false;" aria-label="Previous"><span aria-hidden="true">&laquo;</span><span class="sr-only">Previous</span></a></li>';
				console.log("paginationObject.totalPages : : " + paginationObject.totalPages);
				for(i = 1; i <= paginationObject.totalPages;  i++) {
					pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == i )  ? 'active' : '' ) + ' " href="#" onclick = "paginationObject.gotoPage('+ "'/sofiya-agencies/get-stocks'"  + ', ' + ((i-1) * paginationObject.recordsPerPage ) +', ' + paginationObject.recordsPerPage + ', getStock);paginationObject.setCurrentPage(' + i + ');return false;">'+ i +'</a></li>';
				}
				
				pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript: paginationObject.loadNextPage();paginationObject.gotoPage('+ "'/sofiya-agencies/get-stocks'" + ',paginationObject.startRecord, paginationObject.recordsPerPage, getStock);return false;" aria-label="Next"><span aria-hidden="true">&raquo;</span><span class="sr-only">Next</span></a></li>';
				pageHTMLString += '<li class="page-item"><a class="page-link ' + (( activePage == paginationObject.totalPages )  ? 'disable' : '' ) + ' " href="#" onclick = "javascript:paginationObject.gotoLastPage();paginationObject.gotoPage('+ "'/sofiya-agencies/get-stocks'" + ',paginationObject.startRecord, paginationObject.recordsPerPage, getStock);return false;" >Last</a></li>';
	
				$("#pagination-box").empty();
				$("#pagination-box").append(pageHTMLString);
			});
		}
		paginationObject.gotoPage(getPageURL, 0, paginationObject.recordsPerPage, getStock);
			
	});
	
}

function convertIntlToIndian(dateValue) {
	var dateObj = new Date(dateValue);
	var month = dateObj.getMonth() + 1;
	return dateObj.getDate() + "-" + ( (month < 10 ) ? '0' + month : month) + "-" + dateObj.getFullYear();
}

function convertIndianToIntl(dateValue) {
	var day = dateValue.substring(0,2);
	var month = dateValue.substring(3,5);
	var year = dateValue.substring(6,10);
	
	return year + "-" + month + "-" + day;
	
}

function getStock(recordsJSON) {
	var jsonData =  $.parseJSON(recordsJSON);

	
	var rowCount = 1;
	var  outStr = '';
	$(jsonData).each(function(index,jsonObject){ // index
		outStr += '<tr title = "'+ jsonObject.product.desc +'" style="background-color:' + ((rowCount % 2)?  '#eeedfe' : '#efe' ) + '">';


		outStr += '<th  scope="row" col = "stock_entry_id" >' + jsonObject.stock.sno + '</th>';

		//outStr += '<td> <input col = "product_name" 	type ="text" cat = "pr" rid = "'+  jsonObject.product.prno + '" tabindex = "'+ tabIndex +'" value = "' + jsonObject.product.name + '"/></td>';
		outStr += '<td>' + jsonObject.product.name + '</td>';
		//tabIndex ++; 
		//outStr += '<td class = "editable" > <input col = "hsn_code" 		type ="text" cat = "pr" rid = "'+  jsonObject.product.prno   + '" tabindex = "'+ tabIndex +'" value = "' + jsonObject.product.hsncode + '"/></td>';
		outStr += '<td>' + jsonObject.product.hsncode + '</td>';
		//tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "product_price" 	type ="text" cat = "st" rid = "'+  jsonObject.stock.sno   + '" tabindex = "'+ tabIndex +'" value = "' + jsonObject.stock.price + '"/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "quantity" 		type ="text" cat = "st" rid = "'+  jsonObject.stock.sno   + '" tabindex = "'+ tabIndex +'" value = "' + jsonObject.stock.quantity + '"/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "gst_percentage" 	type ="text" cat = "st" rid = "'+  jsonObject.stock.sno  + '" tabindex = "'+ tabIndex +'" value = "' + jsonObject.stock.gst + '"/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "date_of_purchase" type ="text" cat = "st" rid = "'+  jsonObject.stock.sno  + '" tabindex = "'+ tabIndex +'" value = "' + convertIntlToIndian(jsonObject.stock.date) + '"/></td>';
		tabIndex ++; 
		/* outStr += '<td class = "editable" > <input col = "supplier_name" 	type ="text" cat = "sp" rid = "' + jsonObject.supplier.supno +'" tabindex = "'+ tabIndex +'" value = "' + jsonObject.supplier.name + '"/></td>'; */
		outStr += '<td> ' + jsonObject.supplier.name + '</td>';

		outStr += '</tr>';
	
	rowCount++;
	});
	
	$("#container-stock").empty();
	$("#container-stock").append(outStr);
	$("#container-stock").fadeIn(2000,function(){ console.log("done....")});
	
	 $(".editable input").on("focus", function(){
		setOldValue(this);
	});
	
	
	$(".editable input").on("blur", function(){
		setNewValue(this);
		trackInput(this);
	}); 
	
	
	$('.editable input[COL=date_of_purchase]').datepicker({
		autoclose : true,
		keyboardNavigation : true,
		format : "dd-mm-yyyy"
	});
	
}

function addNewStock() {
	var  outStr = '';
	
	 outStr += '<tr class ="new-record">';


		outStr += '<th  scope="row"> * </th>';

		outStr += '<td class = "editable" > <input col = "product_name"		type ="text" cat = "pr" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "hsn_code" 		type ="text" cat = "pr" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		
		outStr += '<td class = "editable" > <input col = "product_price" 	type ="text" cat = "st" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "quantity" 		type ="text" cat = "st" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "gst_percentage" 	type ="text" cat = "st" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "date_of_purchase" type ="text" cat = "st" tabindex = "'+ tabIndex +'" value = ""/></td>';
		tabIndex ++; 
		outStr += '<td class = "editable" > <input col = "supplier_name" 	type ="text" cat = "sp" tabindex = "'+ tabIndex +'" value = ""/></td>';
		
		outStr += '</tr>';
	
		$("#container-stock").append(outStr);
		$(".new-record td input ").css("border","2px solid white").css("width","100%").css("padding","3px");
		//$($(".new-record td input ")[0]).focus();
		
		$(".new-record td input[COL=product_name]").autocomplete({
        	bootstrapVersion: 4,
            minChars: 0,
            timeout: 1000,
            maxHeight: 40,
            normalizeQuery: true,
            choose: function(input, item) {
            	  console.log($(item).data());
            },
    	  	request: {
    		  url: jsVarbaseURL+'auto-complete-product?dataField=product_name' 
    	    }
    	});
		
		$(".new-record td input[COL=hsn_code]").autocomplete({
        	bootstrapVersion: 4,
            minChars: 0,
            timeout: 1000,
            maxHeight: 40,
            normalizeQuery: true,
            choose: function(input, item) {
            	  console.log($(item).data());
            },
    	  	request: {
    		  url: jsVarbaseURL+'auto-complete-product?dataField=hsn_code' 
    	    }
    	});
		
		
		$(".new-record td input[COL=supplier_name]").autocomplete({
        	bootstrapVersion: 4,
            minChars: 0,
            timeout: 1000,
            maxHeight: 40,
            normalizeQuery: true,
            choose: function(input, item) {
            	  console.log($(item).data());
            },
    	  	request: {
    		  url: jsVarbaseURL+'auto-complete-supplier?dataField=supplier_name' 
    	    }
    	});
		
		
		/* 
			Date picker site URL : https://vitalets.github.io/bootstrap-datepicker/#
		*/
		
		$('.new-record td input[COL=date_of_purchase]').datepicker({
			autoclose : true,
			keyboardNavigation : true,
			format : "dd-mm-yyyy"
		});
		
		//$(".new-record td input ")
		
		
		//$(".new-record td input ")
	
}

function saveStocks() {
	$("#btnSaveStocks").hide();
	var inputJSON = "[";
	$(".new-record").each(function(index,newRecord){
		inputJSON += "[";
		$(newRecord).find("td.editable")
		.each(function(i,column){
			inputJSON += (i == 0)? "{" : "";
			inputJSON += (i == 2)? "{" : "";
			inputJSON += (i == 6)? "{" : "";
			if(i == 5) {
				inputJSON += "\"" + $(column).find("input").attr("col") + "\":\"" + convertIndianToIntl($(column).find("input").val()) + "\"," ;
				
			}else {
				inputJSON += "\"" + $(column).find("input").attr("col") + "\":\"" + $(column).find("input").val() + "\"," ;				
			}
			if(i == 1 || i == 5 || i == 6){
				inputJSON = inputJSON.substring(0,(inputJSON.length-1));
			}
			inputJSON += (i == 1)? "}," : "";
			inputJSON += (i == 5)? "}," : "";
			inputJSON += (i == 6)? "}," : "";
		});
		inputJSON = inputJSON.substring(0,(inputJSON.length-1));
		inputJSON += "]";
		inputJSON += ",";
	});
	inputJSON = inputJSON.substring(0,(inputJSON.length-1));
	inputJSON += "]";
	
	$.ajax({
		url : "<%=baseURL%>put-stock",
		method : "post",
		data : {"rows": ""+inputJSON},
		success : function(responseData) {
			window.location.reload();
			console.log(responseData);
		}
	});
	console.log(inputJSON);
}

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
		console.log({
			
			"cat"  : $(textInputObject).attr("cat"),
			"rid" :  $(textInputObject).attr("rid"),
			"colName" :   $(textInputObject).attr("col") ,
			"value" : newValue
			
		});
		$.ajax({
			url : "<%=baseURL%>put-stock",
			method : "post",
			type: "text",
			data : {
				
				"cat"  : $(textInputObject).attr("cat"),
				"rid" :  $(textInputObject).attr("rid"),
				"colName" :   $(textInputObject).attr("col") ,
				"value" : (($(textInputObject).attr("col") == 'date_of_purchase')? convertIndianToIntl(newValue) : newValue)
				
			},
			success : function(responseData) {
				//var jsonData = $.parseJSON(responseData);
				//alert("dddd");
				if(responseData == "true") {
					$(textInputObject).css("border","1px solid #00ff00").css("width","100%");
				} else {
					$(textInputObject).css("border","1px solid violet").css("width","100%");
				}
				
				setTimeout(function(){
					//alert("heeeeyyy !!!");
					 $(textInputObject).css("border-style","none")
					.css("outline","0px none #000")
					.css("background-color","inherit"); 
				}, 3000 ); 
			}
		
		}); 

	}
	
}


</script>


<%@ include file ="/includes/footer.jsp" %>
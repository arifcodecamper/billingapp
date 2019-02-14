
<%@ include file ="/includes/header.jsp" %>



<div class = "container">

<h1> </h1> 
	<div class = "row  my-4">
			<div class = "col-sm-4">
			<h1> New Invoice Entry </h1>
			</div>	
			<div class = "col-sm-6"> </div>
			<div class = "col-sm-2 ">
				<button class = "btn btn-primary btn-lg float-right ml-2" type = "button" id = "btnPrint">Print</button>
				<!-- <button class = "btn btn-success btn-lg float-right ml-2" type = "button" id = "btnSaveStocks" style = "display:none;"> Save</button>
				<button class = "btn btn-danger btn-lg float-right ml-2" type = "button" id = "btnCancelStock" style = "display:none;"> Cancel</button> -->
			</div>	
		</div>	

	<div class = "row">
		<div class ="col-sm-6">
			<div class = "row">
				<div class = "col-sm-12"><h4><b>SOFIA AGENCIES</b></h4></div>
			</div>
			<div class = "row">
				<div class = "col-sm-12"><address>20/16, Bangalow Street, Pudupet, VRIDDHACHALAM 606001</address></div>
			</div>
			<div class = "row">
				<div class = "col-sm-3"><b>Name&nbsp;of&nbsp;Buyer:</b></div>
				<div class = "col-sm-9"><input class = "input-text-plain" type = "text" id = "buyerNameTxt" value = "" tabindex = "1" /></div>
			</div>
			<div class = "row">
				<div class = "col-sm-3"><b>Address:</b> </div>
				<div class = "col-sm-9"><textarea id = "customerAddressTxt" class = "input-text-plain" tabindex = "2"></textarea></div>
			</div>
		
			<div class = "row">
				<div class = "col-sm-3"><b>GSTIN: </b></div>
				<div class = "col-sm-9"><input id = "customerGSTINTxt" class = "input-text-plain" type = "text" tabindex = "3"/></div>
			</div>
		</div>
		<div class ="col-sm-6" >
		<div class = "row">
			<div class = "col-sm-6"><b>Mobile: 9003471531</b> </div>
			<div class = "col-sm-6"><b>Email: sofiaagencies@gmail.com</b></div>
		</div>
		<div class = "row">
			<div class = "col-sm-6"><b>State&nbsp;Code: 033</b></div>
			<div class = "col-sm-6"><b>GSTIN:&nbsp;33CEQPM6103J2ZC</b></div>
		</div>
		
		<div class = "row">
			<div class = "col-sm-3"><b>Tax&nbsp;Invoice&nbsp;No:</b></div>
			<div class = "col-sm-3"> <input disabled="disabled" class = "input-text-plain" type = "text" id = "invoiceNumberTxt" value = ""/></div>
			<div class = "col-sm-1"><b>Date:</b></div>
			<div class = "col-sm-5"> <input class = "input-text-plain" type = "text" id = "invoiceDateTxt" value = "" tabindex = "4"/></div>
		</div>
		
		<div class = "row">
			<div class = "col-sm-3"><b>Delivery:</b></div>
			<div class = "col-sm-9"><input class = "input-text-plain" type = "text" id = "deliveryTxt" value = "" tabindex = "5"/></div>
		</div>
		<div class = "row">
			<div class = "col-sm-3"><b>Payment&nbsp;terms:</b></div>
			<div class = "col-sm-9"><input class = "input-text-plain" type = "text" id = "paymentTermsTxt" value = "" tabindex = "6"/></div>
		</div>
		
		<div class = "row">
			<div class = "col-sm-6"> </div>
			<div class = "col-sm-6"> </div>
		</div>
		
		</div>
	</div>
	<div class = "row">
	<div class = "col-sm-12">
		<table class="table table-sm mt-2">
		  <thead>
		    <tr>
		      <th>S.No</th>
		      <th class ="not-this" >Description of Goods</th>
		      <th>HSN</th>
		      <th>Quantity</th>
		      <th>Rate</th>
		      <th>GST</th>
		      <th>Total</th>
		    </tr>
		  </thead>
		  <tbody id = "invoiceEntriesContainer">
		  	<tr id = "rowWithTax">
		      <th scope="row" colspan="6" >Total 12% GST <br/> Total 18% GST <br/> Total  28% GST</th>
		      <td>
		      	<span id = "gst12">0.0</span><br/>
		      	<span id = "gst18">0.0</span><br/>
		      	<span id = "gst28">0.0</span>
		      	</td>
		    </tr>
		    
		    <tr id = "rowWithTotal">
		      <th scope="row" colspan="6" >Grand Total</th>
		      <td id = "grandTotal">0.0</td>
		    </tr>
		  </tbody>
		</table>
		</div>
	</div>
</div>
<script type="text/javascript">
var tabIndex = 7;
var sno = 1;
var current_prod = "";
var current_prod_quantity = 0;

//----------------------------------

var taxes = {};
taxes.gst12 = 0.0;
taxes.gst18 = 0.0;
taxes.gst28 = 0.0;

var grandTotal = 0.0;


var invoiceEnteries = [];
	var invoiceEntry = {};
	
	invoiceEntry.rowID = 0;
	invoiceEntry.productName = "";
	invoiceEntry.hsn = "";
	invoiceEntry.quantity = 0;
	invoiceEntry.rate = 0.0;
	invoiceEntry.gst = 0;
	invoiceEntry.tax = 0.0;
	invoiceEntry.subtotal = 0.0;
	invoiceEntry.total = 0.0;
	
	//invoiceEnteries.push(invoiceEntry);
	
	console.log(invoiceEnteries);


//---------------------------------
$(document).ready(function(){
	
	
	$("#buyerNameTxt").autocomplete({
    	bootstrapVersion: 4,
        minChars: 0,
        timeout: 1000,
        maxHeight: 70,
        normalizeQuery: true,
        choose: function(input, item) {
        	  console.log($(item).data());
        	  console.log("You have chosen the customer.");
        	  addInvoiceEntry();
        },
	  	request: {
		  url: jsVarbaseURL+'auto-complete-customer?dataField=customer_name' 
	    }
	});
	
	$('#invoiceDateTxt').datepicker({
		autoclose : true,
		keyboardNavigation : true,
		format : "dd-mm-yyyy"
	});
	
	$("#buyerNameTxt").on("blur", function(){
		if($(this).val() != "") {
			getCustomerAddress($(this).val());
			getCustomerGSTIN($(this).val());
		}
	});
	
	function getCustomerAddress(customerName) {
		$.ajax({
			url : "<%=baseURL%>get-customer-data",
			method : "POST",
			type : "text",
			data : { 
				value : customerName,
				field : "customer_name",
				required : "address"
			},
			success : function(response){
				$("#customerAddressTxt").text(response);
			}
			
		});
	}

	function getCustomerGSTIN(customerName) {
		$.ajax({
			url : "<%=baseURL%>get-customer-data",
			method : "POST",
			type : "text",
			data : { 
				value : customerName,
				field : "customer_name",
				required : "gst_number"
			},
			success : function(response){
				$("#customerGSTINTxt").val(response); 
				$("#invoiceDateTxt").focus();
			}
			
		});
	}

	function addInvoiceEntry() {
		var  outStr = '';
		
		 outStr += '<tr class ="new-record">';
			outStr += '<th  scope="row"> ' + sno + ' </th>';
			outStr += '<td class = "editable not-this" ><input class = "invoice" col = "product_name"	type ="text" tabindex = "'+ tabIndex +'" value = ""/></td>';
			tabIndex ++; 
			outStr += '<td col = "hsn_code" ></td>';
			outStr += '<td class = "editable" ><input class = "invoice" col = "quantity" type ="text" tabindex = "'+ tabIndex +'" value = ""/></td>';
			tabIndex ++;
			outStr += '<td col = "product_price" ></td>';
			outStr += '<td col = "gst_percentage" ></td>';
			outStr += '<td col = "total" ></td>';
			outStr += '</tr>';
			
			$(outStr).insertBefore("#rowWithTax");
			
			$(".new-record td input ").css("border","2px solid white").css("width","100%").css("padding","3px");
			
			$(".new-record td input[COL=product_name]").autocomplete({
	        	bootstrapVersion: 4,
	            minChars: 0,
	            timeout: 1000,
	            maxHeight: 40,
	            normalizeQuery: true,
	            /* choose: function(input, item) {
	            	console.log($(".new-record td input[col=quantity]")[(sno -1)]);
	            	$($(".new-record td input[col=quantity]")[(sno -2)]).focus();
	            }, */ 
	    	  	request: {
	    		  url: jsVarbaseURL+'auto-complete-product?dataField=product_name' 
	    	    }
	    	});
			
			sno++;
			
			$("input[col=quantity]").on("keyup", function(event){
				if(event.keyCode === 13){
					console.log("You have hit enter key.");
					
					current_prod_quantity = parseInt($(this).val());
					invoiceEntry.quantity = current_prod_quantity;
					console.log("cur prod qty: " + current_prod_quantity);
					
					if(current_prod_quantity != 0 && current_prod !== "" ){
						
						populateInvoiceEntryData(current_prod,current_prod_quantity);
						setTimeout(function() {if($("#isStock").val() == "false") {
							$($("input[col=product_name]")[(sno -2)]).focus(); // It retains the current prod value in the cuttent_prod variable.
							$($("input[col=quantity]")[(sno -2)]).val("");
							$($("input[col=quantity]")[(sno -2)]).focus();
						}else {
							$($("td[col=hsn_code]")[(sno -2)]).text(invoiceEntry.hsn);
							$($("td[col=product_price]")[(sno -2)]).text(invoiceEntry.rate);
							$($("td[col=gst_percentage]")[(sno -2)]).text(invoiceEntry.gst);
							$($("td[col=total]")[(sno -2)]).text(invoiceEntry.subtotal);
							
							$("#gst12").text(taxes.gst12);
							$("#gst18").text(taxes.gst18);
							$("#gst28").text(taxes.gst28);
							
							$("#grandTotal").text(( taxes.gst12 +  taxes.gst18 +  taxes.gst28) + grandTotal );
							
							
							addInvoiceEntry();
							$($("input[col=product_name]")[(sno -2)]).focus();
						}},1000);
						
					} else {
						current_prod = "";
						current_prod_quantity = 0;
					}
					
				}
			});
			
			$("input[col=product_name]").on("blur", function(event){
				 
				current_prod =$(this).val();
				invoiceEntry.productName = current_prod;
				console.log("cur prod: " + current_prod);
				
			});
	}

	
	function addUpTaxes(invoiceNewEntry){
		 if(invoiceNewEntry.gst == 12 ) {
			 taxes.gst12 += invoiceNewEntry.tax;
		 } else if ( invoiceNewEntry.gst == 18  ) {
			 taxes.gst18 += invoiceNewEntry.tax;
		 } else if ( invoiceNewEntry.gst == 28 ) {
			 taxes.gst28 += invoiceNewEntry.tax;
		 }
	}
	
	function calculateGrandTotal(invoiceNewEntryTotal) {
		grandTotal += invoiceNewEntryTotal;
	}


	function populateInvoiceEntryData(productName,requiredQuantity) {
		$.ajax({
			url: "<%=baseURL%>get-invoice-entry",
			method: "GET",
			data: {
				product : productName,
				quantity: requiredQuantity
			},
			success: function(response){
				if(response === "") {
					$("#isStock").val("false");
				 	console.log("There is no sufficient stock for this product.");
				 	
				}else {
					$("#isStock").val("true");
					jsonObj = $.parseJSON(response);
					// {"id":"5","hsn":"HSN010","rate":"80.0","gst":"28","total":"5734.4"}
					
					invoiceEntry.rowID = jsonObj.id;
					invoiceEntry.hsn   = jsonObj.hsn;
					invoiceEntry.rate  =  parseFloat(jsonObj.rate);
					invoiceEntry.gst   =  parseInt(jsonObj.gst);
					invoiceEntry.tax   =  parseFloat(jsonObj.tax);
					invoiceEntry.subtotal =  parseFloat(jsonObj.subtotal);
					invoiceEntry.total =  parseFloat(jsonObj.total);
					
					console.log("New Object : " + invoiceEntry);
					
					addUpTaxes(invoiceEntry);
					calculateGrandTotal(invoiceEntry.subtotal);
				}
				
			}
		});
	}
	
});





</script>

<input type = "hidden" id = "isStock" value = "true"/>
<%@ include file ="/includes/footer.jsp" %>
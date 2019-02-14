
/*
 * This is javascript plugin for this web application and is enables the pagination feature. Each page may have an instance of the Paginator class.
 * This is very simple version of pagination.
 * Version 1.0-alpha-1
 */

var Paginator  = function()  {
		
	this.recordsPerPage = 10;
	this.totalRecords   = 0;
	this.totalPages = 0;
	this.currentPage = 1;
	this.startRecord = 10;
	this.previousPage = this.currentPage - 1; // By default its zero no page exists before first page.
	this.nextPage = this.currentPage + 1;
	
	// Function's definitions
	
	this.getTotalRecords =  function(url, loadPagesCallback){
		$.ajax({
			url : url,
			method: 'get',
			success : function(response) {
				console.log("this.totalPages 111 : response : " + response);
				loadPagesCallback(response);
			}
		});
	};
	
	this.setCurrentPage =  function(pageNumber){
		this.currentPage = pageNumber;
	};
	
	this.setTotalRecords =  function(noOfRecords){
		this.totalRecords = noOfRecords;
		console.log("this.totalPages 111 : : " + this.totalRecords);
	};
	
	this.calculateNumberOfPages =  function(countsPerPage, totalRecordCount){
		this.totalPages = Math.floor(totalRecordCount/countsPerPage) +( ( totalRecordCount % countsPerPage ) > 0 ? 1 : 0 ) ;
	};
	
	this.gotoFirstPage =  function(){
		this.startRecord =  0;
	};
	
	this.gotoLastPage =  function(url){
		this.startRecord = (this.totalPages - 1 ) * this.recordsPerPage;
	};
	
	this.loadPreviousPage =  function(url){
		this.previousPage = this.currentPage - 1;
		if( this.previousPage >= 1) {
			this.currentPage = this.previousPage;
			this.startRecord =  this.recordsPerPage * (this.currentPage-1);
		}
	};
	
	this.loadNextPage =  function(url){
		this.startRecord =  this.recordsPerPage * this.currentPage;
		this.nextPage = this.currentPage + 1;
		if( this.nextPage <= this.totalPages) {
			this.currentPage = this.nextPage;
			
		}	
	};
	
	this.generatePaninationLinks = function(startPage,linksCallback) {
		
		linksCallback(startPage);
		
	};
	
	this.gotoPage = function(serviceURL, offset, limit, getDataCallBack) {
		$.ajax({
			url: serviceURL  + '?offset=' + offset + '&limit=' + limit,
			method: 'get',
			success : function(responseData) {
				getDataCallBack(responseData);
			}
		});
	};
	
};


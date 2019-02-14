package com.sofiyaagencies.servlets;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsoniter.JsonIterator;
import com.jsoniter.any.Any;
import com.sofiyaagencies.dao.ProductDAOImpl;
import com.sofiyaagencies.dao.StockDAOImpl;
import com.sofiyaagencies.dao.SupplierDAOImpl;

/**
 * Servlet implementation class PutStock
 */
@WebServlet("/put-stock")
public class PutStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PutStock() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String responseToClientBrowser = "";
		
		/* Getting Params for the instant update */
		String cat 		= request.getParameter("cat");
		int rid 		= (request.getParameter("rid") != null ) ? Integer.parseInt(request.getParameter("rid")) : 0;
		String colName 	= request.getParameter("colName");
		String value 	= request.getParameter("value");
		
		ProductDAOImpl product = new ProductDAOImpl();
		SupplierDAOImpl supplier = new SupplierDAOImpl();
		StockDAOImpl stock = new StockDAOImpl();
		
		String input = request.getParameter("rows");
		if(input != null) {
			System.out.println("Incoming JSON data total records : " + JsonIterator.deserialize(input).size());
			//System.out.println(JsonIterator.deserialize(input).get(0).asList().get(0));
			
			for(int i = 0 ; i < JsonIterator.deserialize(input).size(); i++ ) {
				System.out.println(JsonIterator.deserialize(input).get(i));
				
				Map<String,Any> mapProd = JsonIterator.deserialize(input).get(i).asList().get(0).asMap();
				product.add(mapProd);
				
				System.out.println( mapProd.get("product_name").toString());
				
				int prodID = product.getProductID("product_name", mapProd.get("product_name").toString());
				System.out.println("product id is " + prodID);
				
				Map<String,Any> mapSupp = JsonIterator.deserialize(input).get(i).asList().get(2).asMap();
				supplier.add(mapSupp);
				
				System.out.println( mapSupp.get("supplier_name").toString());
				int supID =  supplier.getSupplierID("supplier_name", mapSupp.get("supplier_name").toString() );
				System.out.println("Supplier id is " + supID);
				
				
				Map<String,Any> mapStock = JsonIterator.deserialize(input).get(i).asList().get(1).asMap();
				mapStock.put("product_product_id",Any.wrap(prodID));
				mapStock.put("supplier_supplier_id", Any.wrap(supID));
				
				
				stock.add(mapStock);
			}
			/*Map<String, Any> map = JsonIterator.deserialize(input).get(1).asMap();
			System.out.println(map.get("supplier_name"));
			System.out.println(map.get("gst_number"));*/
			response.getWriter().println("Received");
		
		}else if(rid != 0 && cat != null && value != null && colName != null) {
			
			if( cat.equals("st")) {
				responseToClientBrowser =  (stock.update(colName, value, rid))? "true" : "false";
			}
			else if( cat.equals("pr")) {
				responseToClientBrowser =  (product.update(colName, value, rid))? "true" : "false";
			}
			else if( cat.equals("sp")) {
				responseToClientBrowser =  (supplier.update(colName, value, rid))? "true" : "false";
			}
			
		}
		
		response.getWriter().println(responseToClientBrowser);
		
		
	}

}

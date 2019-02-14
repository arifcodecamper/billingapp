package com.sofiyaagencies.servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jsoniter.JsonIterator;
import com.sofiyaagencies.dao.SupplierDAOImpl;

//import com.sofiyaagencies.dao.SupplierDAOImpl;

/**
 * Servlet implementation class UpdateSuplier
 */


@WebServlet("/put-supplier")
public class UpdateSuplier extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateSuplier() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SupplierDAOImpl supplier = new SupplierDAOImpl();
		String input = request.getParameter("rows");
		if(input != null) {
				
			System.out.println("Incoming JSON data total records : " + JsonIterator.deserialize(input).size());
			for(int i = 0 ; i < JsonIterator.deserialize(input).size(); i++ ) {
				supplier.add(JsonIterator.deserialize(input).get(i).asMap());
			}
			/*Map<String, Any> map = JsonIterator.deserialize(input).get(1).asMap();
			System.out.println(map.get("supplier_name"));
			System.out.println(map.get("gst_number"));*/
			response.getWriter().println("Received");
		
		}else if(request.getParameter("colName") != null) {
			supplier.update(request.getParameter("colName"), request.getParameter("value"), Integer.parseInt(request.getParameter("sid")));
		}
		
	}

}

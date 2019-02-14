package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.CustomerDAOImpl;
import com.sofiyaagencies.dao.ProductDAOImpl;
import com.sofiyaagencies.dao.SupplierDAOImpl;

/**
 * Servlet implementation class AutoCompleteProduct
 */
@WebServlet("/auto-complete-customer")
public class AutoCompleteCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoCompleteCustomer() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		CustomerDAOImpl supplier = new CustomerDAOImpl();
		String fieldName = request.getParameter("dataField");
		String searchTerm = request.getParameter("q");
		System.out.println(fieldName + " = " + searchTerm);
		response.getWriter().println(supplier.autocompleteSupplier(fieldName,searchTerm));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}

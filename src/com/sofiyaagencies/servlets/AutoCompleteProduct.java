package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.ProductDAOImpl;

/**
 * Servlet implementation class AutoCompleteProduct
 */
@WebServlet("/auto-complete-product")
public class AutoCompleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AutoCompleteProduct() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ProductDAOImpl product = new ProductDAOImpl();
		String fieldName = request.getParameter("dataField");
		String searchTerm = request.getParameter("q");
		System.out.println(fieldName + " = " + searchTerm);
		response.getWriter().println(product.autocompleteProduct(fieldName,searchTerm));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}

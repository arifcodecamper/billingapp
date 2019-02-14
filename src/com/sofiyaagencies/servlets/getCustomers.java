package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.CustomerDAOImpl;

/**
 * Servlet implementation class getSuppliers
 */
@WebServlet("/get-customers")
public class getCustomers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getCustomers() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerDAOImpl customerObject = new CustomerDAOImpl();
		String offset = request.getParameter("offset").toString();
		String limit = request.getParameter("limit").toString();
		System.out.println("start : " + offset );
		System.out.println("limit : " + limit );
		response.getWriter().append(customerObject.getRows(Integer.parseInt(offset), Integer.parseInt(limit)));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CustomerDAOImpl customerObject = new CustomerDAOImpl();
		String offset = request.getParameter("offset").toString();
		String limit = request.getParameter("limit").toString();
		System.out.println("start : " + offset );
		System.out.println("limit : " + limit );
		response.getWriter().append(customerObject.getRows(Integer.parseInt(offset), Integer.parseInt(limit)));
	}

}

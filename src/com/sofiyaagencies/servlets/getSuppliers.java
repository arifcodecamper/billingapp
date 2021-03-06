package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.SupplierDAOImpl;

/**
 * Servlet implementation class getSuppliers
 */
@WebServlet("/get-suppliers")
public class getSuppliers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getSuppliers() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		SupplierDAOImpl supplierObject = new SupplierDAOImpl();
		String offset = request.getParameter("offset").toString();
		String limit = request.getParameter("limit").toString();
		System.out.println("start : " + offset );
		System.out.println("limit : " + limit );
		response.getWriter().append(supplierObject.getRows(Integer.parseInt(offset), Integer.parseInt(limit)));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SupplierDAOImpl supplierObject = new SupplierDAOImpl();
		
		response.getWriter().append(supplierObject.getAll());
	}

}

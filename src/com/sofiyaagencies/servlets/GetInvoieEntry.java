package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.InvoiceDAOImpl;
import com.sofiyaagencies.interfaces.InvoiceDAO;

/**
 * Servlet implementation class GetInvoieEntry
 */
@WebServlet(name = "GetInvoiceEntry", urlPatterns = { "/get-invoice-entry" })
public class GetInvoieEntry extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetInvoieEntry() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String productName = request.getParameter("product");
		int requiredQuantity = Integer.parseInt(request.getParameter("quantity"));
		System.out.println("Do get servlet request data : " + productName + " - " + requiredQuantity);
		
		InvoiceDAOImpl invoice = new InvoiceDAOImpl();
		response.getWriter().append(invoice.invoiceEntryDetails(productName, requiredQuantity));
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}

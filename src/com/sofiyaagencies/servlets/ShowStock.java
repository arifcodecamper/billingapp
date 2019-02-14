package com.sofiyaagencies.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sofiyaagencies.dao.StockDAOImpl;
import com.sofiyaagencies.dao.SupplierDAOImpl;

/**
 * Servlet implementation class ShowStock
 */
@WebServlet("/get-stocks")
public class ShowStock extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowStock() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		StockDAOImpl stockObject = new StockDAOImpl();
		String offset = request.getParameter("offset").toString();
		String limit = request.getParameter("limit").toString();
		System.out.println("start : " + offset );
		System.out.println("limit : " + limit );
		response.getWriter().append(stockObject.getRows(Integer.parseInt(offset), Integer.parseInt(limit)));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//doGet(request, response);
	}

}

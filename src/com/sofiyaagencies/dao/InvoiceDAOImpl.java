package com.sofiyaagencies.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.jsoniter.any.Any;
import com.sofiyaagencies.db.SingletonDatabaseConnection;
import com.sofiyaagencies.interfaces.InvoiceDAO;

public class InvoiceDAOImpl implements InvoiceDAO {
	
	private Connection dbCon = null;
	private PreparedStatement dbPrepStmt = null;
	
	public InvoiceDAOImpl() {
		 dbCon = null;
		 dbPrepStmt = null;
		
	}

	public String invoiceEntryDetails(String productName, int prodQuantity) {
		System.out.println("invoiceEntryDetails mehod : ");
		
		String query = "SELECT " + 
				"prd.product_id, prd.hsn_code, stk.product_price, stk.gst_percentage, " +
				"(((? * stk.product_price) * (stk.gst_percentage / 100))) as tax, " +
				"(? * stk.product_price) as subtotal, " +
				"((((? * stk.product_price) * (stk.gst_percentage / 100))) + (? * stk.product_price)) as total " +
				"FROM product AS prd INNER JOIN stock AS stk " + 
				"ON prd.product_id = stk.product_product_id " + 
				"where prd.product_name = ?  and stk.quantity > ?";
		// '" + productName + "'  + prodQuantity
		System.out.println("Query : " + query);
		
		ResultSet rs = null;
		
		StringBuffer resultStr = new StringBuffer("");
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			System.out.println(" !!!singleton object:  " + SingletonDatabaseConnection.getInstance());	
			this.dbPrepStmt = dbCon.prepareStatement(query);
			this.dbPrepStmt.setInt(1, prodQuantity);
			this.dbPrepStmt.setInt(2, prodQuantity);
			this.dbPrepStmt.setInt(3, prodQuantity);
			this.dbPrepStmt.setInt(4, prodQuantity);
			this.dbPrepStmt.setString(5, productName);
			this.dbPrepStmt.setInt(6, prodQuantity);
			rs = this.dbPrepStmt.executeQuery();
			
			if(rs.next()){ 
				resultStr.append("{");
				resultStr.append("\"id\":\"").append(rs.getInt("product_id")).append("\",");
				resultStr.append("\"hsn\":\"").append(rs.getString("hsn_code")).append("\",");
				resultStr.append("\"rate\":\"").append(rs.getDouble("product_price")).append("\",");
				resultStr.append("\"gst\":\"").append(rs.getInt("gst_percentage")).append("\",");
				resultStr.append("\"tax\":\"").append(rs.getInt("tax")).append("\",");
				resultStr.append("\"subtotal\":\"").append(rs.getInt("subtotal")).append("\",");
				resultStr.append("\"total\":\"").append(rs.getDouble("total")).append("\"");
				resultStr.append("}");
			}
			
			System.out.println(resultStr);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				this.dbPrepStmt.close();
				this.dbCon.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return resultStr.toString();
	}

	@Override
	public boolean update(String colName, String fieldValue, int rowID) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String getAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getRow(int rowID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getRows(int start, int end) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void delete(int rowID) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void markDelected(int rowID) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean add(Map<String, Any> json) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void update(Map<Object, Object> json, int rowID) {
		// TODO Auto-generated method stub
		
	}

	

}

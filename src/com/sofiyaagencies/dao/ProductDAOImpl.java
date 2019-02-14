package com.sofiyaagencies.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.jsoniter.any.Any;
import com.sofiyaagencies.db.SingletonDatabaseConnection;
import com.sofiyaagencies.interfaces.ProductDAO;

public class ProductDAOImpl implements ProductDAO {
	
	private Connection dbCon;
	private PreparedStatement dbPrepStmt;
	
	public ProductDAOImpl() {
		 dbCon = null;
		 dbPrepStmt = null;
	}
	
	public int getProductID(String colName, String value) {
		String query = "SELECT product_id FROM product WHERE "+ colName +" = '" + value +"'";
		System.out.println("getProductID query : " + query);
		int rowID = 0;
		ResultSet rs = null;
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			if(rs.next()){
				rowID = rs.getInt("product_id");
			}
			
			System.out.println(rowID);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				this.dbPrepStmt.close();
				this.dbCon.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return rowID;
	}

	@Override
	public boolean update(String colName, String fieldValue, int rowID) {
		String query = "UPDATE product  SET "+ colName +" = '" + fieldValue + "' WHERE product_id = " + rowID ;
		boolean isUpdated = false;
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			this.dbPrepStmt.executeQuery();
			isUpdated =  this.dbPrepStmt.getUpdateCount() > 0;
			
			System.out.println(isUpdated);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				this.dbPrepStmt.close();
				this.dbCon.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return isUpdated;
	}

	@Override
	public String getAll() {
		String query = "SELECT * FROM supplier" ;
		
		ResultSet rs = null;
		
		StringBuffer resultStr = new StringBuffer("[");
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			System.out.println(" !!!singleton object:  " + SingletonDatabaseConnection.getInstance());	
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			while(rs.next()){
				resultStr.append("{").append("\"sid\":").append(rs.getInt("supplier_id")).append(",");
				resultStr.append("\"name\":\"").append(rs.getString("supplier_name")).append("\",");
				resultStr.append("\"gstno\":\"").append(rs.getString("gst_number")).append("\"").append("},");		
			}
			resultStr.append("]");
			resultStr.deleteCharAt(resultStr.length() - 2);
			
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
	
	public String autocompleteProduct (String field_name, String searchTerm) {
		String query = "SELECT product_id, " + field_name + " FROM product WHERE " + field_name + " LIKE '%" + searchTerm + "%'";
		
		ResultSet rs = null;
		
		StringBuffer resultStr = new StringBuffer("[");
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			System.out.println(" !!!singleton object:  " + SingletonDatabaseConnection.getInstance());	
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			while(rs.next()){ 
				resultStr.append("\"").append(rs.getString(field_name)).append("\",");
			}
			resultStr.append("]");
			resultStr.deleteCharAt(resultStr.length() - 2);
			
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
		String query = "INSERT INTO product(product_name,hsn_code)  VALUES( '"+ json.get("product_name") +"' , '" + json.get("hsn_code") + "')";
		boolean isAdded = false;
		System.out.println("Product Add Query : " + query);
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			this.dbPrepStmt.execute();
			isAdded =  this.dbPrepStmt.getUpdateCount() > 0;
			
			System.out.println(isAdded);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				this.dbPrepStmt.close();
				this.dbCon.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return isAdded;	
	}

	@Override
	public void update(Map<Object, Object> json, int rowID) {
		// TODO Auto-generated method stub
		
	}

	

}

package com.sofiyaagencies.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.jsoniter.any.Any;
import com.sofiyaagencies.db.SingletonDatabaseConnection;
import com.sofiyaagencies.interfaces.CustomerDAO;

public class CustomerDAOImpl implements CustomerDAO {


	private Connection dbCon = null;
	private PreparedStatement dbPrepStmt = null;
	
	public CustomerDAOImpl() {
		 dbCon = null;
		 dbPrepStmt = null;
		
	}
	
	public String getFieldData(String requiredFieldName, String conditionalFieldName, String conditionalValue) {
		
		String query = "SELECT " + requiredFieldName + " FROM customer WHERE " + conditionalFieldName + " = '" + conditionalValue + "' ORDER BY customer_id ASC LIMIT 1";
		System.out.println(query);
		ResultSet rs = null;
		
		StringBuffer resultStr = new StringBuffer("");
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			System.out.println(" !!!singleton object:  " + SingletonDatabaseConnection.getInstance());	
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			if(rs.next()){ 
				resultStr.append(rs.getString(requiredFieldName));
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
	
public String getTotalCustomersCount() {
		
		String query = "SELECT count(*) as total_count FROM customer"; // LIMIT " + start + ", " + count ;
		ResultSet rs = null;
		StringBuffer resultStr = new StringBuffer("");
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			
			if(rs.next()){
				resultStr.append(rs.getString("total_count"));
			}
			
			System.out.println("total_count : " +resultStr);
			
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

public String autocompleteSupplier (String field_name, String searchTerm) {
	String query = "SELECT customer_id, " + field_name + " FROM customer WHERE " + field_name + " LIKE '%" + searchTerm + "%'";
	
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
	public boolean update(String colName, String fieldValue, int rowID) {
		
		String query = "UPDATE customer  SET "+ colName +" = '" + fieldValue + "' WHERE customer_id = " + rowID ;
		boolean isUpdated = false;
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			this.dbPrepStmt.execute();
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
		
		String query = "SELECT * FROM customer" ;
		
		ResultSet rs = null;
		
		StringBuffer resultStr = new StringBuffer("[");
		
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			System.out.println(" !!!singleton object:  " + SingletonDatabaseConnection.getInstance());	
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			while(rs.next()){
				resultStr.append("{").append("\"cid\":").append(rs.getInt("customer_id")).append(",");
				resultStr.append("\"name\":\"").append(rs.getString("customer_name")).append("\",");
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

	@Override
	public String getRow(int rowID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getRows(int start, int count) {
		String query = "SELECT * FROM customer LIMIT " + start + ", " + count ;
		System.out.println("Query : " + query);
		ResultSet rs = null;
		StringBuffer resultStr = new StringBuffer("[");
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			while(rs.next()){
				resultStr.append("{").append("\"cid\":").append(rs.getInt("customer_id")).append(",");
				resultStr.append("\"name\":\"").append(rs.getString("customer_name")).append("\",");
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

	@Override
	public void delete(int rowID) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void markDelected(int rowID) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean add(Map<String, Any> map) {
		String query = "INSERT INTO customer(customer_name,gst_number)  VALUES( '"+ map.get("customer_name") +"' , '" + map.get("gst_number") + "')";
		boolean isAdded = false;
		
		
		System.out.println("Customer Add Query : " + query);
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

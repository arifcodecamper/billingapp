package com.sofiyaagencies.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.jsoniter.any.Any;
import com.sofiyaagencies.db.SingletonDatabaseConnection;
import com.sofiyaagencies.interfaces.SupplierDAO;

public class SupplierDAOImpl implements SupplierDAO {
	
	private Connection dbCon;
	private PreparedStatement dbPrepStmt;
	
	public SupplierDAOImpl() {
		 dbCon = null;
		 dbPrepStmt = null;
	}

	public int getSupplierID(String colName, String value) {
		String query = "SELECT supplier_id FROM supplier WHERE "+ colName +" = '" + value +"'";;
		System.out.println("getSupplierID query : " + query);
		int rowID = 0;
		ResultSet rs = null;
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			if(rs.next()){
				rowID = rs.getInt("supplier_id");
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

	@Override
	public String getRow(int rowID) {
		String query = "SELECT * FROM supplier WHERE supplier_id=" + rowID ;
		ResultSet rs = null;
		StringBuffer resultStr = new StringBuffer("");
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			if(rs.next()){
				resultStr.append("{").append("sid:").append(rs.getInt("supplier_id")).append(",");
				resultStr.append("name:\"").append(rs.getString("supplier_name")).append("\",");
				resultStr.append("gstno:\"").append(rs.getString("gst_number")).append("\"").append("}");		
			}
			//resultStr.append("]");
			//resultStr.deleteCharAt(resultStr.length() - 2);
			
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
	public String getRows(int start, int count) {
		String query = "SELECT * FROM supplier LIMIT " + start + ", " + count ;
		ResultSet rs = null;
		StringBuffer resultStr = new StringBuffer("[");
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
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

	public String autocompleteSupplier (String field_name, String searchTerm) {
		String query = "SELECT supplier_id, " + field_name + " FROM supplier WHERE " + field_name + " LIKE '%" + searchTerm + "%'";
		
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
	public void delete(int rowID) {
		
	}

	@Override
	public void markDelected(int rowID) {
		
	}
	
	public String getTotalSuppliersCount() {
		
		String query = "SELECT count(*) as total_count FROM supplier"; // LIMIT " + start + ", " + count ;
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
	
	public static void main(String args[]){
		
		new SupplierDAOImpl().getAll();
	}

	@Override
	public boolean update(String colName, String fieldValue, int rowID) {
		String query = "UPDATE supplier  SET "+ colName +" = '" + fieldValue + "' WHERE supplier_id = " + rowID ;
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
	public boolean add(Map<String, Any> map) {
		String query = "INSERT INTO supplier(supplier_name,gst_number)  VALUES( '"+ map.get("supplier_name") +"' , '" + map.get("gst_number") + "')";
		boolean isAdded = false;
		
		
		System.out.println("Supplier Add Query : " + query);
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
	public void update(java.util.Map<Object, Object> json, int rowID) {
		
	}
}

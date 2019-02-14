package com.sofiyaagencies.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.jsoniter.any.Any;
import com.sofiyaagencies.db.SingletonDatabaseConnection;
import com.sofiyaagencies.interfaces.StockDAO;

public class StockDAOImpl implements StockDAO{

	private Connection dbCon ;
	private PreparedStatement dbPrepStmt ;
	
	public StockDAOImpl() {
		 dbCon = null;
		 dbPrepStmt = null;
		
	}

	
	@Override
	public String getAll() {
		return null;
	}

	@Override
	public String getRow(int rowID) {
		return null;
	}

	@Override
	public String getRows(int start, int count) {
		
		String query = "SELECT prd.product_id,prd.product_name,prd.hsn_code,prd.description,stk.stock_entry_id,stk.product_price,stk.quantity,stk.gst_percentage,stk.date_of_purchase,sup.supplier_id,sup.supplier_name FROM product AS prd INNER JOIN stock AS stk ON prd.product_id = stk.product_product_id INNER JOIN supplier AS sup ON stk.supplier_supplier_id = sup.supplier_id LIMIT " + start + ", " + count ;
		ResultSet rs = null;
		StringBuffer resultStr = new StringBuffer("[");
		try {
			this.dbCon = SingletonDatabaseConnection.getInstance().getConnection();
			this.dbPrepStmt = dbCon.prepareStatement(query);
			rs = this.dbPrepStmt.executeQuery();
			while(rs.next()){
				resultStr.append("{");
					resultStr.append("\"stock\":{").append("\"sno\":").append(rs.getInt("stock_entry_id")).append(",");
					resultStr.append("\"price\":\"").append(rs.getString("product_price")).append("\",");
					resultStr.append("\"quantity\":\"").append(rs.getString("quantity")).append("\",");
					resultStr.append("\"gst\":\"").append(rs.getString("gst_percentage")).append("\",");
					resultStr.append("\"date\":\"").append(rs.getString("date_of_purchase")).append("\"").append("},");
					
					resultStr.append("\"product\":{").append("\"prno\":").append(rs.getInt("product_id")).append(",");
					resultStr.append("\"name\":\"").append(rs.getString("product_name")).append("\",");
					resultStr.append("\"hsncode\":\"").append(rs.getString("hsn_code")).append("\",");
					resultStr.append("\"desc\":\"").append(rs.getString("description")).append("\"").append("},");
					
					resultStr.append("\"supplier\":{");
					resultStr.append("\"name\":\"").append(rs.getString("supplier_name")).append("\",");
					resultStr.append("\"supno\":\"").append(rs.getString("supplier_id")).append("\"}");

				resultStr.append("},");
				
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
	
public String getTotalStocksCount() {
		
		String query = "SELECT count(*) as total_count FROM product AS prd INNER JOIN stock AS stk ON prd.product_id = stk.product_product_id INNER JOIN supplier AS sup ON stk.supplier_supplier_id = sup.supplier_id ";
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
		String query = "INSERT INTO `billing`.`stock` (`gst_percentage`, `quantity`, `product_price`, `date_of_purchase`, `product_product_id`, `supplier_supplier_id`)  VALUES( '" + 
				json.get("gst_percentage") +"' , '" + 
				json.get("quantity") +"' , '" + 
				json.get("product_price") + "' , '" + 
				json.get("date_of_purchase") +"' , '" + 
				json.get("product_product_id") +"' , '" + 
				json.get("supplier_supplier_id") + "')";
		boolean isAdded = false;
		System.out.println("stock Add Query : " + query);
		
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

	@Override
	public boolean update(String colName, String fieldValue, int rowID) {
		String query = "UPDATE stock  SET "+ colName +" = '" + fieldValue + "' WHERE stock_entry_id = " + rowID ;
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

	

}

package com.sofiyaagencies.db;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class SingletonDatabaseConnection {
	
	private Properties prop;
	private static SingletonDatabaseConnection singleObj = null;
	private String jdbcDriverClass = "com.mysql.jdbc.Driver";
	private String dbHost;
	private String dbName;
	private String dbPassword;
	private String dbUser;
	private String jdbcConnectionUrl;
	
	
	private SingletonDatabaseConnection(){
		
		try{
			Class.forName(jdbcDriverClass);
			
			InputStream fr  = new FileInputStream(new File("D:/Program Files/billing/dbconfig.properties"));
			//System.out.println(fr);
			
			Properties prop = new Properties();
			prop.load(fr);
			
			System.out.println(prop);
			
			this.dbHost = prop.getProperty("db.host");
			this.dbName = prop.getProperty("db.name");
			this.dbUser = prop.getProperty("db.user");
			this.dbPassword = prop.getProperty("db.password");
			
			
			
			this.jdbcConnectionUrl = "jdbc:mysql://" + this.dbHost + ":3306/" + this.dbName ;
			System.out.println(this.jdbcConnectionUrl);
			
		} catch(ClassNotFoundException sqlE){
			System.out.println("SQL Exception : ");
			sqlE.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	public static SingletonDatabaseConnection getInstance() {
		
		if(singleObj == null)
			singleObj = new SingletonDatabaseConnection();
		System.out.println(singleObj);
		
		return singleObj;
	}
	
	public Connection getConnection() {
		Connection mysqlConnection = null;
		try {
			System.out.println("URL "+this.jdbcConnectionUrl);
			mysqlConnection = DriverManager.getConnection(this.jdbcConnectionUrl, this.dbUser, this.dbPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mysqlConnection;
	}
	
	/*public static void main(String args[]){
		Connection con = SingletonDatabaseConnection.getInstance().getConnection();
		System.out.println(con);
		con = SingletonDatabaseConnection.getInstance().getConnection();
		System.out.println(con);
		
	}*/
}

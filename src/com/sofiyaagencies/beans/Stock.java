package com.sofiyaagencies.beans;

import java.io.Serializable;
import java.util.Date;

public class Stock  implements Serializable  {

	private int entryID;
	private int gstInPercentage;
	private int quantity;
	private double productPrice;
	private Date datePurchased;
	private Product product;
	private Supplier supplier;
	
	public Stock() { 
		
	}

	public int getEntryID() {
		return entryID;
	}

	public void setEntryID(int entryID) {
		this.entryID = entryID;
	}

	public int getGstInPercentage() {
		return gstInPercentage;
	}

	public void setGstInPercentage(int gstInPercentage) {
		this.gstInPercentage = gstInPercentage;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(double productPrice) {
		this.productPrice = productPrice;
	}

	public Date getDatePurchased() {
		return datePurchased;
	}

	public void setDatePurchased(Date datePurchased) {
		this.datePurchased = datePurchased;
	}

	public Product getProductID() {
		return product;
	}

	public void setProductID(Product product) {
		this.product = product;
	}

	public Supplier getSupplier() {
		return supplier;
	}

	public void setSupplierID(Supplier supplier) {
		this.supplier = supplier;
	}
	
	
	
}

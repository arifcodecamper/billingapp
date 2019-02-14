package com.sofiyaagencies.beans;

import java.io.Serializable;

public class Product  implements Serializable  {
 private int id;
 private String name;
 private String hsn;
 private String description;
 
 public Product(){
	 
 }

public int getId() {
	return id;
}

public void setId(int id) {
	this.id = id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getHsn() {
	return hsn;
}

public void setHsn(String hsn) {
	this.hsn = hsn;
}

public String getDescription() {
	return description;
}

public void setDescription(String description) {
	this.description = description;
}
 
 
}

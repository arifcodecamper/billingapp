package com.sofiyaagencies.interfaces;

import java.util.LinkedHashMap;
import java.util.Map;

import com.jsoniter.any.Any;

public interface MasterDAO {

	public boolean add(Map<String, Any> json);
	public void update(Map<Object,Object> json, int rowID);
	public boolean update(String colName, String fieldValue, int rowID);
	public String getAll();
	public String getRow(int rowID);
	public String getRows(int start, int end);
	public void delete(int rowID);
	public void markDelected(int rowID);
}

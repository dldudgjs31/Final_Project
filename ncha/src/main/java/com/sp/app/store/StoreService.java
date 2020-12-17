package com.sp.app.store;

import java.util.List;
import java.util.Map;

public interface StoreService {
	public void insertProduct(Store dto, String pathname) throws Exception;
	public List<Store> listProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public Store readProduct(int num);
	public void updateHitCount(int num) throws Exception;
	public Store preReadProduct(Map<String, Object> map);
	public Store nextReadProduct(Map<String, Object> map);
	public void updateProduct(Store dto) throws Exception;
	public void delete(int num, String sellerId)throws Exception;
	
}

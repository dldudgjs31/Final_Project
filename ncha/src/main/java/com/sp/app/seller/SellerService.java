package com.sp.app.seller;

import java.util.List;
import java.util.Map;

public interface SellerService {
	public Seller loginSeller(String sellerId);
	
	public void insertSeller(Seller dto,String pathname) throws Exception;
	
	public void updateLastLogin(String sellerId) throws Exception;
	public void updateSeller(Seller dto,String pathname) throws Exception;
	
	public Seller readSeller(String sellerId);
	
	public void deleteSeller(Map<String, Object> map) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Seller> listSeller(Map<String, Object> map);
}

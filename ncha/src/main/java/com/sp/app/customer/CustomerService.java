package com.sp.app.customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {

	public void insertOrder(Customer dto) throws Exception;
	public String readImage(int productNum)throws Exception;
	public void insertCart(Customer dto) throws Exception;
	public void updateStock(Customer dto) throws Exception;
	public List<Customer> readCart(Map<String, Object> map) throws Exception;
}


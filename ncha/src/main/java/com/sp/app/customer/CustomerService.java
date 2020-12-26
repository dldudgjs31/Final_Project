package com.sp.app.customer;

public interface CustomerService {

	public void insertOrder(Customer dto) throws Exception;
	public String readImage(int productNum)throws Exception;
}

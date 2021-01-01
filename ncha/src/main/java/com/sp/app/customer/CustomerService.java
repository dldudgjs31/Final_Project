package com.sp.app.customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {

	//결제 관련
	public void insertOrder(Customer dto) throws Exception;
	public String readImage(int productNum)throws Exception;
	public void updateStock(Customer dto) throws Exception;
	public void updateStockOption(Customer dto) throws Exception;
	public int readStockOption(int OptionNum) throws Exception;
	
	//장바구니 관련
	public void insertCart(Customer dto) throws Exception;
	public List<Customer> readCart(Map<String, Object> map) throws Exception;
	public void deleteCart(int cartNum) throws Exception;
	public int readStock(int productNum) throws Exception;
	public int readCartQuantity(Customer dto) throws Exception;
	public void deleteAllCart(String userId) throws Exception;
	
	//리뷰 관련
	public List<Customer> readOrderList(long memberIdx) throws Exception;
	public int readReviewCount(Customer dto) throws Exception;
	public int readReviewNum(int OrderNum) throws Exception;
	
}



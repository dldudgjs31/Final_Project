package com.sp.app.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("customer.customerService")
public class CustomerImpl implements CustomerService{
	@Autowired
	private CommonDAO  dao;

	@Override
	public void insertOrder(Customer dto) throws Exception {
		try {
			dao.updateData("customer.insertOrder", dto); 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public String readImage(int productNum) throws Exception {
		String imageFilename = null;
		try {
			imageFilename= dao.selectOne("customer.listProduct", productNum); 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return imageFilename;
	}
	

}

package com.sp.app.customer;

import java.util.List;
import java.util.Map;

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

	@Override
	public void insertCart(Customer dto) throws Exception {
		try {
			dao.insertData("customer.insertCart", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateStock(Customer dto) throws Exception {
		try {
			dto.setStock(dto.getStock()-dto.getNumber_sales());
			dao.updateData("customer.updateStock", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;			
		}
		
	}

	@Override
	public List<Customer> readCart(Map<String, Object> map) throws Exception {
		List<Customer> list =null;
		try {
			list = dao.selectList("customer.readCart", map);
		} catch (Exception e) {
			
		}
		return list;
	}


	
	

}

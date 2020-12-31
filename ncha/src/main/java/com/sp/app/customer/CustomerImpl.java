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
			e.printStackTrace();
			throw e;				
		}
		return list;
	}

	@Override
	public void deleteCart(int cartNum) throws Exception {
		try {
			dao.deleteData("customer.deleteCart",cartNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;				
		}
		
	}

	@Override
	public int readStock(int productNum) throws Exception {
		int stock=0;
		try {
			stock = dao.selectOne("customer.readStock", productNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return stock;
	}

	@Override
	public int readCartQuantity(Customer dto) throws Exception {
		int quantity=0;
		try {
			quantity=dao.selectOne("customer.readCartQuantity", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return quantity;
	}

	@Override
	public void updateStockOption(Customer dto) throws Exception {

		try {

			dao.updateData("customer.updateStockOption", dto);
		} catch (Exception e) {
		}
		
	}

	@Override
	public int readStockOption(int OptionNum) throws Exception {
		int stock = 0;
		try {
			stock = dao.selectOne("customer.readStockOption", OptionNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return stock;
	}

	@Override
	public void deleteAllCart(String userId) throws Exception {
		try {
			dao.deleteData("customer.deleteAllCart", userId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Customer> readOrderList(long memberIdx) throws Exception {
		List<Customer> list = null;
		try {
			list = dao.selectList("customer.readOrderList", memberIdx);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;			
		}
		return list;
	}


	
	

}

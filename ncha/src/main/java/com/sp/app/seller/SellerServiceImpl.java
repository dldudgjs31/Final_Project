package com.sp.app.seller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("seller.sellerService")
public class SellerServiceImpl implements SellerService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Seller loginSeller(String sellerId) {
		Seller dto=null;
		
		try {
			dto=dao.selectOne("seller.loginSeller", sellerId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;

	}

	@Override
	public void insertSeller(Seller dto) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("seller.insertSeller", dto);  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public void updateLastLogin(String sellerId) throws Exception {
		try {
			dao.updateData("seller.updateLastLogin", sellerId);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateSeller(Seller dto) throws Exception {
		try {
			if(dto.getEmail1().length()!=0 && dto.getEmail2().length()!=0) {
				dto.setEmail(dto.getEmail1() + "@" + dto.getEmail2());
			}
			
			if(dto.getTel1().length()!=0 && dto.getTel2().length()!=0 && dto.getTel3().length()!=0) {
				dto.setTel(dto.getTel1() + "-" + dto.getTel2() + "-" + dto.getTel3());
			}
			
			dao.updateData("seller.updateSeller", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}	
	}

	@Override
	public Seller readSeller(String sellerId) {
		Seller dto=null;
		
		try {
			dto=dao.selectOne("seller.readSeller", sellerId);
			
			if(dto!=null) {
				if(dto.getEmail()!=null) {
					String [] s=dto.getEmail().split("@");
					dto.setEmail1(s[0]);
					dto.setEmail2(s[1]);
				}

				if(dto.getTel()!=null) {
					String [] s=dto.getTel().split("-");
					dto.setTel1(s[0]);
					dto.setTel2(s[1]);
					dto.setTel3(s[2]);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteSeller(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("seller.deleteSeller", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Seller> listSeller(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

}

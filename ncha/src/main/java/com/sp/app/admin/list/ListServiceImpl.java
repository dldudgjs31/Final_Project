package com.sp.app.admin.list;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.member.Member;
import com.sp.app.seller.Seller;

@Service("admin.list.listService") 
public class ListServiceImpl implements ListService {
	@Autowired
	private CommonDAO dao;

	@Override
	public int dataCountMember(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountMember", map);
		} catch (Exception e) {
		}
		
		return result;
	}
	
	@Override
	public List<Member> listMember(Map<String, Object> map) {
		List<Member> list=null;
		try {
			list=dao.selectList("list.listMember", map);	
		} catch (Exception e) {
		}
		
		return list;
	}
	
	@Override
	public List<Member> listMember() {
		List<Member> list=null;
		try {
			list=dao.selectList("list.listAllMember");	
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public void deleteMember(String userId) throws Exception {
		try {
			dao.deleteData("list.deleteMember", userId);	
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public Member readMember(String userId) {
		Member dto =null;
		try {
			dto=dao.selectOne("list.readMember", userId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public int dataCountSeller(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountSeller", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Seller> listSeller(Map<String, Object> map) {
		List<Seller> list=null;
		try {
			list=dao.selectList("list.listSeller", map);	
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public List<Seller> listSeller() {
		List<Seller> list=null;
		try {
			list=dao.selectList("list.listAllSeller");	
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public Seller readSeller(String sellerId) {
		Seller dto =null;
		try {
			dto=dao.selectOne("list.readSeller", sellerId);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public void deleteSeller(String sellerId) throws Exception {
		try {
			dao.deleteData("list.deleteSeller", sellerId);	
		} catch (Exception e) {
			throw e;
		}
		
	}

	
}

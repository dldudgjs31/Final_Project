package com.sp.app.admin.list;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;
import com.sp.app.member.Member;

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

	
}

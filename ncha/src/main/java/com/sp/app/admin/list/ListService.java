package com.sp.app.admin.list;

import java.util.List;
import java.util.Map;

import com.sp.app.member.Member;

public interface ListService {
	public int dataCountMember(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	public List<Member> listMember();
	public Member readMember(String userId);
	public void deleteMember(String userId) throws Exception;

}

package com.sp.app.admin.list;

import java.util.List;
import java.util.Map;

import com.sp.app.member.Member;
import com.sp.app.seller.Seller;

public interface ListService {
	public int dataCountMember(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	public List<Member> listMember();
	public Member readMember(String userId);
	public void deleteMember(String userId) throws Exception;

	public int dataCountSeller(Map<String, Object> map);
	public List<Seller> listSeller(Map<String, Object> map);
	public List<Seller> listSeller();
	public Seller readSeller(String sellerId);
	public void deleteSeller(String sellerId) throws Exception;

}

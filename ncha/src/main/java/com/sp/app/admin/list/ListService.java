package com.sp.app.admin.list;

import java.util.List;
import java.util.Map;

import com.sp.app.event.Event;
import com.sp.app.member.Member;
import com.sp.app.notice.Notice;
import com.sp.app.seller.Seller;

public interface ListService {
	public int dataCountMember(Map<String, Object> map);
	public List<Member> listMember(Map<String, Object> map);
	public List<Member> listMember();
	public Member readMember(String userId);
	public void updateMember(Map<String, Object> map) throws Exception;
	public void deleteMember(String userId) throws Exception;

	public int dataCountSeller(Map<String, Object> map);
	public List<Seller> listSeller(Map<String, Object> map);
	public List<Seller> listSeller();
	public Seller readSeller(String sellerId);
	public void updateSeller(Map<String, Object> map) throws Exception;
	public void deleteSeller(String sellerId) throws Exception;

	public int dataCountEvent(Map<String, Object> map);
	public List<Event> listEvent(Map<String, Object> map);
	public List<Event> listEvent();
	public Seller readEvent(Integer eventNum);
	public void updateEvent(Map<String, Object> map) throws Exception;
	public void deleteEvent(Integer eventNum) throws Exception;

	public int dataCountNotice(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNotice();
	public void updateNotice(Map<String, Object> map)   throws Exception;
	public void deleteNotice(int num, String pathname) throws Exception;
	public List<Notice> listFile(int num);
	public void deleteFile(Map<String, Object> map) throws Exception;


}

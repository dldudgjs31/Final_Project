package com.sp.app.admin.list;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
import com.sp.app.event.Event;
import com.sp.app.member.Member;
import com.sp.app.notice.Notice;
import com.sp.app.seller.Seller;

@Service("admin.list.listService") 
public class ListServiceImpl implements ListService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
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

	@Override
	public void updateSeller(Map<String, Object> map) throws Exception {
		
		try {
			dao.updateData("list.updateSeller", map);	
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void updateMember(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("list.updateMember", map);	
		} catch (Exception e) {
			throw e;
		}		
	}

	@Override
	public int dataCountNotice(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountNotice", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Notice> listNotice(Map<String, Object> map) {
		List<Notice> list=null;
		
		try {
			list=dao.selectList("list.listNotice", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<Notice> listNotice() {
		List<Notice> list=null;
		try {
			list=dao.selectList("list.listAllNotice");	
		} catch (Exception e) {
		}
		
		return list;
	}

	
	@Override
	public void updateNotice(Map<String, Object> map) throws Exception {
		
		try {
			dao.updateData("list.updateNotice", map);	
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public List<Notice> listFile(int num) {
		List<Notice> listFile=null;
		
		try {
			listFile=dao.selectList("notice.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listFile;
	}

	@Override
	public void deleteNotice(int num, String pathname) throws Exception {
		try {
			// 파일 지우기
			List<Notice> listFile=listFile(num);
			if(listFile!=null) {
				for(Notice dto:listFile) {
					fileManager.doFileDelete(dto.getSaveFilename(), pathname);
				}
			}
			
			// 파일 테이블 내용 지우기
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "num");
			map.put("num", num);
			deleteFile(map);
			
			dao.deleteData("notice.deleteNotice", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public int dataCountEvent(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("list.dataCountEvent", map);
		} catch (Exception e) {
		}
		
		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {
		List<Event> list=null;
		try {
			list=dao.selectList("list.listEvent", map);	
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public List<Event> listEvent() {
		List<Event> list=null;
		try {
			list=dao.selectList("list.listAllEvent");	
		} catch (Exception e) {
		}
		
		return list;
	}

	@Override
	public Seller readEvent(Integer eventNum) {
		Seller dto =null;
		try {
			dto=dao.selectOne("list.readEvent", eventNum);
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return dto;
	}

	@Override
	public void updateEvent(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("list.updateEvent", map);	
		} catch (Exception e) {
			throw e;
		}	
	}

	@Override
	public void deleteEvent(Integer eventNum) throws Exception {
		try {
			dao.deleteData("list.deleteEvent", eventNum);	
		} catch (Exception e) {
			throw e;
		}		
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("notice.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}

package com.sp.app.event;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("event.eventServiceImpl")
public class EventServiceImpl implements EventService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertEvent(Event dto, String pathname) throws Exception {
		try {
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if (saveFilename != null) {
				dto.setImageFilename(saveFilename);

				dao.insertData("event.insertEvent", dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("event.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public List<Event> listEvent(Map<String, Object> map) {

		List<Event> list = null;
		try {
			list = dao.selectList("event.listEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public Event readEvent(int eventNum) {
		Event dto = null;

		try {
			dto = dao.selectOne("event.readEvent", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Event preReadEvent(Map<String, Object> map) {
		Event dto = null;

		try {
			dto = dao.selectOne("event.preReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Event nextReadEvent(Map<String, Object> map) {
		Event dto = null;

		try {
			dto = dao.selectOne("event.nextReadEvent", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateEvent(Event dto, String pathname) throws Exception {
		try {
			// 업로드한 파일이 존재한 경우
			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);

			if (saveFilename != null) {
				// 이전 파일 지우기
				if (dto.getImageFilename().length() != 0) {
					fileManager.doFileDelete(dto.getImageFilename(), pathname);
				}

				dto.setImageFilename(saveFilename);
			}

			dao.updateData("event.updateEvent", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteEvent(int eventNum, String pathname, String sellerId) throws Exception {
		try {
			Event dto = readEvent(eventNum);
			if(dto==null || (! sellerId.equals("admin") && ! sellerId.equals(dto.getSellerId())))
				return;
			
			if(dto.getImageFilename()!=null)
				fileManager.doFileDelete(dto.getImageFilename(), pathname);
			
			// 게시물지우기
			dao.deleteData("photo.deletePhoto", eventNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}

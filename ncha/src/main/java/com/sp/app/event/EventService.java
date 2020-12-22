package com.sp.app.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertNotice(Event dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Event> listNotice(Map<String, Object> map);
	public List<Event> listNoticeTop();
	
	public void updateHitCount(int num) throws Exception;
	public Event readNotice(int num);
	public Event preReadNotice(Map<String, Object> map);
	public Event nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Event dto, String pathname) throws Exception;
	public void deleteNotice(int num, String pathname) throws Exception;
	
	public void insertFile(Event dto) throws Exception;
	public List<Event> listFile(int num);
	public Event readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}

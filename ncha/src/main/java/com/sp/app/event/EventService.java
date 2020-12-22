package com.sp.app.event;

import java.util.List;
import java.util.Map;

public interface EventService {
	public void insertEvent(Event dto, String pathname) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Event> listEvent(Map<String, Object> map);
	
	public Event readEvent(int eventNum);
	public Event preReadEvent(Map<String, Object> map);
	public Event nextReadEvent(Map<String, Object> map);
	
	public void updateEvent(Event dto, String pathname) throws Exception;
	public void deleteEvent(int eventNum, String pathname, String sellerId) throws Exception;
}

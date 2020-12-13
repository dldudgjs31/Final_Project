package com.sp.app.daily;

import java.util.List;
import java.util.Map;

public interface DailyService {
	//글등록
	public void insertDaily(Daily dto, String pathname) throws Exception;
	
	//글리스트
	public int dataCount(Map<String, Object>map);
	public List<Daily> listDaily(Map<String, Object> map);
	public List<Daily> listDailyTop(); // 얘는 상단에 보여질 게시물 (광고글 같은거 넣어도 괜찮을듯)
	
	//글읽기
	public Daily readDaily(int dailyNum) throws Exception;
	
	//업데이트, 삭제
	public void updateDaily(Daily dto, String pathname) throws Exception;
	public void deleteDaily(int dailyNum, String pathname ) throws Exception;
	
	//사진관련
	public void insertFile(Daily dto) throws Exception;
	public List<Daily>listFile(int dailyNum);
	public Daily readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	
}

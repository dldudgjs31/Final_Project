package com.sp.app.daily;

import java.util.List;
import java.util.Map;


public interface DailyService {
	//글등록
	public void insertDaily(Daily dto, String pathname) throws Exception;
	//public void insertDaily(Daily dto, String pathname, String daily_usedNum) throws Exception;
	
	//글리스트
	public int dataCount(Map<String, Object>map);
	public List<Daily> listDaily(Map<String, Object> map);
	public List<Daily> listDailyTop(); // 얘는 상단에 보여질 게시물 (광고글 같은거 넣어도 괜찮을듯)
	
	
	//글읽기
	public void updateHitCount(int dailyNum) throws Exception;
	public Daily readDaily(int dailyNum) throws Exception;
	public List<Daily> readDailyFile(int dailyNum) throws Exception;
	public Daily preReadDaily(Map<String, Object> map);
	public Daily nextReadDaily(Map<String, Object> map);
	
	//업데이트, 삭제
	public void updateDaily(Daily dto, String pathname) throws Exception;
	public void deleteDaily(int dailyNum, String pathname ) throws Exception;
	
	//사진관련
	public void insertFile(Daily dto) throws Exception;
	public List<Daily>listFile(int dailyNum);
	public Daily readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	public void deleteFileAll(Map<String, Object> map) throws Exception;
	
	//댓글 답글  좋아요
	public void insertDailyLike(Map<String, Object> map) throws Exception;
	public int dailyLikeCount(int dailyNum);
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);

	public void insertReplyLike(Map<String, Object> map) throws Exception;
	public Map<String, Object> replyLikeCount(Map<String, Object> map);
	
	//중고글 번호
	public List<Used> listUsed(Map<String, Object> map);
	
	//메인에 표시할 게시물
	public Daily readDailyHit() throws Exception;
	public List<Daily> readDailyHit2() throws Exception;
	public Daily readDailyLike() throws Exception;
	

	
}

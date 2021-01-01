package com.sp.app.used;

import java.util.List;
import java.util.Map;


public interface UsedService {
	//게시글 CRUD
	public void insertUsed(Used dto, String pathname) throws Exception; //중고글 작성
	public Used readUsed(int usedNum); //중고글보기
	public void updateUsed(Used dto, String pathname) throws Exception; // 글 수정
	public void deleteUsed(int num, String pathname,String userId) throws Exception;  // 글 삭제
	
	//게시글 관련
	public int dataCount(Map<String, Object> map); // 데이터 개수
	public List<Used> listUsed(Map<String, Object> map); // 리스트
	public void updateHitCount(int num) throws Exception; //조회수 증가
	public Used preReadDto(Map<String, Object> map);  //이전글
	public Used nextReadDto(Map<String, Object> map); //다음글
	public void insertUsedLike(Map<String, Object> map) throws Exception; //중고글 좋아요
	public int usedLikeCount(int usedNum); //중고글 좋아요 카운트

	//사진 CRUD
	public void insertFile(Used dto) throws Exception; // 파일하나 처리
	public Used readFile(int fileNum); //파일 읽기
	public void deleteImage(Map<String, Object> map)throws Exception;
	public void deleteAllImage(Map<String, Object> map) throws Exception; //파일삭제
	public List<Used> imageList(int num); //이미지 리스트
	
	//댓글 CRUD
	public void insertReply(Reply dto) throws Exception; // 댓글 쓰기
	public void deleteReply(Map<String, Object>map) throws Exception; // 댓글 삭제
	public void updateReply(Map<String, Object> map) throws Exception; // 댓글 수정
	public List<Reply> listReply(Map<String, Object> map); // 댓글 리스트
	
	//댓글 관련
	public int replyCount(Map<String, Object> map); //댓글 개수 카운트
	public void insertReplyLike(Map<String, Object> map) throws Exception; //댓글 좋아요
	public Map<String,Object> replyLikecount(Map<String,Object>map); // 댓글 좋아요 카운트
	
	//대댓글 관련
	public int replyAnswerCount(int answer); //대댓글 좋아요 카운트
	public List<Reply> listReplyAnswer(int answer); //대댓글 리스트
	
	//마이페이지 관련
	public List<Used> listUsed_mypage(Map<String, Object> map);
	
	//찜기능 관련
	public void insertKeepList(Map<String, Object> map) throws Exception; //찜목록 추가
	public int usedKeepCount(Map<String, Object> map);
	public List<Used> keepList(Map<String, Object> map);
	public void deleteKeep(Map<String, Object>map) throws Exception;
}

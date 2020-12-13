package com.sp.app.used;

import java.util.List;
import java.util.Map;


public interface UsedService {
	public void insertUsed(Used dto, String pathname) throws Exception; //중고글 작성
	
	public int dataCount(Map<String, Object> map); // 데이터 개수
	public List<Used> listUsed(Map<String, Object> map); // 리스트
	
	public void updateHitCount(int num) throws Exception; //조회수 증가
	public Used readUsed(int num); //중고글보기
	public Used preReadUsed(Map<String, Object> map);  //이전글
	public Used nextReadUsed(Map<String, Object> map); //다음글
	
	public void updateUsed(Used dto, String pathname) throws Exception; // 글 수정
	public void deleteUsed(int num, String pathname) throws Exception;  // 글 삭제
	
	public void insertFile(Used dto) throws Exception; // 파일하나 처리
	public List<Used> listFile(int num); // 다중파일 처리
	public Used readFile(int fileNum); //파일 읽기
	public void deleteFile(Map<String, Object> map) throws Exception; //파일삭제
}

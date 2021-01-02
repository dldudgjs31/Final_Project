package com.sp.app.qna;

import java.util.List;
import java.util.Map;

public interface QnaService {
	//글 작성
	public void insertQna(Qna dto) throws Exception;
	//글 리스트 출력
	public List<Qna> listQna(Map<String, Object> map) throws Exception;
	public int dataQnaCount(Map<String, Object> map) throws Exception;
	//mypage에서 qna 리스트
	public List<Qna> listMyQna(Map<String, Object> map) throws Exception;
	public int dataMyQnaCount(Map<String, Object> map) throws Exception;
	public void deleteMyQna(Map<String, Object> map)throws Exception;
	public void updateMyQna(Qna dto) throws Exception;
}

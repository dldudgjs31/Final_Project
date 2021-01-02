package com.sp.app.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("qna.qnaService")
public class QnaServiceImpl implements QnaService {
	@Autowired
	private CommonDAO dao;
	
	/**
	 * 글 작성
	 */
	@Override
	public void insertQna(Qna dto) throws Exception {
		try {
			dao.insertData("qna.insertQna", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	/**
	 * 글리스트 출력
	 */
	@Override
	public List<Qna> listQna(Map<String, Object> map) throws Exception {
		List<Qna> list = null;
		try {
			list = dao.selectList("qna.listQna", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		return list;
	}
	
	@Override
	public int dataQnaCount(Map<String, Object> map) throws Exception {
		int dataCount=0;
		try {
			dataCount = dao.selectOne("qna.dataQnaCount", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dataCount;
	}
	
	@Override
	public List<Qna> listMyQna(Map<String, Object> map) throws Exception {
		List<Qna> list = null;
		try {
			list = dao.selectList("qna.listMyQna", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}
	
	@Override
	public int dataMyQnaCount(Map<String, Object> map) throws Exception {
		int dataCount=0;
		try {
			dataCount= dao.selectOne("qna.dataMyQnaCount",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dataCount;
	}
	@Override
	public void deleteMyQna(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteMyQna", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	@Override
	public void updateMyQna(Qna dto) throws Exception {
		try {
			dao.updateData("qna.updateMyQna", dto); 
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


}

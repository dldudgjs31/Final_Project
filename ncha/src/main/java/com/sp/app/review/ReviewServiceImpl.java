package com.sp.app.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("review.reviewService")
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertReview(Review dto) throws Exception {
		try {
			dao.insertData("review.insertReview",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public List<Review> listReview(Map<String, Object> map) {
		List<Review> list=null;
		try {
			list=dao.selectList("review.listReview",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteReview(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("review.deleteReview", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			}
		}
	
	@Override
	public int dataCount(int productNum) {
		int result=0;
		
		try{
			result=dao.selectOne("review.dataCount",productNum);			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public double reviewScore(int productNum) {
		double result=0;
		try {
			result=dao.selectOne("review.reviewScore", productNum);			
		}catch (Exception e) {
		}
		return result;
	}
}

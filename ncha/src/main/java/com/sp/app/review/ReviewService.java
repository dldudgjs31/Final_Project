package com.sp.app.review;

import java.util.List;
import java.util.Map;


public interface ReviewService {
	public void insertReview(Review dto) throws Exception;
	public List<Review> listReview(Map<String, Object> map);
	public void deleteReview(Map<String, Object> map) throws Exception;

}

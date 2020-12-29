package com.sp.app.store;

import java.util.List;
import java.util.Map;

public interface StoreService {
	//글등록
	public void insertProduct(Store dto, String pathname) throws Exception;
	public void insertFile(Store dto) throws Exception;
	public void insertOption(Store dto) throws Exception;
	
	// 글리스트
	public List<Store> listProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	//글보기 관련
	public Store readProduct(int num);
	public List<Store> readProductFile(int productNum) throws Exception;
	public List<Store> listFile(int productNum) throws Exception;
	
	public void updateHitCount(int num) throws Exception;
	public Store preReadProduct(Map<String, Object> map);
	public Store nextReadProduct(Map<String, Object> map);
	//글 수정
	public void updateProduct(Store dto) throws Exception;
	// 글삭제
	public void delete(int num, String sellerId)throws Exception;
	
}

package com.sp.app.store;

import java.util.List;
import java.util.Map;

import com.sp.app.customer.Customer;
import com.sp.app.store_profile.Option;

public interface StoreService {
	//글등록
	public void insertProduct(Store dto, String pathname) throws Exception;
	public void insertFile(Store dto) throws Exception;
	public void insertOption(Store dto) throws Exception;
	
	// 글리스트
	public List<Store> listProduct(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public String readCategoryName(String categoryNum)throws Exception;
	
	//글보기 관련
	public Store readProduct(int num);
	public List<Store> readProductFile(int productNum) throws Exception;
	public List<Store> listFile(int productNum) throws Exception;
	public void updateHitCount(int num) throws Exception;
	public Store preReadProduct(Map<String, Object> map);
	public Store nextReadProduct(Map<String, Object> map);
	public List<Store> readOption(int productNum) throws Exception;
	
	//글 수정
	public void updateProduct(Store dto) throws Exception;
	// 글삭제
	public void delete(int num, String sellerId)throws Exception;
	public void deleteImage(int main_imageFileNum) throws Exception;
	public void deleteOption(int optionNum) throws Exception;
	public void deleteAllOption(int productNum) throws Exception;
	public void deleteAllImage(int productNum) throws Exception;
	
	//커뮤니티 메인
	public Store readProduct();
	
	//판매자 재고 관리
	public List<Store> listMyProduct(Map<String, Object> map)throws Exception;
	public int dataCountMyproduct(Map<String, Object> map)throws Exception;
	public void updateMyStock(Map<String, Object> map)throws Exception;
	public void insertMyOption(Option dto)throws Exception;
	
	//판매자 메인페이지
	public int  dataMySoldCount(Map<String, Object> map)throws Exception;
	public int dataMyProductCount(Map<String, Object> map)throws Exception;
	public int readBestReviewProduct(Map<String, Object> map)throws Exception;
	public int readWorstReviewProduct(Map<String, Object> map)throws Exception;
	List<Customer> listRecentSoldProduct(Map<String, Object> map)throws Exception;
	
	//찜하기
	public void insertLike(Map<String, Object> map)throws Exception;
	public void deleteLike(Map<String, Object> map)throws Exception;
	public int checkLike(Map<String, Object> map)throws Exception;
	public int dataLikeCount(Map<String, Object> map)throws Exception;
	public int dataProductLikeCount(int productNum)throws Exception;
	public int dataStoreLikeCount(Map<String, Object> map)throws Exception;
	
	//스토어 찜하기
	public void insertStoreLike(Map<String, Object> map)throws Exception;
	public void deleteStoreLike(Map<String, Object> map)throws Exception;
	public int checkStoreLike(Map<String, Object> map)throws Exception;
	public int dataStoreFollowCount(String sellerId)throws Exception;
	public int dataMyStoreFollow(String userId)throws Exception;
	List<Customer> listFollow(Map<String, Object> map)throws Exception;
	
	//스토어 메인
	public List<Store> listTop3Follower()throws Exception;
	public List<Store> listTop3SalesStore() throws Exception;
	public Store readBestproduct(int categoryNum) throws Exception;
}

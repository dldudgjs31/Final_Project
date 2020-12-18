package com.sp.app.used;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Used {
	private int listNum; // 페이징처리
	private String userId;
	private String userName;
	
	private int usedNum; // 중고글 번호
	private String price; // 가격
	private String productCondition; // 제품 상태
	private String dealingMode; // 거래 방법
	private String location; // 지역
	private String subject; // 제목
	private String content; // 내용
	private String created_date; //글 작성날짜
	private int sold_check; // 판매완료 체크
	private int categoryNum; // 카테고리 번호
	private String categoryName;
	
	private int hitCount; // 조회수
	
	private int used_imageFileNum; // 중고글에 게시할 이미지 번호
	private String imageFilename; // 이미지 파일 이름
	private List<MultipartFile> upload; // 파일처리
	private int filecount;
	
	private int replyCount;    // 중고글 댓글 좋아요
	private int usedLikeCount; // 중고글 좋아요
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getUsedNum() {
		return usedNum;
	}
	public void setUsedNum(int usedNum) {
		this.usedNum = usedNum;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getProductCondition() {
		return productCondition;
	}
	public void setProductCondition(String productCondition) {
		this.productCondition = productCondition;
	}
	public String getDealingMode() {
		return dealingMode;
	}
	public void setDealingMode(String dealingMode) {
		this.dealingMode = dealingMode;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public int getSold_check() {
		return sold_check;
	}
	public void setSold_check(int sold_check) {
		this.sold_check = sold_check;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getUsed_imageFileNum() {
		return used_imageFileNum;
	}
	public void setUsed_imageFileNum(int used_imageFileNum) {
		this.used_imageFileNum = used_imageFileNum;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getUsedLikeCount() {
		return usedLikeCount;
	}
	public void setUsedLikeCount(int usedLikeCount) {
		this.usedLikeCount = usedLikeCount;
	}
	
	
	
	public int getFilecount() {
		return filecount;
	}
	public void setFilecount(int filecount) {
		this.filecount = filecount;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	
}

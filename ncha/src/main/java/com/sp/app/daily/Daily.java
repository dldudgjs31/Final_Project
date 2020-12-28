package com.sp.app.daily;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Daily {
	private int dailyNum;
	private int listNum;
	private String userName;
	private String userId;
	private String content;
	private String subject;
	private String storeUrl;
	private String usedUrl;
	private String created_date;
	private int hitCount;
	private int categoryNum; // 카테고리 번호
	private String categoryName;
	private int replyCount;
	
	
	private int answer;
	private int answerCount;
	private int dailyLikeCount;
	
	private List<MultipartFile> upload;
	
	
	private String imageFilename;
	private int daily_imageFilenum;
	private String profile_imageFilename;
	
	
	
	
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}

	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public void setProfile_imageFilename(String profile_imageFilename) {
		this.profile_imageFilename = profile_imageFilename;
	}
	public String getProfile_imageFilename() {
		return profile_imageFilename;
	}
	
	
	
	public int getAnswer() {
		return answer;
	}
	public void setAnswer(int answer) {
		this.answer = answer;
	}
	public int getAnswerCount() {
		return answerCount;
	}
	public void setAnswerCount(int answerCount) {
		this.answerCount = answerCount;
	}
	
	
	
	 
	public int getDailyLikeCount() {
		return dailyLikeCount;
	}
	public void setDailyLikeCount(int dailyLikeCount) {
		this.dailyLikeCount = dailyLikeCount;
	}
	public int getDailyNum() {
		return dailyNum;
	}
	public void setDailyNum(int dailyNum) {
		this.dailyNum = dailyNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	public String getStoreUrl() {
		return storeUrl;
	}
	public void setStoreUrl(String storeUrl) {
		this.storeUrl = storeUrl;
	}
	public String getUsedUrl() {
		return usedUrl;
	}
	public void setUsedUrl(String usedUrl) {
		this.usedUrl = usedUrl;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getDaily_imageFilenum() {
		return daily_imageFilenum;
	}
	public void setDaily_imageFilenum(int daily_imageFilenum) {
		this.daily_imageFilenum = daily_imageFilenum;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	
}

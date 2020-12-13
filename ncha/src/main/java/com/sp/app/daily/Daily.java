package com.sp.app.daily;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Daily {
	private int dailyNum;
	private int listNum;
	private String userId;
	private String content;
	private String subject;
	private String storeURL;
	private String usedURL;
	private String created_date;
	
	
	private int answer;
	private int answerCount;
	private int likeCount;
	
	private List<MultipartFile> upload;
	private int fileNum;
	private String imageFilename;
	private int daily_imageFilenum;
	private int fileCount;
	
	
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
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
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
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
	public String getStoreURL() {
		return storeURL;
	}
	public void setStoreURL(String storeURL) {
		this.storeURL = storeURL;
	}
	public String getUsedURL() {
		return usedURL;
	}
	public void setUsedURL(String usedURL) {
		this.usedURL = usedURL;
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



	
}

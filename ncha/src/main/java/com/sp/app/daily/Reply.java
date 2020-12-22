package com.sp.app.daily;

public class Reply {
	private int daily_replyNum;
	private int dailyNum;
	private String userId;
	private String userName;
	private String content;
	private String created_date;
	private int answer;
	
	public int getDailyNum() {
		return dailyNum;
	}

	public void setDailyNum(int dailyNum) {
		this.dailyNum = dailyNum;
	}

	private int answerCount;
	private int likeCount;
	private int disLikeCount;



	

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

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getDaily_replyNum() {
		return daily_replyNum;
	}

	public void setDaily_replyNum(int daily_replyNum) {
		this.daily_replyNum = daily_replyNum;
	}

	public String getCreated_date() {
		return created_date;
	}

	public void setCreated_date(String created_date) {
		this.created_date = created_date;
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

	public int getDisLikeCount() {
		return disLikeCount;
	}

	public void setDisLikeCount(int disLikeCount) {
		this.disLikeCount = disLikeCount;
	}
}

package com.sp.app.used;

public class Reply {
	
	//댓글
	private int used_reviewNum;
	private int usedNum;
	private String userId;
	private String userName;
	private String content;
	private String created_date;
	private int answer;
	
	//카운트
	private int answerCount; // 댓글
	private int likeCount;   // 좋아요
	public int getUsed_reviewNum() {
		return used_reviewNum;
	}
	public void setUsed_reviewNum(int used_reviewNum) {
		this.used_reviewNum = used_reviewNum;
	}
	public int getUsedNum() {
		return usedNum;
	}
	public void setUsedNum(int usedNum) {
		this.usedNum = usedNum;
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
}

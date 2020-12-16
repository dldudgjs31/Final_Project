package com.sp.app.review;


public class Review {
/*
 * -- 리뷰ok
CREATE TABLE product_review (
   reviewNum  NUMBER         NOT NULL, -- 리뷰번호
   userId     VARCHAR2(50)   NOT NULL, -- 유저아이디
   subject    VARCHAR2(250)  NOT NULL, -- 내용
   content    VARCHAR2(4000) NOT NULL, -- 제목
   productNum NUMBER         NOT NULL,  -- 상품번호(완료)
   created_date DATE DEFAULT SYSDATE NOT NULL,
   score NUMBER NOT NULL,
 parent
   CONSTRAINT pk_product_review PRIMARY KEY(reviewNum,userId),
   CONSTRAINT fk_product_review_userId FOREIGN KEY(userId)
                  REFERENCES member(userId) ON DELETE CASCADE,
   CONSTRAINT fk_product_review_productNum FOREIGN KEY(productNum)
                  REFERENCES product_bbs(productNum) ON DELETE CASCADE
);
 * 
 * */
	private int reviewNum , productNum;
	private String userId;
	private String subject;
	private String content;
	private String created_date;
	private int score;
	
	private String parent;

	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public int getProductNum() {
		return productNum;
	}

	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getParent() {
		return parent;
	}

	public void setParent(String parent) {
		this.parent = parent;
	}
	
	
}

package com.sp.app.seller;

import org.springframework.web.multipart.MultipartFile;

public class Seller {
	private String sellerId;
	private String sellerName;
	private String pwd;
	private String tel, tel1, tel2, tel3;
	private String email, email1, email2;
	private int enabled;
	private String created_date;
	private String modify_date;
	private int allow;
	
	private MultipartFile uploadphoto;
	private String profile_imageFilename;
	
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public int getEnabled() {
		return enabled;
	}
	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public String getModify_date() {
		return modify_date;
	}
	public void setModify_date(String modify_date) {
		this.modify_date = modify_date;
	}
	public int getAllow() {
		return allow;
	}
	public void setAllow(int allow) {
		this.allow = allow;
	}
	public String getProfile_imageFilename() {
		return profile_imageFilename;
	}
	public void setProfile_imageFilename(String profile_imageFilename) {
		this.profile_imageFilename = profile_imageFilename;
	}
	public MultipartFile getUploadphoto() {
		return uploadphoto;
	}
	public void setUploadphoto(MultipartFile uploadphoto) {
		this.uploadphoto = uploadphoto;
	}
	
	
	
}
/*
 * CREATE TABLE seller(
   sellerId                  VARCHAR2(50)   NOT NULL, -- 판매자아이디
   sellerName            VARCHAR2(50)   NOT NULL, -- 판매자이름
   pwd                   VARCHAR2(100)  NOT NULL, -- 판매자비밀번호
   tel                   VARCHAR2(20)   NOT NULL, -- 판매자전화번호
   email                 VARCHAR2(100)  NOT NULL, -- 판매자이메일
   enabled               NUMBER       NOT NULL, -- enabled
   created_date          DATE           NOT NULL, -- 가입일자
   modify_date           DATE           NULL,     -- 수정일자
   allow                 NUMBER         NOT NULL, -- allow(admin이 허용하면 1 아니면0
   profile_imageFilename VARCHAR2(1000) NULL ,      -- 판매자프로필사진
   CONSTRAINT pk_seller PRIMARY KEY(sellerId)
);

-- 판매자 시퀀스 ok
CREATE SEQUENCE profileFile_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOCYCLE
    NOCACHE;
 * */

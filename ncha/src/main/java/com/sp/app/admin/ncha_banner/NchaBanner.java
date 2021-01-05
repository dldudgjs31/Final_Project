package com.sp.app.admin.ncha_banner;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class NchaBanner {
	
	private int fileNum; //갯수제한	
	private String serverFilename; //서버에 저장되는 이름
	private List<MultipartFile> upload; // 파일처리

		
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public String getServerFilename() {
		return serverFilename;
	}
	public void setServerFilename(String serverFilename) {
		this.serverFilename = serverFilename;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}

}

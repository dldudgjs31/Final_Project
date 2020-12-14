package com.sp.app.seller;

// 세션에 저장할 정보(아이디, 이름, 권한등)
public class SessionInfo {
	private String sellerId;
	private String sellerName;
	
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	
}

package com.sp.app.store;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Store {
	private int productNum;
	private int listNum;
	private String productName;
	private String created_date;
	private int hitCount;
	private int price;
	private String detail;
	private int stock;
	private String sellerId;
	private String sellerName;
	private int categoryNum;
	private String categoryName;
	private int discount_rate;
	private String saveFilename;
	private String originalFilename;
	private int main_imageFileNum;
	private String imageFilename;
	private int optionNum;
	private String score;
	private int likeCount;
	
	private String opt_detail;
	private String opt_stock;
	private String profile_imagefilename;
	private List<MultipartFile> upload;
	private List<String> optionDetail;
	private List<Integer> option_stock;
	private List<Integer> option_number;
	private List<Store> optionlist;
	
	public String getSellerName() {
		return sellerName;
	}
	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public List<Integer> getOption_number() {
		return option_number;
	}
	public void setOption_number(List<Integer> option_number) {
		this.option_number = option_number;
	}
	public List<Store> getOptionlist() {
		return optionlist;
	}
	public void setOptionlist(List<Store> optionlist) {
		this.optionlist = optionlist;
	}
	public String getProfile_imagefilename() {
		return profile_imagefilename;
	}
	public void setProfile_imagefilename(String profile_imagefilename) {
		this.profile_imagefilename = profile_imagefilename;
	}
	public String getOpt_detail() {
		return opt_detail;
	}
	public void setOpt_detail(String opt_detail) {
		this.opt_detail = opt_detail;
	}
	public String getOpt_stock() {
		return opt_stock;
	}
	public void setOpt_stock(String opt_stock) {
		this.opt_stock = opt_stock;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getOptionNum() {
		return optionNum;
	}
	public void setOptionNum(int optionNum) {
		this.optionNum = optionNum;
	}
	public List<String> getOptionDetail() {
		return optionDetail;
	}
	public void setOptionDetail(List<String> optionDetail) {
		this.optionDetail = optionDetail;
	}
	public List<Integer> getOption_stock() {
		return option_stock;
	}
	public void setOption_stock(List<Integer> option_stock) {
		this.option_stock = option_stock;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public int getMain_imageFileNum() {
		return main_imageFileNum; 
	}
	public void setMain_imageFileNum(int main_imageFileNum) {
		this.main_imageFileNum = main_imageFileNum;
	}
	public String getImageFilename() {
		return imageFilename;
	}
	public void setImageFilename(String imageFilename) {
		this.imageFilename = imageFilename;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(int discount_rate) {
		this.discount_rate = discount_rate;
	}
	public int getProductNum() {
		return productNum;
	}
	public void setProductNum(int productNum) {
		this.productNum = productNum;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getCreated_date() {
		return created_date;
	}
	public void setCreated_date(String created_date) {
		this.created_date = created_date;
	}
	public int getHitCount() {
		return hitCount;
	}
	public void setHitCount(int hitCount) {
		this.hitCount = hitCount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getSellerId() {
		return sellerId;
	}
	public void setSellerId(String sellerId) {
		this.sellerId = sellerId;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	
}

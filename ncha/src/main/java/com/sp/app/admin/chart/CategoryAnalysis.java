package com.sp.app.admin.chart;

public class CategoryAnalysis {
	
	//카테고리매출분석
	private String section;
	private int total;
	
	//3년 매출분석
	private String OrderYear;
	private int clothes_total;
	private int electronics_total;
	private int necessaries_total;
	private int interior_total;
	
		
	public String getSection() {
		return section;
	}
	public void setSection(String section) {
		this.section = section;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String getOrderYear() {
		return OrderYear;
	}
	public void setOrderYear(String orderYear) {
		OrderYear = orderYear;
	}
	public int getClothes_total() {
		return clothes_total;
	}
	public void setClothes_total(int clothes_total) {
		this.clothes_total = clothes_total;
	}
	public int getElectronics_total() {
		return electronics_total;
	}
	public void setElectronics_total(int electronics_total) {
		this.electronics_total = electronics_total;
	}
	public int getNecessaries_total() {
		return necessaries_total;
	}
	public void setNecessaries_total(int necessaries_total) {
		this.necessaries_total = necessaries_total;
	}
	public int getInterior_total() {
		return interior_total;
	}
	public void setInterior_total(int interior_total) {
		this.interior_total = interior_total;
	}
}

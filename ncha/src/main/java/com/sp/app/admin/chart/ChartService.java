package com.sp.app.admin.chart;

import java.util.List;

public interface ChartService {
	public List<CategoryAnalysis> categorySalesList();
	public List<CategoryAnalysis> categoryYearSalesList();
	public List<CategoryAnalysis> storeSalesList();
	public List<CategoryAnalysis> storeYearSalesList();
	
	
	public List<SalesTable> salesList();
}

package com.sp.app.admin.chart;

import java.util.List;

public interface ChartService {
	public List<CategoryAnalysis> categorySalesList();
	public List<CategoryAnalysis> categoryYearSalesList();
	public List<StoreAnalysis> storeSalesList();
	public List<StoreAnalysis> storeYearSalesList();
	
	
	public List<SalesTable> salesList();
}

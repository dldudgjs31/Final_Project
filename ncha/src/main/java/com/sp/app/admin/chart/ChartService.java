package com.sp.app.admin.chart;

import java.util.List;
import java.util.Map;

public interface ChartService {
	public List<CategoryAnalysis> categorySalesList();
	public List<CategoryAnalysis> categoryYearSalesList();
	public List<StoreAnalysis> storeSalesList();
	public int dataCount(Map<String, Object> map);
	
	public List<String>getsellerId();
	public List<SalesTable> salesList(Map<String, Object> map);
}

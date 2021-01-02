package com.sp.app.admin.chart;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("admin.chart.chartService")
public class ChartServiceImpl implements ChartService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<CategoryAnalysis> categorySalesList() {
		List<CategoryAnalysis> list = null;
		
		try {
			list = dao.selectList("adminchart.categorySalesSection");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CategoryAnalysis> categoryYearSalesList() {
		List<CategoryAnalysis> list = null;
		
		try {
			list = dao.selectList("adminchart.categoryYearSalesSection");
			//System.out.println(list.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	

	@Override
	public List<StoreAnalysis> storeSalesList() {
		List<StoreAnalysis> list = null;
		
		try {
			list = dao.selectList("adminchart.storeSalesSection");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<StoreAnalysis> storeYearSalesList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SalesTable> salesList() {
		// TODO Auto-generated method stub
		return null;
	}

}

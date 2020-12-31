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
	public List<Analysis> categorySalesList() {
		List<Analysis> list = null;
		
		try {
			list = dao.selectList("admin.categorySalesSection");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}

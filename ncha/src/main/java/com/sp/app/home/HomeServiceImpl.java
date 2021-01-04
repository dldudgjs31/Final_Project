package com.sp.app.home;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("home.homeService")
public class HomeServiceImpl implements HomeService{
	@Autowired
	CommonDAO dao;
	
	@Override
	public List<CategoryCount> categoryCount() {
	List<CategoryCount> list = null;
		
		try {
			list = dao.selectList("home.categoryCount");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}

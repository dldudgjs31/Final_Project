package com.sp.app.admin.chart;

import java.util.List;
import java.util.Map;

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

	/*
	@Override
	public List<StoreAnalysis> storeYearSalesList() {
		List<StoreAnalysis> a = null;
		
		
		List<String>sellerId = new ArrayList<>();
		Calendar cal = Calendar.getInstance();
		int beforeyear = cal.get(Calendar.YEAR)-4;
		int currentyear  = cal.get(Calendar.YEAR);
		
		try {
			sellerId = dao.selectList("adminchart.getSellerId");
			
			//아이디별로 데이터 null값인거 0으로 저장하고, 형식에맞게 추출
			for(int i = 0; i<sellerId.size(); i++) {
				List<StoreAnalysis> list = new ArrayList<>();
				List<Integer> totallist = new ArrayList<>(); //아이디별 5년 매출데이터 집어넣을 배열
				
				String nowId = sellerId.get(i);
				list = dao.selectList("adminchart.storeSalesYearSection",nowId);
				System.out.println(nowId);
				System.out.println(list);
				
				if(list.size()<5 && list.size()>0) {
					
					for(int j = beforeyear; j<=currentyear; j++) {
						
						for(int k = 0; k<list.size(); k++) {
							if(j==list.get(k).getOrderYear()) {
								totallist.add(list.get(k).getTotal_sum());
								break;
							}else if(j != list.get(k).getOrderYear()) {
								totallist.add(0);
								break;
							}
						}
					}
					for(int j = 0; j<list.size(); j++) {
						int listyear = list.get(j).getOrderYear();
						
						for(int k = 0; k < 5; k++) {
							if(listyear!=currentyear) {
								totallist.add(0);
								currentyear++;
							}
							else {
								totallist.add(list.get(j).getTotal_sum());
								break;
							}
						}
					}
				}else if(list.size()==5){
					for(int j = 0; j<list.size(); j++) {
						totallist.add(list.get(j).getTotal_sum());
					}
				}else if(list.isEmpty()) {
					for(int j = 0; j<5; j++) {
						totallist.add(0);
					}
				}
				
				
				for(int j = 0; j<totallist.size(); j++) {
					System.out.print(totallist.get(j)+" ");
				}
					
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return a;
	}*/

	@Override
	public List<SalesTable> salesList(Map<String, Object> map) {
		List<SalesTable> st = null;
		try {
			st = dao.selectList("adminchart.getSalesList", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return st;
	}

	@Override
	public List<String> getsellerId() {
		List<String>Id = null;
		
		try {
			Id = dao.selectList("adminchart.getSellerId");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Id;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("adminchart.dataCount", map);
		} catch (Exception e) {
		}
		
		return result;
	}
}

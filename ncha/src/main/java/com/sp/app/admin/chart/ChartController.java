package com.sp.app.admin.chart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.chart.chartController")
@RequestMapping("/admin/chart/*")
public class ChartController {

	@Autowired
	private ChartService service;
	
	@RequestMapping(value="salesList")
	public String salesList() throws Exception{		
		
		return ".admin.chart.salesList";
	}
	
	
	@RequestMapping(value="category")
	public String categoryList() throws Exception{		
		
		return ".admin.chart.category";
	}
	@RequestMapping(value="categoryAnalysis", produces ="application/json;charset=utf-8")
	@ResponseBody
	public String categorySalesSection() throws Exception{		
		List<CategoryAnalysis> list = service.categorySalesList();
		JSONArray array = new JSONArray();
		JSONObject ob = new JSONObject();
		ob.put("name", "총 판매액");
		
		JSONArray jsonarr = new JSONArray();
		
		int allSales = 0;
		for(int i = 0; i<list.size(); i++) {
			System.out.println(i+ " : " + list.get(i).getTotal());
			allSales+=list.get(i).getTotal();
		}
		
		System.out.println(allSales);
		for(int i = 0; i<list.size(); i++) {
			List<Object>arr = new ArrayList<Object>();
			
			arr.add(list.get(i).getSection());
			arr.add(((double)list.get(i).getTotal()/(double)allSales)*100);
			//System.out.println(i+" : "+((double)list.get(i).getTotal()/(double)allSales)*100);
			jsonarr.put(new JSONArray(arr));
		}
		ob.put("data", jsonarr);
		
		
		array.put(ob);
		return array.toString(); 
	}
	
	
	@RequestMapping(value="categoryYearAnalysis")
	@ResponseBody
	public Map<String, Object> categoryYearSalesSection() throws Exception{		
		List<CategoryAnalysis> list = service.categoryYearSalesList();
		Map<String, Object> model = new HashMap<String, Object>();
		
		List<Map<String, Object>> datalist = new ArrayList<>();

		Map<String, Object>map = new HashMap<>();
		List<Integer>data = new ArrayList<>();
		map.put("name","의류");
		for(int i = 0; i<list.size(); i++) {
			data.add(list.get(i).getClothes_total());
		}
		map.put("data",data);
		datalist.add(map);
		
		
		map = new HashMap<>();
		data = new ArrayList<>();
		map.put("name","전자제품");
		for(int i = 0; i<list.size(); i++) {
			data.add(list.get(i).getElectronics_total());
		}
		map.put("data",data);
		datalist.add(map);
		
		
		map = new HashMap<>();
		data = new ArrayList<>();
		map.put("name","생필품");
		for(int i = 0; i<list.size(); i++) {
			data.add(list.get(i).getNecessaries_total());
		}
		map.put("data",data);
		datalist.add(map);
		
		
		map = new HashMap<>();
		data = new ArrayList<>();
		map.put("name","인테리어 가구");
		for(int i = 0; i<list.size(); i++) {
			data.add(list.get(i).getInterior_total());
		}
		map.put("data",data);
		datalist.add(map);
		
		int currentyear = Integer.parseInt(list.get(list.size()-1).getOrderYear());
		System.out.println(currentyear);
		
		model.put("currentyear",currentyear);
		model.put("series",datalist);
		
		return model;
	}
	
	
	@RequestMapping(value="store")
	public String store() throws Exception{		
		
		return ".admin.chart.store";
	}
	@RequestMapping(value="storeAnalysis", produces ="application/json;charset=utf-8")
	@ResponseBody
	public String storeSalesSection() throws Exception{		
		List<StoreAnalysis> list = service.storeSalesList();
		JSONArray array = new JSONArray();
		JSONObject ob = new JSONObject();
		ob.put("name", "총 판매액");
		
		JSONArray jsonarr = new JSONArray();
		
		int allSales = 0;
		for(int i = 0; i<list.size(); i++) {
			System.out.println(i+ " : " + list.get(i).getTotal_sum());
			allSales+=list.get(i).getTotal_sum();
		}
		
		System.out.println(allSales);
		for(int i = 0; i<list.size(); i++) {
			List<Object>arr = new ArrayList<Object>();
			
			arr.add(list.get(i).getSellerId());
			arr.add(((double)list.get(i).getTotal_sum()/(double)allSales)*100);
			
			jsonarr.put(new JSONArray(arr));
		}
		ob.put("data", jsonarr);
		
		array.put(ob);
		return array.toString(); 
	}
}

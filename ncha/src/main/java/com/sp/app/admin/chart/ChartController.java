package com.sp.app.admin.chart;

import java.util.ArrayList;
import java.util.List;

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
	
	@RequestMapping("analysis")
	public String analysis() throws Exception {
		return ".admin.chart.analysis";
	}
	
	
	@RequestMapping(value="categoryAnalysis", produces ="application/json;charset=utf-8")
	@ResponseBody
	public String categorySalesSection() throws Exception{		
		List<Analysis> list = service.categorySalesList();
		JSONArray array = new JSONArray();
		JSONObject ob = new JSONObject();
		ob.put("name", "카테고리");
		
		JSONArray jsonarr = new JSONArray();
		for(int i = 0; i<list.size(); i++) {
			List<Object>arr = new ArrayList<Object>();
			
			arr.add(list.get(i).getSection());
			arr.add(list.get(i).getTotal());
	
			jsonarr.put(new JSONArray(arr));
		}
		ob.put("data", jsonarr);
		
		
		array.put(ob);
		return array.toString(); 
	}
}

package com.sp.app.home;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("mainChart.mainChartController")
@RequestMapping("/mainChart/*")
public class MainChartController {
	
	@Autowired
	private HomeService service;
	
	@RequestMapping(value="categoryCount", produces ="application/json;charset=utf-8")
	@ResponseBody
	public String categoryCount() throws Exception{		
		List<CategoryCount> list = service.categoryCount();
		JSONArray array = new JSONArray();
		JSONObject ob = new JSONObject();
		ob.put("name", "총 게시글");
		
		JSONArray jsonarr = new JSONArray();
		
		int allCount = 0;
		for(int i = 0; i<list.size(); i++) {
			System.out.println(i+ " : " + list.get(i).getTotal());
			allCount+=list.get(i).getTotal();
		}
		
		System.out.println(allCount);
		for(int i = 0; i<list.size(); i++) {
			List<Object>arr = new ArrayList<Object>();
			
			arr.add(list.get(i).getSection());
			arr.add(((double)list.get(i).getTotal()/(double)allCount)*100);
			jsonarr.put(new JSONArray(arr));
		}
		ob.put("data", jsonarr);

		array.put(ob);
		
		return array.toString(); 
	}
}

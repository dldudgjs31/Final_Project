package com.sp.app.admin.chart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;

@Controller("admin.chart.chartController")
@RequestMapping("/admin/chart/*")
public class ChartController {

	@Autowired
	private ChartService service;
	@Autowired
	private MyUtil myUtil;

	
	@RequestMapping(value="salesList")
	public String salesList(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception{	
		
		int rows = 20;
		int dataCount, total_page;

		Map<String, Object> map = new HashMap<>();
		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<SalesTable>list = service.salesList(map);
		int listNum, n=0;
		for(SalesTable dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/admin/chart/salesList";

	
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

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
			allSales+=list.get(i).getTotal();
		}
		
		for(int i = 0; i<list.size(); i++) {
			List<Object>arr = new ArrayList<Object>();
			
			arr.add(list.get(i).getSection());
			arr.add(((double)list.get(i).getTotal()/(double)allSales)*100);

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
			allSales+=list.get(i).getTotal_sum();
		}
	
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
	
	/*
	@RequestMapping(value="storeYearAnalysis")
	@ResponseBody
	public Map<String, Object> storeYearSalesSection() throws Exception{		
		Map<String, Object> model = new HashMap<String, Object>();
		List<StoreAnalysis> list = service.storeYearSalesList();
		
		model.put("data", list);
	
		return model;
	}*/
}

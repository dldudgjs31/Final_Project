package com.sp.app.store_profile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.customer.Customer;
import com.sp.app.customer.CustomerService;
import com.sp.app.seller.SessionInfo;
import com.sp.app.qna.Qna;
import com.sp.app.qna.QnaService;

@Controller("store_profile.profileController")
@RequestMapping("/store/mypage/*")
public class ProfileController {
	
		@Autowired
		QnaService service;
		@Autowired
		private MyUtil myUtil;
		@Autowired
		CustomerService service2;
		
		@RequestMapping("main")
		public String mypageMain()throws Exception{
			
			return ".store.mypage.main";
		}
		
		@RequestMapping("qna")
		public String mypageQna(
				@RequestParam(value = "page", defaultValue = "1") int current_page,
				HttpSession session,
				HttpServletRequest req,
				Model model
				)throws Exception{
			SessionInfo info = (SessionInfo)session.getAttribute("seller");
			Map<String, Object> map = new HashedMap<>();
			map.put("sellerId", info.getSellerId());
			int rows= 10;
			int dataCount = service.dataSellerQnaCount(map);
			int total_page = myUtil.pageCount(rows, dataCount);
			if (dataCount != 0) {
				total_page = myUtil.pageCount(rows, dataCount);
			}
			if (total_page < current_page) {
				current_page = total_page;
			}
			int offset = (current_page - 1) * rows;
			if (offset < 0)
				offset = 0;
			map.put("offset", offset);
			map.put("rows", rows);
			List<Qna> qnaList = service.listSellerQna(map);
			int listNum=0; 
			int n = 0;
			for (Qna dto : qnaList) {
				listNum = dataCount - (offset + n);
				dto.setListNum(listNum);
				if(dto.getEnabled()==0) {
					dto.setStatus("답변대기");
				}else if(dto.getEnabled()==1){
					dto.setStatus("답변완료");
				}
				n++;
			}
			String cp = req.getContextPath();
			String listUrl = cp + "/store/mypage/qna";
			String articleUrl = cp + "/qna/article?page=" + current_page;
			String paging = myUtil.paging(current_page, total_page, listUrl);
			model.addAttribute("page",current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("paging", paging);
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("articleUrl", articleUrl);
			
			
			return".store.mypage.qna_list";
		}
		
		@RequestMapping("saleslist")
		public String buylist(
				@RequestParam(value = "page", defaultValue = "1") int current_page,
				@RequestParam(defaultValue = "") String startdate,
				@RequestParam(defaultValue = "") String enddate, 
				@RequestParam(defaultValue = "0") int categoryNum,
				HttpSession session,
				HttpServletRequest req,
				Model model
				) throws Exception{
			SessionInfo info =(SessionInfo)session.getAttribute("seller");
			
			int rows = 10;
			int total_page = 0;
			int dataCount = 0;
			Map<String, Object> map = new HashMap<>();
			map.put("startdate", startdate);
			map.put("enddate", enddate);
			map.put("categoryNum", categoryNum);
			map.put("sellerId",info.getSellerId());
			dataCount = service2.dataOrderCount(map);
			if (dataCount != 0) {
				total_page = myUtil.pageCount(rows, dataCount);
			}
			if (total_page < current_page) {
				current_page = total_page;
			}
			int offset = (current_page - 1) * rows;
			if (offset < 0)
				offset = 0;
			map.put("offset", offset);
			map.put("rows", rows);
			List<Customer> reviewList = service2.readOrderList(map);
			int listNum=0; 
			int n = 0;
			int sumSales = service2.readTotalSales(map);
			int total_Sales=0;
			for (Customer dto : reviewList) {
				listNum = dataCount - (offset + n);
				dto.setListNum(listNum);
				total_Sales += dto.getTotal_sales();
				n++;
			}

			String cp = req.getContextPath();
			String listUrl = cp + "/store/mypage/saleslist";
			String paging = myUtil.paging(current_page, total_page, listUrl);
			model.addAttribute("sumSales", sumSales);
			model.addAttribute("total_Sales", total_Sales);
			model.addAttribute("startdate", startdate);
			model.addAttribute("enddate", enddate);
			model.addAttribute("categoryNum", categoryNum);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("paging", paging);
			model.addAttribute("list", reviewList);
		return ".store.mypage.sales_list";
		}
}

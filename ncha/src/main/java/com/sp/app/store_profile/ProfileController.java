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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.customer.Customer;
import com.sp.app.customer.CustomerService;
import com.sp.app.seller.SessionInfo;
import com.sp.app.store.Store;
import com.sp.app.store.StoreService;
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
		@Autowired
		StoreService service3;
		
		@RequestMapping("main")
		public String mypageMain(
				HttpSession session,
				Model model
				)throws Exception{
			try {
				SessionInfo info = (SessionInfo)session.getAttribute("seller");
				Map<String, Object> map = new HashMap<>();
				map.put("sellerId", info.getSellerId());
				//판매총액
				int total_sales=0;
				total_sales=service2.readTotalSales(map);
				
				//판매 총 수량
				int total_salesCount=0;
				total_salesCount=service3.dataMySoldCount(map);
				//판매중인 상품수량
				int recent_sale=0;
				recent_sale=service3.dataMyProductCount(map);
				
				//품절 상품 수량 
				map.put("stock", 0);
				int soldout_product =service3.dataMyProductCount(map);
				
				//qna 개수
				int allQna =service2.dataMyAllQnaCount(map);
				int yetQna = service2.dataMyQnaEnabledCount(map);
				
				//찜하기 수
				int likeCount = service3.dataStoreLikeCount(map);
				
				//최근 판매된 상품
				List<Customer> list = service3.listRecentSoldProduct(map);
				 
				model.addAttribute("total_sales", total_sales); 
				model.addAttribute("total_salesCount", total_salesCount); 
				model.addAttribute("recent_sale", recent_sale); 
				model.addAttribute("soldout_product", soldout_product); 
				model.addAttribute("allQna", allQna); 
				model.addAttribute("yetQna", yetQna); 
				model.addAttribute("list", list); 
				model.addAttribute("likeCount", likeCount); 
				model.addAttribute("sellerId", info.getSellerId()); 
			} catch (Exception e) {
				e.printStackTrace();
			}
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
			model.addAttribute("sellerId", info.getSellerId());
			
			
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
			model.addAttribute("seller", info.getSellerId());
		return ".store.mypage.sales_list";
		}
		@RequestMapping("stockupdate")
		public String stockupdate(
				@RequestParam(value = "page", defaultValue = "1") int current_page,
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
			map.put("categoryNum", categoryNum);
			map.put("sellerId",info.getSellerId());
			dataCount = service3.dataCountMyproduct(map);
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
			List<Store> list = service3.listMyProduct(map);
			int listNum=0; 
			int n = 0;
			for (Store dto : list) {
				listNum = dataCount - (offset + n);
				dto.setListNum(listNum);
				List<Store> optionlist = service3.readOption(list.get(n).getProductNum());
				dto.setOptionlist(optionlist);
				n++;
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/store/mypage/stockupdate";
			String paging = myUtil.paging(current_page, total_page, listUrl);
			model.addAttribute("categoryNum", categoryNum);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("paging", paging);
			model.addAttribute("list", list);
			model.addAttribute("seller", info.getSellerId());
			return ".store.mypage.stock_update";
		}
		@RequestMapping("stock_update")
		@ResponseBody
		public Map<String, Object>  stock_updateSubmit(
				Store dto,
				HttpSession session
				)throws Exception{
			String state="true";
			SessionInfo info=(SessionInfo)session.getAttribute("seller");
					
			try {
				Map<String, Object> map = new HashMap<>();
				map.put("productNum", dto.getProductNum());
				//전체 재고 업데이트
				int stock = 0;
				for(int i =0; i<dto.getOption_stock().size();i++) {
					stock += dto.getOption_stock().get(i);
				}
				map.put("stock", stock);
				service3.updateMyStock(map);
				//옵션 모두 삭제
				service3.deleteAllOption(dto.getProductNum());
				//옵션 등록
				Option opt_dto = new Option();
				for(int i =0; i<dto.getOption_stock().size();i++) {
					//옵션 재고
					opt_dto.setOption_stock(dto.getOption_stock().get(i));
					opt_dto.setOptionDetail(dto.getOptionDetail().get(i));
					opt_dto.setProductNum(dto.getProductNum());
					service3.insertMyOption(opt_dto);
				}
				
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> model=new HashedMap<>();
			model.put("state", state);
			return model;
		}
}

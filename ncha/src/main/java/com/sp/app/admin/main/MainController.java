package com.sp.app.admin.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.app.count.CountManager;
import com.sp.app.member.MemberService;
import com.sp.app.seller.SellerService;
import com.sp.app.store.StoreService;

@Controller("admin.mainController")
public class MainController {
	@Autowired 
	private SellerService service;
	
	@Autowired 
	private MemberService service1;
	
	@Autowired 
	private StoreService service2;
	
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminHome(Model model) {
		int count = 0;  
		int count1 = 0;  
		int sales = 0;  
		int sales1 = 0;  
		try {
			count = service.sellerCount();
			count1 = service1.memberCount();
			sales = service2.totalSales();
			sales1 = service2.totalSales2();
		} catch (Exception e) {
		}
		  int currentCount;
		  long toDayCount, yesterDayCount, totalCount;
		 
		  currentCount = CountManager.getCurrentCount();
		  toDayCount = CountManager.getTodayCount();
		  yesterDayCount = CountManager.getYesterDayCount();
		  totalCount = CountManager.getTotalCount();
		  
		  model.addAttribute("count",count);
		  model.addAttribute("count1",count1);
		  model.addAttribute("sales",sales);
		  model.addAttribute("sales1",sales1);
		  model.addAttribute("currentCount",currentCount);
		  model.addAttribute("toDayCount",toDayCount);
		  model.addAttribute("yesterDayCount",yesterDayCount);
		  model.addAttribute("totalCount",totalCount);
		  
		return ".admin.main.main";
	}
	
	/**
	 * 회원관리 페이지( 일반 / 판매 선택)
	 */
	
	@RequestMapping("/admin/member")
	public String memberManagement() {
		return ".admin.member_management";
	}
	
	/**
	 * 전체게시글 관리 페이지(중고/ 일상글 선택)
	 */
	@RequestMapping("/admin/article")
	public String articleManagement() {
		return ".admin.article_management";
	}
	
	
	/**
	 * 이벤트 신청 관리 페이지
	 */
	@RequestMapping("/admin/event")
	public String event() {
		return ".admin.event";
	}
	
	/**
	 * 공지사항 관리 페이지 (필요할까 싶긴해!)
	 */
	
	@RequestMapping("/admin/notice")
	public String noticeManagement() {
		return ".admin.notice_management";
	}
}

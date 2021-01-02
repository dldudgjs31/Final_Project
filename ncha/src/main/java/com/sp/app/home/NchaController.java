package com.sp.app.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.app.customer.CustomerService;
import com.sp.app.daily.Daily;
import com.sp.app.daily.DailyService;
import com.sp.app.store.Store;
import com.sp.app.store.StoreService;
import com.sp.app.used.Used;
import com.sp.app.used.UsedService;

@Controller
public class NchaController {
	@Autowired
	CustomerService service;
	@Autowired
	private StoreService service1;
	@Autowired
	private DailyService service2;
	@Autowired
	private UsedService service3;
	
	/**
	 * n-cha 중고거래 파트 메인 페이지(home)
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		Store storeRank = null;
		  Daily dailyRank = null; 
		  Used usedRank = null;
		  Daily dailyRank1 = null; 
		  Used usedRank1 = null;
		 

		  
		  try {
			  storeRank = service1.readProduct();
			  dailyRank = service2.readDailyHit();
			  usedRank = service3.readUsedHit();
			  
			  dailyRank1 = service2.readDailyLike();
			  usedRank1 = service3.readUsedLike();
		} catch (Exception e) {
		}
		 
		  
		  model.addAttribute("storeRank", storeRank);
		  model.addAttribute("dailyRank",dailyRank); 
		  model.addAttribute("usedRank", usedRank);
		  model.addAttribute("dailyRank1",dailyRank1); 
		  model.addAttribute("usedRank1", usedRank1);
		
		return ".ncha_bbs.main.main";
	}
	
	/**
	 * 글올리기 페이지( 중고 / 일상글 선택)
	 * @return
	 */
	@RequestMapping("/ncha/write")
	public String createdList() {
		
		return ".ncha_bbs.main.createdList";
	}
	/**
	 * 스토어 파트 메인 페이지
	 * @return
	 */
	@RequestMapping("/store/main")
	public String storeHome() {
		
		return ".store.main.main";
	}
	
	@RequestMapping("/ncha/member")
	public String member() {
		return ".member.new_member";
	}
	@RequestMapping("/ncha/login")
	public String login() {
		return ".member.login_select";
	}
	@RequestMapping("/ncha/login_1")
	public String login1() {
		return "member/login";
	}
	@RequestMapping("/ncha/login_2")
	public String login2() {
		return "member/login_store";
	}
	
	
}

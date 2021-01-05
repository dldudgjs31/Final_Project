package com.sp.app.home;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sp.app.admin.ncha_banner.NchaBanner;
import com.sp.app.admin.ncha_banner.NchaBannerService;
import com.sp.app.admin.storebanner.StoreBanner;
import com.sp.app.admin.storebanner.StoreBannerService;
import com.sp.app.count.CountManager;
import com.sp.app.customer.CustomerService;
import com.sp.app.daily.Daily;
import com.sp.app.daily.DailyService;
import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.store.Store;
import com.sp.app.store.StoreService;
import com.sp.app.used.Used;
import com.sp.app.used.UsedService;

@Controller
public class NchaController{
	
	@Autowired
	CustomerService service;
	@Autowired
	private StoreService service1;
	@Autowired
	private DailyService service2;
	@Autowired
	private UsedService service3;
	@Autowired
	private MemberService service4;
	@Autowired
	private StoreBannerService service5;
	@Autowired
	private NchaBannerService service6;
	
	/**
	 * n-cha 중고거래 파트 메인 페이지(home)
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model,
			HttpServletRequest req,
			HttpServletResponse resp) {
		
		 Store storeRank = null;
		  Daily dailyRank = null; 
		  Used usedRank = null;
		  
		  Daily dailyRank1 = null; 
		  Used usedRank1 = null;
		  
		  List<Daily> dailyRank2 = null;
		  List<Used> usedRank2 = null;
		  
		  List<Member> list = service4.rankFollower();
		  List<NchaBanner>bannerlist = service6.listFile();
		  
		  System.out.println("bl:" +bannerlist.size());
		  
		  try {
			  storeRank = service1.readProduct();
			  dailyRank = service2.readDailyHit();
			  usedRank = service3.readUsedHit();
			  
			  dailyRank1 = service2.readDailyLike();
			  usedRank1 = service3.readUsedLike();
	
			  dailyRank2 = service2.readDailyHit2();
			  usedRank2 = service3.readUsedHit2();

		} catch (Exception e) {
		}
		  
		  
		  
		  
		   int currentCount;
		   long toDayCount, yesterDayCount, totalCount;
		 
		   currentCount = CountManager.getCurrentCount();
		   toDayCount = CountManager.getTodayCount();
		   yesterDayCount = CountManager.getYesterDayCount();
		   totalCount = CountManager.getTotalCount();
		   
		  model.addAttribute("currentCount",currentCount);
		  model.addAttribute("toDayCount",toDayCount);
		  model.addAttribute("yesterDayCount",yesterDayCount);
		  model.addAttribute("totalCount",totalCount);
		  model.addAttribute("listFollower",list);
		  model.addAttribute("storeRank", storeRank);
		  model.addAttribute("dailyRank",dailyRank); 
		  model.addAttribute("usedRank", usedRank);
		  model.addAttribute("usedRank2", usedRank2);
		  model.addAttribute("dailyRank1",dailyRank1); 
		  model.addAttribute("dailyRank2",dailyRank2); 
		  model.addAttribute("usedRank1", usedRank1);
		  model.addAttribute("usedRank2", usedRank2);
		  model.addAttribute("bannerlist",bannerlist);
		  
		  
		
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
	public String storeHome(
			HttpSession session,
			Model model) throws Exception{
		
		List<StoreBanner>list = service5.listFile();
	
		model.addAttribute("list",list);
		
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

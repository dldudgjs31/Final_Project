package com.sp.app.profile;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.MyUtil;
import com.sp.app.daily.Daily;
import com.sp.app.daily.DailyService;
import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;
import com.sp.app.used.Used;
import com.sp.app.used.UsedService;

@Controller("profile.profileController")
@RequestMapping("/mypage/*")
public class profileController {
	@Autowired
	private MemberService service;
	@Autowired
	private DailyService service1;
	@Autowired
	private UsedService service2;
	
	@Autowired
	private MyUtil myUtil;
	
	
	
	@RequestMapping("profile")
	public String profile(
			@RequestParam(value="page", defaultValue="1") int current_page1,
			@RequestParam(value="page", defaultValue = "1") int current_page2,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readProfile(info.getUserId());
		dto.setUserId1(info.getUserId());
		dto.setUserId2(info.getUserId());
		model.addAttribute("dto", dto);
		///// 여까지 프로필 정보 
		
		int rows = 7; 
		int total_page1 = 0;
		int dataCount1 = 0;
	
		 Map<String, Object>map = new HashMap<>();
		 dataCount1 = service.dataCount(map);
	 	 
        if(dataCount1 != 0)
            total_page1 = myUtil.pageCount(rows,  dataCount1) ;
        
        if(total_page1 < current_page1) 
            current_page1 = total_page1;

        int offset = (current_page1-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Daily> list1 = service1.listDaily(map);
    
        int listNum1, n = 0;
        for(Daily dto1 : list1) {
            listNum1 = dataCount1 - (offset + n);
            dto1.setListNum(listNum1);
            n++;
        }
        
        String cp=req.getContextPath();

        String listUrl1 = cp+"/daily/list";
        String query1 = "";
        String articleUrl1 = cp+"/daily/article?page=" + current_page1;
        
        
        if(query1.length()!=0) {
			listUrl1+="?"+query1;
			articleUrl1+="&"+query1;
		}
        String paging1 = myUtil.paging(current_page1, total_page1, listUrl1);
       
        
		model.addAttribute("mode", "mypage");
		model.addAttribute("list1", list1);
		model.addAttribute("page1", current_page1);
		model.addAttribute("dataCount1", dataCount1);
		model.addAttribute("total_page1", total_page1);
		model.addAttribute("paging1", paging1);		
		model.addAttribute("articleUrl1", articleUrl1);
		/////// 여기까지    일상글 리스트 불러오기 
	
		
	
		int total_page2=0;
		int dataCount2=0;
		
		Map<String, Object> map2 = new HashMap<String,Object>();
	
		dataCount2 = service.dataCount(map2); //데이터 갯수 가져옴
		
		if(dataCount2!=0) { 
			total_page2=myUtil.pageCount(rows, dataCount2); //전체 페이지수 계산
		}
		
		
		if(total_page2<current_page2) {
			current_page2=total_page2;
		}
		
		int offset2=(current_page2-1)*rows;
		if(offset2<0) offset2=0;
		map.put("offset2", offset2);
		map.put("rows", rows);
		
		List<Used> list2 =service2.listUsed_mypage(map2);
		
		int listNum2, n2=0;
		for(Used dto2:list2) {
			listNum2=dataCount2-(offset2+n2);
			dto2.setListNum(listNum2);
			n2++;
		}
		
		String cp2 =req.getContextPath();
		String query2 = "";
		String listUrl2= cp2+"/used/list";
		String articleUrl2=cp2+"/used/article?page="+current_page2;
		
		
		
		if(query2.length()!=0) { //검색조건이 있는 경우
			listUrl2 += "?" + query2;
			articleUrl2 += "&"+query2;
		}
		
		String paging2 = myUtil.paging(current_page2, total_page2, listUrl2);
		
		
		model.addAttribute("list2", list2);
		model.addAttribute("page2", current_page2);
		model.addAttribute("dataCount2", dataCount2);
		model.addAttribute("total_page2", total_page2);
		model.addAttribute("paging2", paging2);
		model.addAttribute("articleUrl2",articleUrl2);
		////////////////////여기가지가 중고글불러오기
		
		return ".ncha_bbs.main.mypage";
	}
	
	
	@RequestMapping("profileUpdate")
	public String profileUpdate(
			Member dto,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session) throws Exception{
		//String root = session.getServletContext().getRealPath("/");
		//String pathname = root+"uploads"+File.separator+"member";
		
		//service.updateProfile(dto,pathname);
		model.addAttribute("dto", dto);
		
		return ".ncha_bbs.main.profile_update";
	}
	
	@RequestMapping("followerList")
	public String followerList(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue="") String keyword,
			Member dto1,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 8;
		int total_page=0;
		int dataCount=0;
		Map<String, Object> map = new HashMap<>();
		
		if(dto1.getUserId() == null || dto1.getUserId() == "") {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dataCount = service.FollowingCount(info.getUserId());
			map.put("userId", info.getUserId());
		} else {
			dataCount = service.FollowerCount(dto1.getUserId());
			map.put("userId", dto1.getUserId());
		}
		
		if(dataCount!=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		if(total_page<current_page) {
			current_page=total_page;
		}
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		map.put("keyword", keyword);
		
		
		List<Member> list =service.listFollower(map);
		
		int listNum, n=0;
		for(Member dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp =req.getContextPath();
		String listUrl= cp+"/ncha_bbs/main/followerList";
		
		if(keyword.length()!=0) {
			listUrl+="?keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		return ".ncha_bbs.main.followerList";
	}
	
	@RequestMapping("followingList")
	public String followingList(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Member dto1,
			HttpSession session,
			Model model
			) throws Exception{
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "utf-8");
		}
		
		int rows = 10;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		
		if(dto1.getUserId() == null || dto1.getUserId() == "") {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dataCount = service.FollowingCount(info.getUserId());
			map.put("userId", info.getUserId());
		} else {
			dataCount = service.FollowerCount(dto1.getUserId());
			map.put("userId", dto1.getUserId());
		}
		
		if(dataCount!=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		if(total_page<current_page) {
			current_page=total_page;
		}
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		map.put("keyword", keyword);
		
		List<Member> list =service.listFollowing(map);
		
		int listNum, n=0;
		for(Member dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp =req.getContextPath();
		String listUrl= cp+"/ncha_bbs/main/followingList";
		
		if(keyword.length()!=0) {
			listUrl+="?keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		return ".ncha_bbs.main.followingList";
	}
	
	@RequestMapping("deleteFollower")
	public String delete1(
			@RequestParam String userId1,
			@RequestParam String userId2,
			@RequestParam String page
			) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId1", userId1);
			map.put("userId2", userId2);			

			service.deleteFollower(map);
		} catch (Exception e) {
		}

		return "redirect:/mypage/followerList?page="+page;
	}

	@RequestMapping("deleteFollowing")
	public String delete2(
			@RequestParam String userId1,
			@RequestParam String userId2,
			@RequestParam String page
			) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("userId1", userId1);
			map.put("userId2", userId2);			

			service.deleteFollower(map);
		} catch (Exception e) {
		}

		return "redirect:/mypage/followingList?page="+page;
	}
	
	@RequestMapping("searchProfile")
	public String searchProfile(
			@RequestParam(value="page", defaultValue="1") int current_page1,
			@RequestParam(value="page", defaultValue = "1") int current_page2,
			@RequestParam String userId,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readProfile(userId);
		dto.setUserId1(info.getUserId());
		dto.setUserId2(info.getUserId());
		model.addAttribute("dto", dto);
		///// 여까지 프로필 정보 
		
		int rows = 7; 
		int total_page1 = 0;
		int dataCount1 = 0;
	
		 Map<String, Object>map = new HashMap<>();
		 dataCount1 = service.dataCount(map);
	 	 
        if(dataCount1 != 0)
            total_page1 = myUtil.pageCount(rows,  dataCount1) ;
        
        if(total_page1 < current_page1) 
            current_page1 = total_page1;

        int offset = (current_page1-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
        
        List<Daily> list1 = service1.listDaily(map);
    
        int listNum1, n = 0;
        for(Daily dto1 : list1) {
            listNum1 = dataCount1 - (offset + n);
            dto1.setListNum(listNum1);
            n++;
        }
        
        String cp=req.getContextPath();

        String listUrl1 = cp+"/daily/list";
        String query1 = "";
        String articleUrl1 = cp+"/daily/article?page=" + current_page1;
        
        
        if(query1.length()!=0) {
			listUrl1+="?"+query1;
			articleUrl1+="&"+query1;
		}
        String paging1 = myUtil.paging(current_page1, total_page1, listUrl1);
       
        
		model.addAttribute("mode", "mypage");
		model.addAttribute("list1", list1);
		model.addAttribute("page1", current_page1);
		model.addAttribute("dataCount1", dataCount1);
		model.addAttribute("total_page1", total_page1);
		model.addAttribute("paging1", paging1);		
		model.addAttribute("articleUrl1", articleUrl1);
		/////// 여기까지    일상글 리스트 불러오기 
	
		
	
		int total_page2=0;
		int dataCount2=0;
		
		Map<String, Object> map2 = new HashMap<String,Object>();
	
		dataCount2 = service.dataCount(map2); //데이터 갯수 가져옴
		
		if(dataCount2!=0) { 
			total_page2=myUtil.pageCount(rows, dataCount2); //전체 페이지수 계산
		}
		
		
		if(total_page2<current_page2) {
			current_page2=total_page2;
		}
		
		int offset2=(current_page2-1)*rows;
		if(offset2<0) offset2=0;
		map.put("offset2", offset2);
		map.put("rows", rows);
		
		List<Used> list2 =service2.listUsed_mypage(map2);
		
		int listNum2, n2=0;
		for(Used dto2:list2) {
			listNum2=dataCount2-(offset2+n2);
			dto2.setListNum(listNum2);
			n2++;
		}
		
		String cp2 =req.getContextPath();
		String query2 = "";
		String listUrl2= cp2+"/used/list";
		String articleUrl2=cp2+"/used/article?page="+current_page2;
		
		
		
		if(query2.length()!=0) { //검색조건이 있는 경우
			listUrl2 += "?" + query2;
			articleUrl2 += "&"+query2;
		}
		
		String paging2 = myUtil.paging(current_page2, total_page2, listUrl2);
		
		
		model.addAttribute("list2", list2);
		model.addAttribute("page2", current_page2);
		model.addAttribute("dataCount2", dataCount2);
		model.addAttribute("total_page2", total_page2);
		model.addAttribute("paging2", paging2);
		model.addAttribute("articleUrl2",articleUrl2);
		////////////////////여기가지가 중고글불러오기
		
//		return "redirect:/mypage/searchProfile";
		return ".ncha_bbs.main.mypage";
	}
	
	@RequestMapping("follow")
	public String follow(
			@RequestParam String userId,
			HttpSession session
			) throws Exception {
		try {
			Map<String, Object> map = new HashMap<>();
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			map.put("sessionId", info.getUserId());	
			map.put("userId", userId);	
			
			service.insertFollow(map);
		} catch (Exception e) {
		}

		return "redirect:/mypage/searchProfile?userId="+userId;
	}
}

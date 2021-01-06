package com.sp.app.admin.list;

import java.io.File;
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

import com.sp.app.common.MyUtil;
import com.sp.app.event.Event;
import com.sp.app.member.Member;
import com.sp.app.member.SessionInfo;
import com.sp.app.notice.Notice;
import com.sp.app.seller.Seller;

@Controller("admin.list.listController")
@RequestMapping("/admin/list/*")
public class ListController {
	@Autowired
	private ListService service;

	@Autowired
	private MyUtil myUtil;

	@RequestMapping("member")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpServletRequest req, Model model) throws Exception {
		int rows = 10;
		int dataCount, total_page;

		Map<String, Object> map = new HashMap<>();
		dataCount = service.dataCountMember(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page) {
			current_page = total_page;
		}

		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Member> list = service.listMember(map);
		int listNum, n=0;
		for(Member dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp = req.getContextPath();
		String listUrl = cp + "/admin/list/member";

	
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);

		return ".admin.list.member";
	}

	
	

	  @RequestMapping("deleteMember")
	   public String deleteMember(
	         @RequestParam String userId,
	         @RequestParam String page
	         ) throws Exception{
	      try {
	         service.deleteMember(userId);
	      } catch (Exception e) {
	         throw e;
	      }
	      return "redirect:/admin/list/member?page="+page;
	   }
	  
	  @RequestMapping("seller")
		public String listSeller(@RequestParam(value = "page", defaultValue = "1") int current_page,
				HttpServletRequest req, Model model) throws Exception {
			int rows = 10;
			int dataCount, total_page;

			Map<String, Object> map = new HashMap<>();
			dataCount = service.dataCountSeller(map);
			total_page = myUtil.pageCount(rows, dataCount);
			if (current_page > total_page) {
				current_page = total_page;
			}

			int offset = (current_page - 1) * rows;
			if (offset < 0)
				offset = 0;
			map.put("offset", offset);
			map.put("rows", rows);

			List<Seller> list = service.listSeller(map);
			int listNum, n=0;
			for(Seller dto:list) {
				listNum=dataCount-(offset+n);
				dto.setListNum(listNum);
				n++;
			}
			
			String cp = req.getContextPath();
			String listUrl = cp + "/admin/list/seller";

		
			String paging = myUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);

			return ".admin.list.seller";
		}

		  @RequestMapping("deleteSeller")
		   public String deleteSeller(
		         @RequestParam String sellerId,
		         @RequestParam String page
		         ) throws Exception{
		      try {
		         service.deleteSeller(sellerId);
		      } catch (Exception e) {
		         throw e;
		      }
		      return "redirect:/admin/list/seller?page="+page;
		   }
		  
		  @RequestMapping("authSeller")
		   public String authSeller(
		         @RequestParam String sellerId,
		         @RequestParam int allow,		         
		         @RequestParam String page
		         ) throws Exception{
		      try {
		    	  Map<String, Object> map = new HashMap<String, Object>();
		    	  map.put("sellerId", sellerId);
		    	  allow = allow==0?1:0;
		    	  map.put("allow", allow);
		    	  
		          service.updateSeller(map);
		      } catch (Exception e) {
		         throw e;
		      }
		      return "redirect:/admin/list/seller?page="+page;
		   }
		  
		  @RequestMapping("authMember")
		   public String authMember(
		         @RequestParam String userId,
		         @RequestParam int allow,		         
		         @RequestParam String page
		         ) throws Exception{
		      try {
		    	  Map<String, Object> map = new HashMap<String, Object>();
		    	  map.put("userId", userId);
		    	  allow = allow==0?1:0;
		    	  map.put("allow", allow);
		    	  
		          service.updateMember(map);
		      } catch (Exception e) {
		         throw e;
		      }
		      return "redirect:/admin/list/member?page="+page;
		   }
		  
		  @RequestMapping("authEvent")
		   public String authEvent(
		         @RequestParam int eventNum,
		         @RequestParam int allow,		         
		         @RequestParam String page
		         ) throws Exception{
		      try {
		    	  Map<String, Object> map = new HashMap<String, Object>();
		    	  map.put("eventNum", eventNum);
		    	  allow = allow==0?1:0;
		    	  map.put("allow", allow);
		    	  
		          service.updateEvent(map);
		      } catch (Exception e) {
		         throw e;
		      }
		      return "redirect:/admin/list/event?page="+page;
		   }
		  
		  @RequestMapping("deleteEvent")
		   public String deleteEvent(
		         @RequestParam int eventNum,
		         @RequestParam String page
		         ) throws Exception{
		      try {
		         service.deleteEvent(eventNum);
		      } catch (Exception e) {
		         throw e;
		      }
		      return "redirect:/admin/list/event?page="+page;
		   }
		  
		  @RequestMapping("event")
			public String listEvent(@RequestParam(value = "page", defaultValue = "1") int current_page,
					HttpServletRequest req, Model model) throws Exception {
				int rows = 10;
				int dataCount, total_page;

				Map<String, Object> map = new HashMap<>();
				dataCount = service.dataCountEvent(map);
				total_page = myUtil.pageCount(rows, dataCount);
				if (current_page > total_page) {
					current_page = total_page;
				}

				int offset = (current_page - 1) * rows;
				if (offset < 0)
					offset = 0;
				map.put("offset", offset);
				map.put("rows", rows);

				List<Event> list = service.listEvent(map);
				int listNum, n=0;
				for(Event dto:list) {
					listNum=dataCount-(offset+n);
					dto.setListNum(listNum);
					n++;
				}
				
				String cp = req.getContextPath();
				String listUrl = cp + "/admin/list/event";

			
				String paging = myUtil.paging(current_page, total_page, listUrl);

				model.addAttribute("list", list);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("page", current_page);
				model.addAttribute("total_page", total_page);
				model.addAttribute("paging", paging);

				return ".admin.list.event";
			}
		  
		  @RequestMapping("notice")
			public String listNotice(@RequestParam(value = "page", defaultValue = "1") int current_page,
					HttpServletRequest req, Model model) throws Exception {
				int rows = 10;
				int total_page = 0;
				int dataCount = 0;
				
				Map<String, Object> map = new HashMap<>();
				dataCount = service.dataCountNotice(map);
				total_page = myUtil.pageCount(rows, dataCount);
				if (current_page > total_page) {
					current_page = total_page;
				}

				int offset = (current_page - 1) * rows;
				if (offset < 0)
					offset = 0;
				map.put("offset", offset);
				map.put("rows", rows);

				List<Notice> list = service.listNotice(map);
				int listNum, n=0;
				for(Notice dto:list) {
					listNum=dataCount-(offset+n);
					dto.setListNum(listNum);
					n++;
				}
				
				String cp = req.getContextPath();
				String listUrl = cp + "/admin/list/notice";

			
				String paging = myUtil.paging(current_page, total_page, listUrl);

				model.addAttribute("list", list);
				model.addAttribute("dataCount", dataCount);
				model.addAttribute("page", current_page);
				model.addAttribute("total_page", total_page);
				model.addAttribute("paging", paging);

				return ".admin.list.notice";
			}

			
			

			  @RequestMapping("deleteNotice")
			   public String deleteNotice(
						Notice dto,
			         @RequestParam int num,
			         @RequestParam String page,
			         HttpSession session
			         ) throws Exception{
					SessionInfo info=(SessionInfo)session.getAttribute("member");
					
			      try {
			    	  String root = session.getServletContext().getRealPath("/");
						String pathname = root + "uploads" + File.separator + "notice";		
						dto.setUserId(info.getUserId());
			         service.deleteNotice(num, pathname);
			      } catch (Exception e) {
			         throw e;
			      }
			      return "redirect:/admin/list/notice?page="+page;
			   }
			  
			  @RequestMapping("authNotice")
			   public String authNotice(
					  Notice dto,
			         @RequestParam int num,
			         @RequestParam int notice,		         
			         @RequestParam String page
			         ) throws Exception{
					
			      try {
						
						Map<String, Object> map = new HashMap<String, Object>();
			    	  notice = notice==0?1:0;
			    	  map.put("num", num);
			    	  map.put("notice", notice);
			    	  
			          service.updateNotice(map);
			      } catch (Exception e) {
			         throw e;
			      }
			      return "redirect:/admin/list/notice?page="+page;
			   }
				
			  
}


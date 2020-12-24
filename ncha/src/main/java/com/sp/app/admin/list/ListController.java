package com.sp.app.admin.list;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.member.Member;
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
}


package com.sp.app.daily;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;
/**
 * 일상글 관련 컨트롤러
 * 주요 기능 : 글쓰기 글보기 글 리스트 
 * @author 
 *
 */
@Controller("daily.dailyController")
@RequestMapping("/daily/*")
public class DailyController {
	@Autowired
	private DailyService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;

	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		int rows = 10; 
		int total_page = 0;
		int dataCount = 0;
		
		 Map<String, Object> map = new HashMap<String, Object>();
		 dataCount = service.dataCount(map);
	        if(dataCount != 0)
	            total_page = myUtil.pageCount(rows,  dataCount) ;
	        
	        if(total_page < current_page) 
	            current_page = total_page;

	        int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);
	        
	        List<Daily> list = service.listDaily(map);
	        
	        int listNum, n = 0;
	        for(Daily dto : list) {
	            listNum = dataCount - (offset + n);
	            dto.setListNum(listNum);
	            n++;
	        }
	        
	        String cp=req.getContextPath();

	        String listUrl = cp+"/daily/list";
	        String articleUrl = cp+"/daily/article?page=" + current_page;
	        
	        String paging = myUtil.paging(current_page, total_page, listUrl);
			
	        
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);		
			model.addAttribute("articleUrl", articleUrl);
		return ".ncha_bbs.daily.list";
	}
	@RequestMapping(value="created", method=RequestMethod.GET)
	public String writeForm(
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(info.getUserId()!=null) {
			
		}
		model.addAttribute("mode","created");
		return ".ncha_bbs.daily.created";
	}
	
	@RequestMapping(value="created", method=RequestMethod.POST)
	public String createdSubmit(
			Daily dto,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"daily";
		
		try {
			System.out.println("ㅇㅇ");
			dto.setUserId(info.getUserId());
			service.insertDaily(dto, pathname);
		} catch (Exception e) {
		}
		return "redirect:/daily/list";
	}
	
	@RequestMapping("article")
	public String article() throws Exception{
		
		return ".ncha_bbs.daily.article";
	}
}

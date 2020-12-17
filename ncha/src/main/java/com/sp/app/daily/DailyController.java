package com.sp.app.daily;

import java.io.File;
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
			@RequestParam(defaultValue="") String categoryNum,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model
			) throws Exception{
		int rows = 7; 
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword,"utf-8");
		}
		
		 Map<String, Object>map = new HashMap<>();
		 
		 map.put("categoryNum", categoryNum);
		 map.put("keyword", keyword);
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
	        String query = "";
	        String articleUrl = cp+"/daily/article?page=" + current_page;
	        
	        if(categoryNum.length()!=0 || keyword.length()!=0) {
				query = "categoryNum="+categoryNum+"&keyword="+
						URLEncoder.encode(keyword,"utf-8");
			}
	        
	        if(query.length()!=0) {
				listUrl+="?"+query;
				articleUrl+="&"+query;
			}
	        String paging = myUtil.paging(current_page, total_page, listUrl);
			
	      
	        model.addAttribute("keyword",keyword);
	        model.addAttribute("categoryNum", categoryNum);
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
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String root = session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"daily";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertDaily(dto, pathname);
		} catch (Exception e) {
		}
		model.addAttribute("pathname","pathname");
		return "redirect:/daily/list";
	}
	
	@RequestMapping("article")
	public String article(
			@RequestParam int dailyNum,
			@RequestParam String page,
			@RequestParam(defaultValue="") String categoryNum,
			@RequestParam(defaultValue="") String keyword,
			Model model
			) throws Exception{
	
		
		String query="page="+page;
		if(categoryNum.length()!=0 || keyword.length()!=0) {
			query+="&categoryNum="+categoryNum+"&keyword="+
					URLEncoder.encode(keyword,"utf-8");
		}
		
		
		service.updateHitCount(dailyNum);
		Daily dto = service.readDaily(dailyNum);
		
		if(dto==null) {
			return "redirect:/daily/list?"+query;
		}
		List<Daily> list1 = service.readDailyFile(dailyNum);
		
        dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
         
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dailyNum", dailyNum);
		map.put("categoryNum", categoryNum);
		map.put("keyword", keyword);

		Daily preReadDto = service.preReadDaily(map);
		Daily nextReadDto = service.nextReadDaily(map);
		
        
		// 파일
		List<Daily> listFile=service.listFile(dailyNum);
		model.addAttribute("list1", list1);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".ncha_bbs.daily.article";
	}
}

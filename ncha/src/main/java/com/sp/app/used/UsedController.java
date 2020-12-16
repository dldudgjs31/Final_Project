package com.sp.app.used;

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

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;
/**
 * 중고글 관련 컨트롤러
 * 주요 기능 : 글쓰기 글보기 글 리스트 
 * @author 
 *
 */
@Controller("used.usedController")
@RequestMapping("/used/*")
public class UsedController {
	@Autowired
	private UsedService service;
	
	@Autowired 
	private MyUtil myUtil;
	
	//@Autowired
	//private FileManager fileManager;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception{
		
		int rows = 10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword,"utf-8");
		}
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
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
		
		List<Used> list =service.listUsed(map);
		
		int listNum, n=0;
		for(Used dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp =req.getContextPath();
		String query = "";
		String listUrl= cp+"/used/list";
		String articleUrl=cp+"/used/article?page="+current_page;
		if(keyword.length()!=0) {
			query="condition="+condition+"&keyword"+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl+="?"+query;
			articleUrl+="&"+query;
		}
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		
		return ".ncha_bbs.used.list";
	}
	
	
	
	
	@RequestMapping(value="created", method = RequestMethod.GET)
	public String writeForm(
			HttpSession session,
			Model model ) throws Exception{
		
		
		
		model.addAttribute("mode","created");
		return ".ncha_bbs.used.created";
	}
	
	
	
	@RequestMapping(value="created", method = RequestMethod.POST)
	public String writeSubmit(
			Used dto,
			HttpSession session,
			Model model) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"used";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertUsed(dto, pathname);
		} catch (Exception e) {
		}
		model.addAttribute("pathname",pathname);
		return "redirect:/used/list";
	}
	
	
	@RequestMapping("article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		String query = "page="+page;
		if(keyword.length()!=0) {
			query +="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
		}
		
		service.updateHitCount(num);
		
		Used dto = service.readUsed(num);
		if(dto==null) {
			return "redirect:/used/list?"+query;
		}
		dto.setContent(dto.getContent().replaceAll("/n", "<br>"));
		
		
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("condition",condition);
		map.put("keyword",keyword);
		map.put("usedNum",num);
		
		//Used preReadDto = service.preReadUsed(map);
		//Used nextReadDto = service.nextReadUsed(map);
		
		List<Used> listFile = service.listFile(num);
		
		model.addAttribute("dto",dto);
		//model.addAttribute("preReadDto",preReadDto);
		//model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("listFile",listFile);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		
		return ".ncha_bbs.used.article";
	}
	
	
	
}

package com.sp.app.used;

import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.FileManager;
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
	
	@Autowired
	private FileManager fileManager;
	//@Autowired
	//private FileManager fileManager;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String category,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			Model model) throws Exception{
		
		int rows = 10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword,"utf-8");
		}
		//전체 페이지 수
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("category", category);
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map); //데이터 갯수 가져옴
		if(dataCount!=0) { 
			total_page=myUtil.pageCount(rows, dataCount); //전체 페이지수 계산
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
			query="category="+category+"&keyword"+URLEncoder.encode(keyword, "utf-8");
		}
		
		
		if(query.length()!=0) { //검색조건이 있는 경우
			listUrl = cp + "/used/list?" + query;
			articleUrl = cp+"/used/article?page="+current_page+"&"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl",articleUrl);
		
		model.addAttribute("category", category);
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

		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"used";
			
			dto.setUserId(info.getUserId());
			service.insertUsed(dto, pathname);
			
		} catch (Exception e) {
		}
	
		return "redirect:/used/list";
	}
	
	
	@RequestMapping(value = "article", method = RequestMethod.GET)
	public String article(
			@RequestParam int usedNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String category,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		//검색
		String query="page="+page;
		if(category.length()!=0 || keyword.length()!=0) {
			query+="&category="+category+"&keyword="+
					URLEncoder.encode(keyword,"utf-8");
		}
	
		service.updateHitCount(usedNum);
		
		Used dto = service.readUsed(usedNum);
		if(dto==null) {
			return "redirect:/used/list?"+query;
		}
	
		dto.setContent(dto.getContent().replaceAll("/n", "<br>"));
			
		//이전글 다음글
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("usedNum",usedNum);
		map.put("category", category);
		map.put("keyword", keyword);

		Used preReadDto = service.preReadDto(map);
		Used nextReadDto = service.nextReadDto(map);
		
		//파일
		List<Used> images = service.readUsedFile(usedNum);
		List<Used> listFile = service.listFile(usedNum);
		
		model.addAttribute("dto",dto);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("listFile",listFile);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("images",images);
		
		
		return ".ncha_bbs.used.article";
	}
	
	
	@RequestMapping(value="update", method = RequestMethod.GET)
	public String updateForm(
			@RequestParam int usedNum,
			@RequestParam String page,
			HttpSession session,
			Model model ) throws Exception {
		
		
		Used dto = service.readUsed(usedNum);
		//List<Used> images = service.readUsedFile(usedNum);
		List<Used> listFile = service.listFile(usedNum);
		
		model.addAttribute("usedNum",usedNum);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("listFile",listFile);
	
		
		return ".ncha_bbs.used.created";
	}
	
	@RequestMapping(value="update", method = RequestMethod.POST)
	public String updateSubmit(
			Model model,
			Used dto,
			@RequestParam String page,
			HttpSession session) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+File.separator+"uploads"+File.separator+"used";
			
			dto.setUserId(info.getUserId());
			service.updateUsed(dto, pathname);
			
		} catch (Exception e) {
		}
		
		return "redirect:/used/list?page="+page;
	}
	
	@RequestMapping(value="deleteFile", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteImage(
			@RequestParam int used_imageFileNum,
			HttpSession session,
			HttpServletResponse resp) throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads"+File.separator+"used";
		
		Used dto = service.readFile(used_imageFileNum);
		if(dto != null) {
			fileManager.doFileDelete(dto.getImageFilename(),pathname);
		}
		
		Map<String, Object> model = new HashMap<>();
		try {
			Map<String, Object>map = new HashMap<>();
			map.put("field","used_imageFileNum");
			map.put("used_imageFileNum",used_imageFileNum);
			service.deleteImage(map);
			
			//작업 결과 JSON으로 전송
			model.put("state", true);
		} catch (Exception e) {
			model.put("state","false");
		}
		return model;	
	}
	
	@RequestMapping(value="delete")
	@ResponseBody
	public String deleteSubmit(
			@RequestParam int usedNum,
			@RequestParam String page,
			HttpSession session ) throws Exception{
		
	//	keyword = URLDecoder.decode(keyword,"utf-8");
		String query = "page="+page;
		
		//if(keyword.length()!=0) {
		//	query+="&keyword="+keyword+"&categoryNum="+categoryNum;
		// }
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"used";
			service.deleteUsed(usedNum, pathname);
		
		} catch (Exception e) {
		}
		
		return "redirect:/used/list?page="+page;
	}
}

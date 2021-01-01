package com.sp.app.used;

import java.io.File;
import java.math.BigDecimal;
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
	
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String categoryNum, //카테고리분류
			@RequestParam(defaultValue = "all") String condition, //검색 조건
			@RequestParam(defaultValue = "") String keyword,     //내용 검색
			HttpServletRequest req,
			Model model) throws Exception{
		
		int rows = 12;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword,"utf-8");
		}
		//전체 페이지 수
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("categoryNum", categoryNum);
		map.put("condition", condition);
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
			query = "condition="+condition+"&categoryNum="+categoryNum+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		
		if(query.length()!=0) { //검색조건이 있는 경우
			listUrl += "?" + query;
			articleUrl += "&"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl",articleUrl);
		
		model.addAttribute("categoryNum", categoryNum);
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
			String mode,
			@RequestParam int usedNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue="") String categoryNum,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception{
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		//검색
		String query="page="+page;
		if(categoryNum.length()!=0 || keyword.length()!=0) {
			query+="&condition"+condition+"&categoryNum="+categoryNum+"&keyword="+
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
		map.put("categoryNum", categoryNum);
		map.put("condition",condition);
		map.put("keyword", keyword);

		Used preReadDto = service.preReadDto(map);
		Used nextReadDto = service.nextReadDto(map);
		
		//파일
		List<Used> imageList = service.imageList(usedNum);
		int usedLikeCount = service.usedLikeCount(usedNum);
		
		
		model.addAttribute("dto",dto);
		model.addAttribute("mode",mode);
		model.addAttribute("preReadDto",preReadDto);
		model.addAttribute("nextReadDto",nextReadDto);
		model.addAttribute("imageList",imageList);
		model.addAttribute("page",page);
		model.addAttribute("query",query);
		model.addAttribute("usedLikeCount",usedLikeCount);
		
		
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
		List<Used> imageList = service.imageList(usedNum);
		
		model.addAttribute("usedNum",usedNum);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("imageList",imageList);
	
		
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
	public String deleteSubmit(
			@RequestParam int usedNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "") String categoryNum,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session ) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member"); 
		keyword = URLDecoder.decode(keyword,"utf-8");
		
		String query = "page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&categoryNum="+categoryNum+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"used";
			service.deleteUsed(usedNum, pathname,info.getUserId());
		
		} catch (Exception e) {
		}
		
		return "redirect:/used/list?"+query;
	}
	
	//중고게시글 좋아요 추가 : AJAX-JSON
	@RequestMapping(value="insertUsedLike",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertUsedLike(
			@RequestParam int usedNum,
			HttpSession session){
		
	
		String state = "true";
		int usedLikeCount = 0;
		SessionInfo info = (SessionInfo)session.getAttribute("member");
	
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("usedNum",usedNum);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertUsedLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		System.out.println(usedLikeCount);
		usedLikeCount = service.usedLikeCount(usedNum);
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		model.put("usedLikeCount", usedLikeCount);
		
		return model;
	}
	
	//댓글 CRUD
	//AJAX-JSON : 댓글 및 답글 등록
	@RequestMapping(value="insertReply" , method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply reply,
			HttpSession session ){
	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String state = "true";
		
		try {
			reply.setUserId(info.getUserId());
			service.insertReply(reply);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	//AJAX-JSON : 댓글 및 답글 삭제
	@RequestMapping(value="deleteReply", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			
			@RequestParam Map<String, Object> paramMap){
		String state = "true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String,Object> model = new HashMap<>();
		model.put("state",state);
		
		return model;
	}
	
	//댓글 리스트 :AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int usedNum,
			@RequestParam(value ="page", defaultValue = "1")int current_page,
			Model model
			) throws Exception {
		
		int rows = 5;
		int total_page = 0;
		int replyCount = 0;

		Map<String, Object>map = new HashMap<>();
		map.put("usedNum", usedNum);
		
		replyCount = service.replyCount(map);
		total_page = myUtil.pageCount(rows, replyCount);
		if(current_page > total_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0; //현재페이지가 0일때
		map.put("offset",offset);
		map.put("rows",rows);
		
		List<Reply>listReply = service.listReply(map);
		
		for(Reply reply : listReply) {
			reply.setContent(reply.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging = myUtil.pagingMethod(current_page, total_page,"listPage");
		
		model.addAttribute("listReply",listReply);
		model.addAttribute("page",current_page);
		model.addAttribute("replyCount",replyCount);
		model.addAttribute("total_page",total_page);
		model.addAttribute("paging",paging);
		
		return "ncha_bbs/used/listReply";
	}
	
	//댓글 좋아요
	@RequestMapping(value="insertReplyLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
		@RequestParam Map<String, Object>map,
		HttpSession session){
		
		String state= "true";
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			map.put("userId",info.getUserId());
			service.insertReplyLike(map);
		} catch (Exception e) {
			state = "false";
		}
		
		Map<String, Object> count = service.replyLikecount(map);
		
		//마이바티스의 resultType이  map인경우, int는 BigDecimal로 넘어옴
		int likeCount = ((BigDecimal)count.get("LIKECOUNT")).intValue();
		
		Map<String, Object> model = new HashMap<>();
		model.put("likeCount",likeCount);
		model.put("state",state);
		
		return model;
	}
	
	@RequestMapping(value = "countReplyLike", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam Map<String, Object> map,
			HttpSession session
			){
		
		Map<String, Object> count = service.replyLikecount(map);
		
		int likeCount = ((BigDecimal)count.get("LIKECOUNT")).intValue();
		
		Map<String, Object> model = new HashMap<>();
		model.put("likeCount", likeCount);
		
		return model;
	}
	
	
	//대댓글 리스트
	@RequestMapping(value = "listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model) throws Exception{

		List<Reply> listReplyAnswer = service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("/n","<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "ncha_bbs/used/listReplyAnswer";
	}
	
	//대댓글 카운트 : AJAX-JSON
	@RequestMapping(value = "replyAnswerCount")
	@ResponseBody
	public Map<String, Object> replyAnswerCount(
			@RequestParam(value="answer")int answer 
			) {
		
		int count = service.replyAnswerCount(answer);
		
		Map<String, Object> model = new HashMap<>();
		model.put("count",count);
		
		return model;
	}
	
	@RequestMapping(value="insertKeepList",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertKeepList(
			@RequestParam int usedNum,
			HttpSession session){
		
	
		String state = "true";

		SessionInfo info = (SessionInfo)session.getAttribute("member");
	
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("usedNum",usedNum);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertKeepList(paramMap);
		} catch (Exception e) {
			state="false";
		}
	
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
	
		return model;
	}
	
	
	@RequestMapping("keepList")
	public String keepList(
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
				
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		map.put("userId",info.getUserId());
				
		int dataCount = service.usedKeepCount(map); //데이터 갯수 가져옴
		
		List<Used> list =service.keepList(map);
		
		model.addAttribute("list", list);
		model.addAttribute("keepCount", dataCount);
		model.addAttribute("userId",info.getUserId());

		return ".ncha_bbs.used.keepList";
	}
	
	
	//AJAX-JSON : 찜삭제
		@RequestMapping(value="deleteKeep")
		public String deleteKeep(
				@RequestParam String usedNum){
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			map.put("usedNum",usedNum);
			
			try {
				service.deleteKeep(map);
			} catch (Exception e) {
			}
			
			
			return "redirect:/used/keepList";
		}
}

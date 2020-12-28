package com.sp.app.daily;

import java.io.File;
import java.math.BigDecimal;
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
import org.springframework.web.bind.annotation.ResponseBody;

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
		int rows = 10; 
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
            total_page = myUtil.pageCount(rows,  dataCount);
        
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
		
      
		model.addAttribute("mode","mode");
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
			 String mode,
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
		List<Daily> list1 = service.readDailyFile(dailyNum);	//파일 여러개 불러오는거
		
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
		
		model.addAttribute("mode", mode);
		model.addAttribute("list1", list1);
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".ncha_bbs.daily.article";
	}
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int dailyNum,
			@RequestParam String page,
			HttpSession session,			
			Model model	) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Daily dto = service.readDaily(dailyNum);
		
		if(dto==null) {
			return "redirect:/daily/list?page="+page;
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "redirect:/daily/list?page="+page;
		}

		
		List<Daily> listFile=service.listFile(dailyNum);
		model.addAttribute("dailyNum",dailyNum);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return ".ncha_bbs.daily.created";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Model model,
			int dailyNum,
			Daily dto,
			@RequestParam String page,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		System.out.println(dto.getDaily_imageFilenum());
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + File.separator + "uploads" + File.separator + "daily";		
			
			//List<Daily> list1 = service.readDailyFile(dailyNum);	//파일 여러개 불러오는거
			//model.addAttribute("list1", list1);  수정할때 원래 올렸던 사진 나오게 ㅊ ㅓ리하다가 자러감 
			
			dto.setUserId(info.getUserId());
			service.updateDaily(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/daily/list?page="+page;
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int daily_imageFilenum,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "daily";
		
		Daily dto=service.readFile(daily_imageFilenum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getImageFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "daily_imageFilenum");
		map.put("daily_imageFilenum", daily_imageFilenum);
		service.deleteFile(map);
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		model.put("state", "true");
		return model;
	}
	
	@RequestMapping(value="delete")
	public String delete(
			@RequestParam int dailyNum,
			@RequestParam String page,
			@RequestParam(defaultValue="") String categoryNum,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&categoryNum="+categoryNum+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		if(! info.getUserId().equals("admin")) {
			return "redirect:/daily/list?"+query;
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root + "uploads" + File.separator + "daily";
			service.deleteDaily(dailyNum, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/daily/list?"+query;
	}
	
	//댓글,답글,좋아요
	
	// 게시글 좋아요 추가 :  : AJAX-JSON
	@RequestMapping(value="insertDailyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertDailyLike(
			@RequestParam int dailyNum,
			HttpSession session
			) {
		String state="true";
		int dailyLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("dailyNum", dailyNum);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertDailyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
			
		dailyLikeCount = service.dailyLikeCount(dailyNum);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("dailyLikeCount", dailyLikeCount);
		
		return model;
	}
	
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int dailyNum,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("dailyNum", dailyNum);
		
		dataCount=service.replyCount(map);
		total_page = myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
        int offset = (current_page-1) * rows;
		if(offset < 0) offset = 0;
        map.put("offset", offset);
        map.put("rows", rows);
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto : listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		// AJAX 용 페이징
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "ncha_bbs/daily/listReply";
	}
	
	// 댓글 및 댓글의 답글 등록 : AJAX-JSON
	@RequestMapping(value="insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto,
			HttpSession session
			) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model = new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
	@RequestMapping(value="deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteReply(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			service.deleteReply(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		return map;
	}
	
	 // 댓글의 답글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReplyAnswer")
	public String listReplyAnswer(
			@RequestParam int answer,
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "ncha_bbs/daily/listReplyAnswer";
	}
	
	// 댓글의 답글 개수 : AJAX-JSON
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam(value="answer") int answer
			) {
		
		int count=service.replyAnswerCount(answer);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}
	
	// 댓글의 좋아요/싫어요 추가 : AJAX-JSON
	@RequestMapping(value="insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> model=new HashMap<>();
		
		try {
			paramMap.put("userId", info.getUserId());
			service.insertReplyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
				
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
		model.put("state", state);
		return model;
	}

	// 댓글의 좋아요/싫어요 개수 : AJAX-JSON
	@RequestMapping(value="countReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		Map<String, Object> model=new HashMap<>();
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
			
		return model;
	}
	
}

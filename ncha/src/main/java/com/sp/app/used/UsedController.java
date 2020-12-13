package com.sp.app.used;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String list() throws Exception{
		return ".ncha_bbs.used.list";
	}
	
	
	
	
	@RequestMapping(value="write", method = RequestMethod.GET)
	public String writeForm(
			Model model ) throws Exception{
		
		model.addAttribute("mode","created");
		return ".ncha_bbs.used.created";
	}
	
	@RequestMapping(value="/used/write", method = RequestMethod.POST)
	public String writeSubmit(
			Used dto,
			HttpSession session) throws Exception{
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"used";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertUsed(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/used/list";
	}
	
	
	
	
	
	@RequestMapping("article")
	public String article() throws Exception{
		
		return ".ncha_bbs.used.article";
	}
}

package com.sp.app.daily;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 일상글 관련 컨트롤러
 * 주요 기능 : 글쓰기 글보기 글 리스트 
 * @author 
 *
 */
@Controller("daily.dailyController")
@RequestMapping("/daily/*")
public class DailyController {

	@RequestMapping("list")
	public String list() throws Exception{
		
		return ".ncha_bbs.daily.list";
	}
	@RequestMapping("write")
	public String write() throws Exception{
		
		return ".ncha_bbs.daily.created";
	}
	@RequestMapping("article")
	public String article() throws Exception{
		
		return ".ncha_bbs.daily.article";
	}
}

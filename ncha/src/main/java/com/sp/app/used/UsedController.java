package com.sp.app.used;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 중고글 관련 컨트롤러
 * 주요 기능 : 글쓰기 글보기 글 리스트 
 * @author 
 *
 */
@Controller("used.usedController")
@RequestMapping("/used/*")
public class UsedController {

	@RequestMapping("list")
	public String list() throws Exception{
		return ".ncha_bbs.used.list";
	}
	@RequestMapping("write")
	public String write() throws Exception{
		
		return ".ncha_bbs.used.created";
	}
	@RequestMapping("article")
	public String article() throws Exception{
		
		return ".ncha_bbs.used.article";
	}
}

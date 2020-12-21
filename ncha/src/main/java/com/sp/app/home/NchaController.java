package com.sp.app.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NchaController {
	/**
	 * n-cha 중고거래 파트 메인 페이지(home)
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return ".ncha_bbs.main.main";
	}
	
	/**
	 * 글올리기 페이지( 중고 / 일상글 선택)
	 * @return
	 */
	@RequestMapping("/ncha/write")
	public String createdList() {
		
		return ".ncha_bbs.main.createdList";
	}
	/**
	 * 스토어 파트 메인 페이지
	 * @return
	 */
	@RequestMapping("/store/main")
	public String storeHome() {
		
		return ".store.main.main";
	}
	
	@RequestMapping("/ncha/member")
	public String member() {
		return ".member.new_member";
	}
	@RequestMapping("/ncha/login")
	public String login() {
		return ".member.login_select";
	}
	@RequestMapping("/ncha/login_1")
	public String login1() {
		return "member/login";
	}
	@RequestMapping("/ncha/login_2")
	public String login2() {
		return "member/login_store";
	}

	
}

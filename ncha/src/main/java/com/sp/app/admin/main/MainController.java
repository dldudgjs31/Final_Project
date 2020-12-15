package com.sp.app.admin.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("admin.mainController")
public class MainController {
	 
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminHome() {
		return ".admin.main.main";
	}
	
	/**
	 * 회원관리 페이지( 일반 / 판매 선택)
	 */
	
	@RequestMapping("/admin/member")
	public String memberManagement() {
		return ".admin.member_management";
	}
	
	/**
	 * 전체게시글 관리 페이지(중고/ 일상글 선택)
	 */
	@RequestMapping("/admin/article")
	public String articleManagement() {
		return ".admin.article_management";
	}
	
	
	/**
	 * 이벤트 신청 관리 페이지
	 */
	@RequestMapping("/admin/event")
	public String event() {
		return ".admin.event";
	}
	
	/**
	 * 공지사항 관리 페이지 (필요할까 싶긴해!)
	 */
	
	@RequestMapping("/admin/notice")
	public String noticeManagement() {
		return ".admin.notice_management";
	}
}

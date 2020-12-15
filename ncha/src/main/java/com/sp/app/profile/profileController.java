package com.sp.app.profile;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;

@Controller("profile.profileController")
@RequestMapping("/mypage/*")
public class profileController {
	@Autowired
	private MemberService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	
	@RequestMapping("profile")
	public String profile(
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readProfile(info.getUserId());
		model.addAttribute("dto", dto);
		return ".ncha_bbs.main.mypage";
	}
	
	
	@RequestMapping(value="pwd", method=RequestMethod.GET)
	public String pwdForm(String dropout, Model model) {
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}
		
		return ".member.pwd";
	}
	
	@RequestMapping(value="pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam String userPwd,
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session
	     ) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member dto=service.readMember(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		if(! dto.getUserPwd().equals(userPwd)) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		// 회원정보수정폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".ncha_bbs.main.profile_update";
	}
	
	@RequestMapping("profileUpdate")
	public String profileUpdate(
			HttpSession session,
			Model model) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readProfile(info.getUserId());
		model.addAttribute("dto", dto);
		
		return ".ncha_bbs.main.profile_update";
	}
	
}

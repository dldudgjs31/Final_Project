package com.sp.app.seller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.member.SessionInfo;

@Controller("seller.sellerController")
@RequestMapping("/seller/*")
public class SellerController {

	@Autowired
	private SellerService service;
	
	
	@RequestMapping(value="seller", method=RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "seller");
		return ".member.member_store";
	}

/*
    * RedirectAttributes 
      RedirectAttributes에 데이터등을 저장하면 Redirect 된 후 즉시 사라지게 되고
	    사용자가 F5등을 눌러 리로드 하더라도 서버로 다시 submit 되어 저장되지 않게할 수 있다.
*/
	@RequestMapping(value="seller", method=RequestMethod.POST)
	public String memberSubmit(Seller dto,
			final RedirectAttributes reAttr,
			Model model) {

		try {
			service.insertSeller(dto);
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("mode", "seller");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return ".member.member_store";
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "seller");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
			return ".member.member_store";
		} catch (Exception e) {
			model.addAttribute("mode", "seller");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return ".member.member_store";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getSellerName()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		// 리다이렉트된 페이지에 값 넘기기
        reAttr.addFlashAttribute("message", sb.toString());
        reAttr.addFlashAttribute("title", "회원 가입");
		
		return "redirect:/member/complete";
	}
	
/*
    * @ModelAttribute
      - 스프링에서 JSP파일에 반환되는 Model 객체에 속성값을 주입하거나 바인딩할 때 사용되는 어노테이션
      - RedirectAttributes 에 저장된 데이터를 자바 메소드(리다이렉트로 매핑된 메소드)
               에서 넘겨 받기 위해서는 메소드 인자에 @ModelAttribute("속성명")을 사용해야 한다.
*/
	@RequestMapping(value="complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다. 
		// F5를 눌러 새로 고침을 하면 null이 된다.
		
		if(message==null || message.length()==0) // F5를 누른 경우
			return "redirect:/";
		
		return ".member.complete";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm() {
		return ".member.login_store";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String sellerId,
			@RequestParam String pwd,
			HttpSession session,
			Model model
			) {
		System.out.println(sellerId+":"+pwd+"--------------------------------------");
		Seller dto=service.loginSeller(sellerId);
		if(dto==null ||  !  pwd.equals(dto.getPwd())) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return ".member.login_store";
		}
		
		// 세션에 로그인 정보 저장
		SessionInfo info=new SessionInfo();
		info.setSellerId(dto.getSellerId());
		info.setSellerName(dto.getSellerName());
		
		session.setMaxInactiveInterval(30*60); // 세션유지시간 30분, 기본:30분
		
		session.setAttribute("member", info);
		
		// 로그인 이전 URI로 이동
		String uri=(String)session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if(uri==null)
			uri="redirect:/";
		else
			uri="redirect:"+uri;
		
		return uri;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");
		
		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();
		
		return "redirect:/";
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
			@RequestParam String pwd,
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session
	     ) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Seller dto=service.readSeller(info.getSellerId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		if(! dto.getPwd().equals(pwd)) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		if(mode.equals("dropout")){
			// 게시판 테이블등 자료 삭제
			
			// 회원탈퇴 처리
			/*
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", info.getMemberIdx());
			map.put("userId", info.getUserId());
			*/

			// 세션 정보 삭제
			session.removeAttribute("member");
			session.invalidate();

			StringBuilder sb=new StringBuilder();
			sb.append(dto.getSellerName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "회원 탈퇴");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/member/complete";
		}

		// 회원정보수정폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".member.member";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Seller dto,
			final RedirectAttributes reAttr,
			Model model) {
		
		try {
			service.updateSeller(dto);
		} catch (Exception e) {
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append(dto.getSellerName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}

	// @ResponseBody : 자바 객체를 HTTP 응답 몸체로 전송(AJAX에서 JSON 전송 등에 사용)
	@RequestMapping(value="userIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String sellerId
			) throws Exception {
		
		String p="true";
		Seller dto=service.readSeller(sellerId);
		if(dto!=null) {
			p="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("passed", p);
		return model;
	}
	
}

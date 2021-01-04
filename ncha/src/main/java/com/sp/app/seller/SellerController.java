package com.sp.app.seller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.sp.app.common.MyUtil;



@Controller("seller.sellerController")
@RequestMapping("/seller/*")
public class SellerController {
   @Autowired
   private SellerService service;
   
	@Autowired
	private MyUtil myUtil;
	
   @RequestMapping(value="member", method=RequestMethod.GET)
   public String memberForm(Model model) {
      model.addAttribute("mode", "seller");
      return ".member.member_store";
   }

   @RequestMapping(value="seller", method=RequestMethod.POST)
   public String memberSubmit(Seller dto,
         final RedirectAttributes reAttr,
         Model model,
         HttpSession session) throws Exception {

      try {
    	  String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"member";
			
         service.insertSeller(dto, pathname);
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
      return ".member.login_select";
   }
   
   @RequestMapping(value="login", method=RequestMethod.POST)
   public String loginSubmit(
         @RequestParam String sellerId,
         @RequestParam String pwd,
         HttpSession session,
         Model model
         ) {
      Seller dto=service.loginSeller(sellerId);
      if(dto==null ||  !  pwd.equals(dto.getPwd())) {
         model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
         return ".member.login_select";
      }
      
      SessionInfo info=new SessionInfo();
      info.setSellerId(dto.getSellerId());
      info.setSellerName(dto.getSellerName());
      info.setAllow(dto.getAllow());
      
      session.setMaxInactiveInterval(30*60); // 세션유지시간 30분, 기본:30분
      
      session.setAttribute("seller", info);
      
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
      session.removeAttribute("seller");
      
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
      
      return ".member.pwd_store";
   }
   
   @RequestMapping(value="pwd", method=RequestMethod.POST)
   public String pwdSubmit(
         @RequestParam String pwd,
         @RequestParam String mode,
         final RedirectAttributes reAttr,
         Model model,
         HttpSession session
        ) {
      
      SessionInfo info=(SessionInfo)session.getAttribute("seller");
      
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
         return ".member.pwd_store";
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
         session.removeAttribute("seller");
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
      return ".member.member_store";
   }

   @RequestMapping(value="update", method=RequestMethod.POST)
   public String updateSubmit(
         Seller dto,
         final RedirectAttributes reAttr,
         Model model,
         HttpSession session) {
      
      try {
    	  String root = session.getServletContext().getRealPath("/");
		String pathname = root+File.separator+"uploads"+File.separator+"member";
         service.updateSeller(dto, pathname);
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
   @RequestMapping(value="sellerIdCheck", method=RequestMethod.POST)
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
   
   @RequestMapping("list")
	public String list(
			@RequestParam(value="page", defaultValue = "1") int current_page,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
		int rows = 20;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map = new HashMap<>();
		
		dataCount = service.dataCount(map);
		if(dataCount!=0) {
			total_page=myUtil.pageCount(rows, dataCount);
		}
		if(total_page<current_page) {
			current_page=total_page;
		}
		int offset=(current_page-1)*rows;
		if(offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Seller> list =service.listSeller(map);
		
		int listNum, n=0;
		for(Seller dto:list) {
			listNum=dataCount-(offset+n);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp =req.getContextPath();
		String query = "";
		String listUrl= cp+"/admin/list/seller";
		
		if(query.length()!=0) {
			listUrl+="?"+query;
		}
		String paging=myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", total_page);
		model.addAttribute("paging", paging);
		return ".admin.list.seller";
	}
   
   @RequestMapping(value="pwdFind_store", method=RequestMethod.GET)
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("seller");
		if(info!=null) {
			return "redirect:/";
		}
		
		return ".member.pwdFind_store";
	}
	
	@RequestMapping(value="pwdFind_store", method=RequestMethod.POST)
	public String pwdFindSubmit(@RequestParam String sellerId,
			final RedirectAttributes reAttr,
			Model model
			) throws Exception {
		
		Seller dto = service.readSeller(sellerId);
	
		if(dto==null || dto.getEmail()==null || dto.getAllow()==0) {
			model.addAttribute("message", "등록된 아이디가 아닙니다.");
			return ".member.pwdFind_store";
		}
		
		try {
			service.generatePwd(dto);
		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
			e.printStackTrace();
			return ".member.pwdFind_store";
		}
		
		StringBuilder sb=new StringBuilder();
		sb.append("회원님의 이메일로 임시패스워드를 전송했습니다.<br>");
		sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");
		
		reAttr.addFlashAttribute("title", "패스워드 찾기");
		reAttr.addFlashAttribute("message", sb.toString());
		
		return "redirect:/member/complete";
	}
	
   
}
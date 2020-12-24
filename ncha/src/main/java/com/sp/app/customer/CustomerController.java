package com.sp.app.customer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;

@Controller("customer.customerController")
@RequestMapping("/store/customer/*")
public class CustomerController {

	@Autowired
	private CustomerService service2;
	@Autowired
	private MemberService service1;
	
	@RequestMapping("main")
	public String myPage(
			Customer dto1,
			Model model,
			HttpSession session
			) throws Exception{
		System.out.println(dto1.getProductName()+"-------------------------------------------------------------"); 
		System.out.println(dto1.getProductName()+"-------------------------------------------------------------"); 
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		long memberIdx = info.getMemberIdx();
		Member dto = service1.readMember(info.getUserId());
		model.addAttribute("memberIdx", memberIdx);
		model.addAttribute("mode", "order");
		model.addAttribute("dto", dto);
		model.addAttribute("dto1", dto1);
		return".store.customer.order";
	}
	@PostMapping("order")
	public String orderSubmit(Customer dto) throws Exception{
		try {
			System.out.println(dto.getPrice()+"-------------------------------------------------------------");
			System.out.println(dto.getPrice()+"-------------------------------------------------------------");
			service2.insertOrder(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return ".store.customer.order";
		}
		
		return ".store.main.main";
	}
}

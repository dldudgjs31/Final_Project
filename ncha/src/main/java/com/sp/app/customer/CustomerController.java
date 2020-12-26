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
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			long memberIdx = info.getMemberIdx();
			Member dto = service1.readMember(info.getUserId());
			dto1.setImageFilename(service2.readImage(dto1.getProductNum()));
			model.addAttribute("memberIdx", memberIdx);
			model.addAttribute("mode", "order");
			model.addAttribute("dto", dto);
			model.addAttribute("dto1", dto1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return".store.customer.order";
	}
	@PostMapping("order")
	public String orderSubmit(Customer dto) throws Exception{
		try {
			service2.insertOrder(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return ".store.customer.order";
		}
		
		return ".store.main.main";
	}
}

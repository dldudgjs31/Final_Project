package com.sp.app.customer;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String orderForm(Customer dto1, Model model, HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");
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
		return ".store.customer.order";
	}

	@PostMapping("order")
	public String orderSubmit(Customer dto) throws Exception {
		try {
			service2.insertOrder(dto);
			service2.updateStock(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return ".store.customer.order";
		}

		return ".store.main.main";
	}

	@GetMapping("mypage")
	public String mypage() throws Exception {

		return ".store.customer.main";
	}

	@RequestMapping("cart")
	public String cart(Customer dto, @RequestParam String page, @RequestParam int quantity, @RequestParam int num,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo) session.getAttribute("member");

		keyword = URLDecoder.decode(keyword, "utf-8");
		/*
		 * String query = "page="+page+"&num"+num;
		 * 
		 * if(keyword.length()!=0) { query
		 * +="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8"); }
		 */
		try {
			dto.setProductNum(num);
			dto.setUserId(info.getUserId());
			dto.setQuantity(quantity);
			service2.insertCart(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/store/article?page=" + page + "&num=" + num;
		}
		return "redirect:/store/article?page=" + page + "&num=" + num;
	}
	@RequestMapping("cartlist")
	public String cartPage(
			HttpSession session,
			Customer dto,
			Model model
			) throws Exception{
		SessionInfo info  = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", info.getUserId());
		List<Customer> list =null;
		try {
			list=service2.readCart(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("list",list);
		return".store.customer.cart";
	}
}

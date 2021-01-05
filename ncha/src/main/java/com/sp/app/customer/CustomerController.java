package com.sp.app.customer;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;
import com.sp.app.member.Member;
import com.sp.app.member.MemberService;
import com.sp.app.member.SessionInfo;
import com.sp.app.store.Store;
import com.sp.app.store.StoreService;

@Controller("customer.customerController")
@RequestMapping("/store/customer/*")
public class CustomerController {

	@Autowired
	private CustomerService service2;
	@Autowired
	private MemberService service1;
	@Autowired
	private StoreService service3;
	
	
	@Autowired
	private MyUtil myUtil;
	
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
	public String orderSubmit(Customer dto, Model model) throws Exception {
		try {
			//선택 상품 재고 업데이트
			//선택 상품 재고 수량 - 구매수량 
			//전체 수량 업데이트
			int option_stock_total =service2.readStockOption(dto.getOptionNum());
			dto.setOption_stock(option_stock_total-dto.getNumber_sales());
			if(dto.getOption_stock()<0) {
				String order = "fail";
				model.addAttribute("page",1);
				model.addAttribute("order",order);
				model.addAttribute("num",dto.getProductNum());
				return "redirect:/store/article";
			}
			service2.insertOrder(dto);
			service2.updateStockOption(dto);
			service2.updateStock(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return ".store.customer.order";
		}
		String message = dto.getUserName()+"님의 주문 결제가 완료되었습니다. 이용해주셔서 감사합니다.";
		String title = "주문 완료";
		model.addAttribute("message", message);
		model.addAttribute("title", title);
		return ".member.complete";
	}

	@GetMapping("mypage")
	public String mypage(
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		try {
		//구매총금액
		int total_sales=0;
		Map<String, Object> map = new HashMap<>();
		map.put("memberIdx", info.getMemberIdx());
		total_sales= service2.readTotalSales(map);
		//구매한 상품 수	
		int total_salesCount =0;
		total_salesCount=service2.readMyproductCount(map);	
		//장바구니 담은 상품 수
		int cartCount = 0;
		cartCount =service2.dataCartCount(info.getUserId());
		//구매후기 수
		int reviewCount=0;
		map.put("userId", info.getUserId());
		reviewCount=service2.dataReviewCount(map);
		//qna 수
		int total_qna = 0;
		int yet_qna = 0;
		total_qna=service2.dataMyAllQnaCount(map);
		yet_qna=service2.dataMyQnaEnabledCount(map);
		
		//상품 리스트 불러오기 주문 날짜순
		List<Customer> orderList =service2.listRecentOrder(map);
		
		//좋아요 리스트 불러오기
		List<Customer> likeList = service2.listLike(map);
		
		model.addAttribute("total_sales",total_sales);
		model.addAttribute("total_salesCount",total_salesCount);
		model.addAttribute("cartCount",cartCount);
		model.addAttribute("reviewCount",reviewCount);
		model.addAttribute("total_qna",total_qna);
		model.addAttribute("yet_qna",yet_qna);
		model.addAttribute("orderList",orderList);
		model.addAttribute("likeList",likeList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ".store.customer.main";
	}

	@RequestMapping("cart")
	public String cart(
			@RequestParam String page, 
			@RequestParam int quantity, 
			@RequestParam int num,
			@RequestParam String order_option,
			@RequestParam int optionNum,
			@RequestParam(defaultValue = "all") String condition, 
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session, 
			Model model) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		
		keyword = URLDecoder.decode(keyword, "utf-8");
		/*
		 * String query = "page="+page+"&num"+num;
		 * 
		 * if(keyword.length()!=0) { query
		 * +="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8"); }
		 */
		
		//try {
			Customer dto=new Customer();
			dto.setProductNum(num);
			dto.setUserId(info.getUserId());
			dto.setQuantity(quantity);
			dto.setOrder_option(order_option);
			dto.setOptionNum(optionNum);
			int stock =service2.readStock(num);
			int total_quantity = service2.readCartQuantity(dto);
			
			System.out.println(stock+":"+total_quantity+":"+quantity);
			
			if(total_quantity+quantity>stock) {
				return "redirect:/store/article?page=" + page + "&num=" + num+"&message="+URLEncoder.encode("재고량보다 많은 수량은 담을 수 없습니다.","utf-8");
			}
			service2.insertCart(dto);
		//} catch (Exception e) {
		//	e.printStackTrace();
		//}
		return "redirect:/store/article?page=" + page + "&num=" + num;


	}
	@RequestMapping("cartlist")
	public String cartPage(
			HttpSession session,
			Customer dto,
			Model model,
			@RequestParam(defaultValue = "") String message
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
		
		model.addAttribute("message",message);
		model.addAttribute("list",list);
		return".store.customer.cart";
	}
	@GetMapping("cart/delete")
	public String cartDelete(
			@RequestParam int num,
			HttpSession session
			) throws Exception{
		
		try {
			service2.deleteCart(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return"redirect:/store/customer/cartlist";
	}
	@PostMapping("deleteCart")
	public String cartDelete1(
			@RequestParam int num,
			HttpSession session
			) throws Exception{
		
		try {
			service2.deleteCart(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return"redirect:/store/customer/cart/order";
	}
	
	@GetMapping("cart/order")
	public String cartOrderForm(
			HttpSession session,
			Customer dto1,
			Model model
			) throws Exception{
		SessionInfo info  = (SessionInfo)session.getAttribute("member");
		//카트 리스트 불러오기
		Map<String, Object> map = new HashMap<>();
		map.put("userId", info.getUserId());
		List<Customer> list =null;
		try {
			list=service2.readCart(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//주문자 정보 폼
		long memberIdx = info.getMemberIdx();
		Member dto = service1.readMember(info.getUserId());
		model.addAttribute("memberIdx", memberIdx);
		model.addAttribute("mode", "order");
		model.addAttribute("dto", dto);
		model.addAttribute("dto1", dto1);
		model.addAttribute("list",list);
		return".store.customer.cartorder";
	}
	
	@PostMapping("cart/order")
	public String cartOrderSubmit(
			Customer dto,
			HttpSession session,
			Model model
			)throws Exception{
		SessionInfo info  = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		map.put("userId", info.getUserId());
		List<Customer> list =null;
		try {
			list=service2.readCart(map);
			//for문으로 등록
			dto.setMemberIdx(info.getMemberIdx());
			dto.setUserId(info.getUserId());
			for(int i=0; i<list.size();i++) {
				//주문정보 입력
				//선택 상품 재고 업데이트
				//선택 상품 재고 수량 - 구매수량 
				//전체 수량 업데이트
				dto.setSellerId(list.get(i).getSellerId());
				dto.setProductNum(list.get(i).getProductNum());
				dto.setProductName(list.get(i).getProductName());
				dto.setCategoryName(list.get(i).getCategoryName());
				dto.setNumber_sales(list.get(i).getQuantity());
				dto.setPrice(list.get(i).getPrice()-list.get(i).getDiscount_rate());
				dto.setTotal_sales(list.get(i).getTotal_sales());
				dto.setOrder_option(list.get(i).getOrder_option());
				dto.setNumber_sales(list.get(i).getQuantity());
				dto.setOptionNum(list.get(i).getOptionNum());
				dto.setStock(list.get(i).getStock());
				
				
				int stock =0;
				stock = service2.readStockOption(dto.getOptionNum());
				if(stock-dto.getNumber_sales()<0) {
					String message = "fail";
					model.addAttribute("message",message);
					return "redirect:/store/customer/cartlist";
				}
				service2.insertOrder(dto);
				dto.setOption_stock(stock-dto.getNumber_sales()); 
				service2.updateStockOption(dto);
				service2.updateStock(dto);
			}
			System.out.println("---------------- 결제 완료 --------------");
			service2.deleteAllCart(dto.getUserId());
			System.out.println("---------------- 카트내역 삭제 완료--------------");
			String message = dto.getUserName()+"님의 주문 결제가 완료되었습니다. 이용해주셔서 감사합니다.";
			String title = "주문 완료";
			model.addAttribute("message", message);
			model.addAttribute("title", title);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return".member.complete";
	}
	
	
	@RequestMapping("review")
	public String mypageReview(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model
			) throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();
		map.put("memberIdx",info.getMemberIdx());
		dataCount = service2.dataOrderCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		if (total_page < current_page) {
			current_page = total_page;
		}
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Customer> reviewList = service2.readOrderList(map);
		int listNum=0; 
		int n = 0;
		for (Customer dto : reviewList) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		Customer dto = new Customer();
		for(int i =0;i<reviewList.size();i++) {
			int reviewCount = 0;
			dto.setMemberIdx(info.getMemberIdx());
			dto.setOrderNum(reviewList.get(i).getOrderNum());
			reviewCount = service2.readReviewCount(dto);
			reviewList.get(i).setReviewCount(reviewCount);
			String orderDetail = reviewList.get(i).getProductName() + " [옵션 :"+reviewList.get(i).getOrder_option()+" / "+reviewList.get(i).getNumber_sales()+"개 ]";
			reviewList.get(i).setOrderDetail(orderDetail);
			if(reviewCount > 0) {
				reviewList.get(i).setReviewNum(service2.readReviewNum(reviewList.get(i).getOrderNum()));
			}
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/store/customer/review";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", reviewList);
		return ".store.customer.review";
	}
	
	@RequestMapping("buylist")
	public String buylist(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "") String startdate,
			@RequestParam(defaultValue = "") String enddate, 
			@RequestParam(defaultValue = "0") int categoryNum,
			HttpSession session,
			HttpServletRequest req,
			Model model
			) throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();
		map.put("startdate", startdate);
		map.put("enddate", enddate);
		map.put("categoryNum", categoryNum);
		map.put("memberIdx",info.getMemberIdx());
		dataCount = service2.dataOrderCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		if (total_page < current_page) {
			current_page = total_page;
		}
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Customer> reviewList = service2.readOrderList(map);
		int listNum=0; 
		int n = 0;
		for (Customer dto : reviewList) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		Customer dto = new Customer();
		for(int i =0;i<reviewList.size();i++) {
			int reviewCount = 0;
			dto.setMemberIdx(info.getMemberIdx());
			dto.setOrderNum(reviewList.get(i).getOrderNum());
			reviewCount = service2.readReviewCount(dto);
			reviewList.get(i).setReviewCount(reviewCount);
			String orderDetail = reviewList.get(i).getProductName() + " [옵션 :"+reviewList.get(i).getOrder_option()+" / "+reviewList.get(i).getNumber_sales()+"개 ]";
			reviewList.get(i).setOrderDetail(orderDetail);
			if(reviewCount > 0) {
				reviewList.get(i).setReviewNum(service2.readReviewNum(reviewList.get(i).getOrderNum()));
			}
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/store/customer/review";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("startdate", startdate);
		model.addAttribute("enddate", enddate);
		model.addAttribute("categoryNum", categoryNum);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", reviewList);
	return ".store.customer.buylist";
	}
	
	@RequestMapping("likeList")
	public String likeList(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model
			)throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();
		map.put("userId",info.getUserId());
		dataCount =service3.dataLikeCount(map);
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		if (total_page < current_page) {
			current_page = total_page;
		}
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Customer> list = service2.listLike(map);
		int listNum=0; 
		int n = 0;
		for (Customer dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/store/customer/likeList";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		
		return".store.customer.likeList";
	}
	@RequestMapping("followStore")
	public String followStore(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model
			)throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("member");
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		Map<String, Object> map = new HashMap<>();
		map.put("userId",info.getUserId());
		dataCount =service3.dataMyStoreFollow(info.getUserId());
		if (dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		if (total_page < current_page) {
			current_page = total_page;
		}
		int offset = (current_page - 1) * rows;
		if (offset < 0)
			offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);
		List<Customer> list = service3.listFollow(map);
		int listNum=0; 
		int n = 0;
		if(list !=null) {
			for (Customer dto : list) {
				listNum = dataCount - (offset + n);
				dto.setListNum(listNum);
				n++;
			}
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/store/customer/followStore";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		return".store.customer.followStore";
		
	}
	
	
}

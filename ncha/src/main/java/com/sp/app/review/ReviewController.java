package com.sp.app.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.member.SessionInfo;

@Controller("review.reviewController")
@RequestMapping("/review/*")
public class ReviewController {
	@Autowired
	private ReviewService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value = "main")
	public String main() {
		return ".review.main";
	}
	
	// 상품별 리뷰-AJAX : text로 응답
	@RequestMapping(value = "listReview")
	public String list(@RequestParam(value = "pageNo", defaultValue = "1") int current_page,
			@RequestParam int productNum, Model model)throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNum",productNum);
		
		int rows = 10;
		int dataCount = service.dataCount(productNum);
		int total_page = myUtil.pageCount(rows, dataCount);
		if (current_page > total_page)
			current_page = total_page;

		int offset = (current_page - 1) * rows;
		if (offset < 0)	offset = 0;
		map.put("offset", offset);
		map.put("rows", rows);

		List<Review> list = service.listReview(map);
		for (Review dto : list) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		double reviewScore=service.reviewScore(productNum);
		
		String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		Map<Integer, Object> ratingOptions = new HashMap<>();
		ratingOptions.put(0, "☆☆☆☆☆");
		ratingOptions.put(1, "★☆☆☆☆");
		ratingOptions.put(2, "★★☆☆☆");
		ratingOptions.put(3, "★★★☆☆");
		ratingOptions.put(4, "★★★★☆");
		ratingOptions.put(5, "★★★★★");
		
		model.addAttribute("ratingOptions", ratingOptions);
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("reviewScore", reviewScore);
		model.addAttribute("paging", paging);
		
		return "review/list";
	}

	@PostMapping("insertReview")
	@ResponseBody
	public Map<String, Object> creatdSubmit(
			Review dto,
			HttpSession session
			) throws Exception{
		String state="true";
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		try {
			dto.setUserId(info.getUserId());
			service.insertReview(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashedMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@GetMapping("scoreReview")
	@ResponseBody
	public Map<String, Object> reviewScore(
			@RequestParam int productNum) throws Exception{
		double result=0;

		try {
			result=service.reviewScore(productNum);

		} catch (Exception e) {
		}
		Map<String, Object> model=new HashedMap<>();
		model.put("score", result);
		
		return model;
	}

	@RequestMapping(value="deleteReview", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> delete(
			@RequestParam int reviewNum,
			HttpSession session
			) throws Exception {
		String state="true";
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			 Map<String, Object> map = new HashedMap<>();
			 map.put("userId", info.getUserId());
			 map.put("reviewNum",reviewNum);
			 
			 service.deleteReview(map);
			} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashedMap<>();
		model.put("state", state);
		return model;
	}
	
	

}

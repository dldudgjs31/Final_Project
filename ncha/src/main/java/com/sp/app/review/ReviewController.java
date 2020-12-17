package com.sp.app.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.common.MyUtil;

@Controller("review.reviewController")
@RequestMapping("/review/*")
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	@Autowired
	private MyUtil myUtil;
	
	
}

package com.sp.app.profile;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("profile.profileController")
@RequestMapping("/mypage/*")
public class profileController {

	@RequestMapping("profile")
	public String profile() throws Exception{
		return ".ncha_bbs.main.mypage";
	}
	
}

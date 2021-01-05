package com.sp.app.admin.ncha_banner;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("admin.ncha_banner.nchaBannerController")
@RequestMapping("/admin/ncha_banner/*")
public class NchaBannerController {
	
	@Autowired
	private NchaBannerService service;

	// 모든 배너를 삭제후, 다시올림
	@RequestMapping(value="created", method = RequestMethod.GET)
	public String writeForm(
			HttpSession session,
			Model model) throws Exception{
		
		model.addAttribute("mode","created");
		return ".admin.ncha_banner.created";
	}
	
	
	
	@RequestMapping(value="created", method = RequestMethod.POST)
	public String writeSubmit(
			NchaBanner dto,
			HttpSession session,
			HttpServletRequest req,
			Model model) throws Exception{
		
		try {
			
			service.deleteAll(); //테이블에 이미지 전체 삭제
			
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+"uploads"+File.separator+"ncha_banner";
			
			service.insertImage(dto, pathname);
			
		} catch (Exception e) {
		}
		
		
		return "redirect:/";
	}
	
	//배너 일부만 수정
	@RequestMapping(value = "update", method = RequestMethod.GET)
	public String updateForm(
			HttpSession session,
			Model model) throws Exception {
		
		List<NchaBanner> list = service.listFile(); //사진파일리스트
		
		model.addAttribute("list",list);
		model.addAttribute("mode","update");
		
		
		return ".admin.ncha_banner.created";
	}
	
	
	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String updateSubmit(
			Model model,
			NchaBanner dto,
			HttpSession session) throws Exception{
		
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathname = root+File.separator+"uploads"+File.separator+"ncha_banner";
		
			service.updateImage(dto,pathname);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "redirect:/";
	}
	
	@RequestMapping("delete")
	@ResponseBody
	public void deleteImage(
			@RequestParam int fileNum
			) throws Exception {
		
		try {
			System.out.println(fileNum);
			service.deleteImage(fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}

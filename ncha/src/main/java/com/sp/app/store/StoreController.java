package com.sp.app.store;

import java.io.File;
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

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.seller.SessionInfo;

@Controller("store.storeController")
@RequestMapping("/store/*")
public class StoreController {

	@Autowired
	private StoreService service;

	@Autowired
	private MyUtil myUtil;

	@Autowired
	private FileManager fileManager;
	/**
	 * 스토어 상품리스트
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping("list")
	public String list(@RequestParam(value = "page", defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition, @RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req, Model model) throws Exception {

		int rows = 9;
		int total_page = 0;
		int dataCount = 0;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
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

		List<Store> list = service.listProduct(map);

		int listNum=0; 
		int n = 0;
		for (Store dto : list) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			n++;
		}

		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp + "/store/list";
		String articleUrl = cp + "/store/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition=" + condition + "&keyword" + URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length() != 0) {
			listUrl += "?" + query;
			articleUrl += "&" + query;
		}
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		return ".store.product.list";
	}

	/**
	 * 스토어 상품 올리기
	 * @return
	 * @throws Exception
	 */
	@GetMapping("created")
	public String createdForm(Model model) throws Exception{
		model.addAttribute("mode", "created");
		return ".store.product.created";
	}
	@PostMapping("created")
	public String creatdSubmit(
			Store dto,
			HttpSession session,
			Model model
			) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("seller");
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root+"uploads"+File.separator+"product";
		
		try {
			dto.setSellerId(info.getSellerId());
			service.insertProduct(dto, pathname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("pathname",pathname);
		return "redirect:/store/list";
	}
	/**
	 * 스토어 상품 글보기
	 * @return
	 * @throws Exception
	 */
	@GetMapping("article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue = "all") String condition, 
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "") String message,
			Model model) throws Exception {
		keyword = URLDecoder.decode(keyword, "utf-8");
		message = URLDecoder.decode(message, "utf-8");

		String query = "page=" + page;
		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword=" + URLEncoder.encode(keyword, "utf-8");
		}
		service.updateHitCount(num);

		Store dto = service.readProduct(num);
		if (dto == null) {
			return "redirect:/store/list?" + query;
		}
		
		List<Store> list1 = service.readProductFile(num);
		List<Store> listFile = service.listFile(num);
		
		Map<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("condition", condition);
		map.put("keyword", keyword);

		Store preReadDto = service.preReadProduct(map);
		Store nextReadDto = service.nextReadProduct(map);

		if(message.length()!=0) {
			model.addAttribute("message", message);			
		}
		model.addAttribute("dto", dto);
		model.addAttribute("list1", list1);
		model.addAttribute("listFile", listFile);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);

		return ".store.product.article";
	}
	
	@GetMapping("update")
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model
			)throws Exception{
		SessionInfo info =(SessionInfo)session.getAttribute("seller");
		Store dto = service.readProduct(num);
		
		if(dto==null) {
			return "redirect:/store/list?page="+page;
		}
		
		if(!info.getSellerId().equals(dto.getSellerId())){
			return "redirect:/store/list?page="+page;
		}
		model.addAttribute("dto",dto);
		model.addAttribute("mode","update");
		model.addAttribute("page",page);
		
		return ".store.product.created";
	}
	
	@PostMapping("update")
	public String updateSubmit(
			Store dto,
			@RequestParam String page,
			HttpSession session
			) throws Exception{
		
		try {
			service.updateProduct(dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return "redirect:/store/list?page=" + page;
	}
	
	@RequestMapping("delete")
	public String delete(
			@RequestParam String page,
			@RequestParam int num,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session
			) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("seller");
		
		keyword = URLDecoder.decode(keyword,"utf-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query +="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"utf-8");
		}
			service.delete(num, info.getSellerId());
		return "redirect:/store/list?"+query;
	}
	
}

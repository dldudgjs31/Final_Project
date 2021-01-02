package com.sp.app.qna;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.customer.Customer;
import com.sp.app.member.SessionInfo;

@Controller("qna.qnaController")
@RequestMapping("/qna/*")
public class QnaController {

	@Autowired
	QnaService service;
	@Autowired
	private MyUtil myUtil;
	/**
	 * 상품 글보기에 Q&A 리스트 노출
	 * @param page
	 * @param productNum
	 * @param session
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="listQna", method = RequestMethod.GET)
	public String list(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam int productNum,
			HttpSession session,
			HttpServletRequest req,
			Model model
			) throws Exception{
		Map<String, Object> map = new HashedMap<>();
		map.put("productNum", productNum);
		int current_page = page;
		int rows= 10;
		int dataCount = service.dataQnaCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);
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
		List<Qna> qnaList = service.listQna(map);
		int listNum=0; 
		int n = 0;
		for (Qna dto : qnaList) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			if(dto.getEnabled()==0) {
				dto.setStatus("답변대기");
			}else {
				dto.setStatus("답변완료");
			}
			n++;
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/qna/listQna";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("productNum",productNum);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("qnaList", qnaList);
		return "store/qna/list";
	}
	
	/**
	 * 상품글보기에서 글쓰기
	 * @param dto
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="insert")
	@ResponseBody
	public Map<String, Object> createForm(
			Qna dto,
			HttpSession session
			)throws Exception{
		String state="true";
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertQna(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashedMap<>();
		model.put("state", state);
		model.put("productNum", dto.getProductNum());
		return model;
	}
	
	@RequestMapping("mypage/qnalist")
	public String mypageQna(
			@RequestParam(value = "page", defaultValue = "1") int current_page,
			HttpSession session,
			HttpServletRequest req,
			Model model
			)throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashedMap<>();
		map.put("userId", info.getUserId());
		int rows= 10;
		int dataCount = service.dataMyQnaCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);
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
		List<Qna> qnaList = service.listMyQna(map);
		int listNum=0; 
		int n = 0;
		for (Qna dto : qnaList) {
			listNum = dataCount - (offset + n);
			dto.setListNum(listNum);
			if(dto.getEnabled()==0) {
				dto.setStatus("답변대기");
			}else {
				dto.setStatus("답변완료");
			}
			n++;
		}
		String cp = req.getContextPath();
		String listUrl = cp + "/qna/mypage/qnalist";
		String paging = myUtil.paging(current_page, total_page, listUrl);
		model.addAttribute("page",current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("paging", paging);
		model.addAttribute("qnaList", qnaList);
		return ".store.customer.qna";
	}
	@RequestMapping(value="delete", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int qnaNum,
			HttpSession session
			) throws Exception {
		String state="true";
		try {
			 Map<String, Object> map = new HashedMap<>();
			 map.put("qnaNum",qnaNum);
			 
			 service.deleteMyQna(map);
			} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashedMap<>();
		model.put("state", state);
		return model;
	}
	@RequestMapping(value="update", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateQna(
			HttpSession session,
			Qna dto
			) throws Exception {
		String state="true";
		try {
			 service.updateMyQna(dto);
			} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashedMap<>();
		model.put("state", state);
		return model;
	}
}

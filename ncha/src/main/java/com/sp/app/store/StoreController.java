package com.sp.app.store;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("store.storeController")
@RequestMapping("/store/*")
public class StoreController {
	/**
	 * 스토어 상품리스트
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("list")
	public String productList() throws Exception{
		
		return ".store.product.list";
	}
	/**
	 * 스토어 상품 올리기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("write")
	public String productCreated() throws Exception{
		
		return ".store.product.created";
	}
	
	/**
	 * 스토어 상품 글보기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("product")
	public String productArticle() throws Exception{
		
		return ".store.product.article";
	}
	
	
}

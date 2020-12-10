package com.sp.app.seller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private final Logger log = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest req,
			HttpServletResponse resp, Object handler) throws Exception {
		boolean result=true;
		
		try {
			HttpSession session=req.getSession();
			SessionInfo info =(SessionInfo)session.getAttribute("seller");
			String cp = req.getContextPath();
			String uri=req.getRequestURI();
			String queryString = req.getQueryString();//get 방식 파라미터
			
			if(info==null) {
				result=false;
				
				if(isAjaxRequest(req)) {
					resp.sendError(403); // AJAX에서 로그인이 안된경우 403 에러코드를 보냄
					return result;
				}
				if(uri.indexOf(cp)==0) {
					uri=uri.substring(req.getContextPath().length());
				}
				if(queryString!=null) {
					uri+="?"+queryString;
				}
				//로그인되지 않은 상태에서 요청한 주소를 세션에 저장
				session.setAttribute("preLoginURI", uri);
				//로그인화면으로 리다이렉트
				resp.sendRedirect(cp+"/seller/login");
			}
		} catch (Exception e) {
			log.error("pre: "+e.toString());
		}
		//false를 반환하면 handlerintercepter 또는 컨트롤러를 실행하지 않고 요청 종료
		return result;
	}

	/*
	   컨트롤러가 요청을 처리 한 후에 호출. 컨트롤러 실행 중 예외가 발생하면 실행 하지 않음  
	 */
	@Override
	public void postHandle(HttpServletRequest req,
			HttpServletResponse resp, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	/*
	  클라이언트 요청을 처리한 뒤, 즉 뷰를 통해 클라이언트에 응답을 전송한 뒤에 실행
	  컨트롤러 처리 중 또는 뷰를 생성하는 과정에 예외가 발생해도 실행  
	 */
	@Override
	public void afterCompletion(HttpServletRequest req,
			HttpServletResponse resp, Object handler, Exception ex)
			throws Exception {
	}
	
	//ajax 요청인지 확인하기 위한 메소드
	private boolean isAjaxRequest(HttpServletRequest req) {
		//AJAX 요청인 경우 헤더에 AJAX를 보내서 구분(개발자가 임의적으로 보내는 값)
		String h = req.getHeader("AJAX");
		return h!=null && h.equals("AJAX");
	}
}

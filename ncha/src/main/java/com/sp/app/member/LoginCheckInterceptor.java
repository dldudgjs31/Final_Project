package com.sp.app.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*
  * HandlerInterceptor 인터페이스
    - 컨트롤러가 요청하기 전과 후에 알 맞는 기능을 수행 할 수 있도록 하기 위한 인터페이스
    - 다수의 인터셉터가 설 정 된 경우 (a, b, c 인터셉터가 설정된경우)
      1) a 의 preHandle(),  b 의 preHandle(), c 의 preHandle() 실행
      2) 컨트롤러의 handleRequest() 메소드 실행
      3) c 의 postHandle(),  b 의 postHandle(), a 의 postHandle() 실행
      4) 뷰 객체의 render() 메소드 실행
      5) c 의 afterCompletion(),  b 의 afterCompletion(), a 의 afterCompletion() 실행
    - 로그인 검사, 응답 시간 계산, 이벤트기간 만료등에서 이용하면 편리
  
  * 인터셉터를 적용하기 위해서는 아래와 같이 HandlerInterceptor를 등록 해야 한다.
       특정 패턴의 url에만 인터셉터를 적용하기 위해서는 <mvc:interceptors>태그 내부에 <mvc:interceptor>를 사용한다. 
      <mvc:mapping path="/member/**" />
      <mvc:mapping path="/bbs/**" />
       처럼 여러개를 설정 할 수 있다.

    <mvc:interceptors>
      <mvc:interceptor>
          <mvc:mapping path="/**" />
        
          <mvc:exclude-mapping path="/"/>
          <mvc:exclude-mapping path="/member"/>
          <bean class="com.sp.app.member.LoginCheckInterceptor"/>
      </mvc:interceptor>
    </mvc:interceptors>
  
  * interceptor에 특정 URL Pattern을 제외하여 맵핑하는 기능도 지원하고 있다.
       이 때는 <mvc:interceptor>내부에서 <exclude-mapping>태그를 사용한다.
    <exclude-mapping>는  <mvc:mapping> 아래부분에 설정한다.
*/

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private final Logger log = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	/*
	   클라이언트 요청이 컨트롤러에 도착하기 전에 호출 
	       false를 리턴하면 HandlerInterceptor 또는 컨트롤러를 실행하지 않고 요청 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest req,
			HttpServletResponse resp, Object handler) throws Exception {
		boolean result=true;
		
		try {
			HttpSession session=req.getSession();
			SessionInfo info =(SessionInfo)session.getAttribute("member");
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
				resp.sendRedirect(cp+"/member/login");
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

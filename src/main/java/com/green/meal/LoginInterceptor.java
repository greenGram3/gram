package com.green.meal;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter   {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String requestURI = request.getRequestURI();
		if (session!=null && session.getAttribute("userId")!=null) {
			return true;
		}else {
			response.sendRedirect("/meal/login/login?requestURI="+requestURI);
			return false;
		}
//		return  true;

//		String requestURI = request.getRequestURI();
//		String uuid = UUID.randomUUID().toString();
//		request.setAttribute(LOG_ID, uuid);
//		//@RequestMapping: HandlerMethod
//		//정적 리소스: ResourceHttpRequestHandler
//		if (handler instanceof HandlerMethod) {
//			HandlerMethod hm = (HandlerMethod) handler; //호출할 컨트롤러 메서드의모든 정보가 포함되어 있다.
//		}
//		log.info("REQUEST [{}][{}][{}] : "+uuid+" "+requestURI+" "+handler);
//		return true; //false 진행

	}
}

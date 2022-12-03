package com.green.meal;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.UUID;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter   {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String requestURI = request.getRequestURI();

		String queryString = request.getQueryString();
		if(queryString != null) {
			requestURI += ("?"+ queryString);
		}

		log.info("requesturi : "+ requestURI);
		log.info("session : "+session.getAttribute("userId"));

		if (session!=null && session.getAttribute("userId")!=null) {
			return true;
		}else {
			response.sendRedirect("/meal/login/login?requestURI="+requestURI);
			return false;
		}
	}
}

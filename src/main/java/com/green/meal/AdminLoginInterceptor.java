package com.green.meal;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
public class AdminLoginInterceptor extends HandlerInterceptorAdapter   {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String requestURI = request.getRequestURI();

		String queryString = request.getQueryString();
		if(queryString != null) {
			requestURI += ("?"+ queryString);
		}

		if (session!=null && "admin".equals(session.getAttribute("userId"))) {
			return true;
		}else {
			response.sendRedirect("/meal/login/login?alertMsg=wrongAccess&requestURI="+requestURI);
			return false;
		}

	}
}

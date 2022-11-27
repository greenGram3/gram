package com.green.meal.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Slf4j
@Controller
public class addrController {
    @RequestMapping("/addr")
        String addr(HttpServletRequest request, String userId){
        HttpSession session = request.getSession();
        session.setAttribute("userId",userId);
        log.info("addrController session : "+String.valueOf(session));
        log.info("addrController session.userId :"+String.valueOf(session.getAttribute("userId")));
        return "addr";
    }
}

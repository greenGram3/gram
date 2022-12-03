package com.green.meal;

import java.text.DateFormat;
import java.util.*;

import com.green.meal.domain.EventVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.Items;
import com.green.meal.service.EventService;
import com.green.meal.service.ItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Handles requests for the application home page.
 */
@Slf4j
@Controller
@RequiredArgsConstructor
public class HomeController {
	private final ItemService itemService;
	private final EventService eventService;

	List<ItemVO> bestItems = new ArrayList<>();
	List<ItemVO> newItems = new ArrayList<>();

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {

		List<EventVO> eventList = eventService.selectBanner();
		model.addAttribute("eventList",eventList);

		List<ItemVO> list1 = itemService.bestItems();
		bestItems=list1.subList(0,8);
		model.addAttribute("bestItems",bestItems);


		List<ItemVO> list2 = itemService.newItems();
		newItems=list2.subList(0,8);
		model.addAttribute("newItems",newItems);


//		HttpSession session = request.getSession();
//		session.setAttribute("userId", "admin");
		return "home";

	}
}
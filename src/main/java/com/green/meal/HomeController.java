package com.green.meal;

import java.text.DateFormat;
import java.util.*;

import com.green.meal.domain.ItemVO;
import com.green.meal.domain.Items;
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

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpServletRequest request) {
//
//		Items item = new Items();
//		item.setItemPrice(10000);
//		item.setLimit(8);
//		Integer itemPrice1 = item.getItemPrice();
//		Integer limit1 = item.getLimit();
//		Map map = new HashMap<>();
//		map.put("itemPrice", itemPrice1);
//		map.put("limit", limit1);
//
//		List<ItemVO> itemList01 = itemService.homeItems(map);
//
//		model.addAttribute("itemList01", itemList01);
//
//		item.setItemPrice(15000);
//		Integer itemPrice2 = item.getItemPrice();
//
//
//		map.put("itemPrice", itemPrice2);
//
//		List<ItemVO> itemList02 = itemService.homeItems(map);
//
//		model.addAttribute("itemList02", itemList02);

		HttpSession session = request.getSession();
		session.setAttribute("userId", "admin");
		return "home";

	}
}
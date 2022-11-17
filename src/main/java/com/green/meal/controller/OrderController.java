package com.green.meal.controller;

import com.green.meal.domain.*;
import com.green.meal.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/order")
public class OrderController {

   @Autowired
    OrderService orderService;

    @GetMapping("/list")
    public String orderList(SearchCondition sc, Model m) {

        try {

            int totalCnt = orderService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<OrderDetailVO> list = orderService.getSearchResultPage(sc);

            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);



        } catch (Exception e) {
            m.addAttribute("msg", "LIST_ERR");
            e.printStackTrace();
        }

        return "admin/orderList";
    }

    @GetMapping("/read")
    public String read(Integer orderNo, SearchCondition sc, Model m) {

        try {

            List<OrderDetailVO> list = orderService.orderDetail(orderNo);
            m.addAttribute("list", list);

            return "admin/orderDetail";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "READ_ERR");

            return "admin/orderList";
        }
    }

    @PostMapping("/send")
    public String sendModify(Integer orderNo, Integer[] itemNoArr, Integer[] itemAmountArr, SearchCondition sc, Model m) {

        try {

            orderService.sendUpdate(itemNoArr, itemAmountArr, orderNo);

            m.addAttribute("orderNo", orderNo);
            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());
            m.addAttribute("msg", "SEND_OK");

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "SEND_ERR");
        }

        return "redirect:/order/read";

    }

    @PostMapping("/return")
    public String returnModify(Integer orderNo, Integer[] itemNoArr, Integer[] itemAmountArr, SearchCondition sc, Model m) {

        try {

            orderService.returnUpdate(itemNoArr, itemAmountArr, orderNo);

            m.addAttribute("orderNo", orderNo);
            m.addAttribute("page", sc.getPage());
            m.addAttribute("pageSize", sc.getPageSize());
            m.addAttribute("msg", "SEND_OK");

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "SEND_ERR");
        }

        return "redirect:/order/read";

    }
}



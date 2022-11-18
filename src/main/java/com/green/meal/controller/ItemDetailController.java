package com.green.meal.controller;

import com.green.meal.domain.*;
import com.green.meal.service.DelyService;
import com.green.meal.service.ItemService;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ItemDetailController {
    @Autowired
    ItemService itemService;
    @Autowired
    DelyService delyService;

    // item 상세페이지------------------------------------------------------------- //
    @RequestMapping(value="/itemDetail")
    public String itemDetail(ItemVO vo, Model m) {
        try {
            vo = itemService.itemdetail(vo);
            m.addAttribute("itemResult",vo);

            return "item/itemDetail" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail error");

            return "redirect:home";
        }
    } //itemDetail

    // ** itemDetailPage(Ajax)
    @RequestMapping(value="/itemDetailPage")
    public String itemDetailPage(Model m, ImageVO vo1, ItemVO vo) {
        try {
            vo1.setItemNo(vo1.getItemNo());
            vo = itemService.itemdetail(vo);
            vo1 = itemService.imageDetail(vo1);

            m.addAttribute("itemResult",vo);
            m.addAttribute("imageResult",vo1);

            return "item/itemDetailPage" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail_page error");

            return "redirect:itemDetail?itemNo="+vo1.getItemNo();
        }
    }

    // ** DeliInfo(Ajax)
    @RequestMapping(value="/deliInfo")
    public String itemDetailPage(Model m) {
        return "item/itemDelyInfo";
    }


    //    ========= 상세페이지->결제페이지 작업 중 코드(정무혁) =============

    @RequestMapping("/buy")
    public String buy(OrderDetailDto dto, Integer totalItemPrice, Model m, HttpServletRequest request) {

        HttpSession session = request.getSession();
        session.setAttribute("userId", "aaa1111");
        String userId = (String)session.getAttribute("userId");

        List<DeliveryVO> list = delyService.delySelect(userId);

        m.addAttribute("totalItemPrice", totalItemPrice);
        m.addAttribute("dto", dto);
        m.addAttribute("list", list);

        return "payment";
    }

    @PostMapping("/paymentConfirm")
    public String paymentConfirm() {
        return "paymentConfirm";
    }

} //itemDetailController

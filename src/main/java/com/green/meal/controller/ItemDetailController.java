package com.green.meal.controller;

import com.green.meal.domain.*;
import com.green.meal.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ItemDetailController {
    @Autowired
    ItemService itemService;

    // item 상세페이지------------------------------------------------------------- //
    @RequestMapping(value="/itemDetail")
    public String itemDetail(ItemVO vo, Model m, ImageVO vo1) {
        try {
            List<ImageVO> list = new ArrayList<ImageVO>();
            vo = itemService.itemdetail(vo);
            list = itemService.imageDetail(vo1);

            m.addAttribute("itemResult",vo);
            m.addAttribute("imageResult",list);

            return "itemDetail" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail error");

            return "redirect:home";
        }
    } //itemDetail

    // ** itemDetailPage(Ajax)
    @RequestMapping(value="/itemDetailPage")
    public String itemDetailPage(ItemVO vo, Model m) {
        try {
            vo = itemService.itemdetail(vo);
            m.addAttribute("itemResult",vo);

            return "itemDetailPage" ;

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("message", "item_detail_page error");

            return "redirect:itemDetail?itemNo="+vo.getItemNo();
        }
    }

    // ** DeliInfo(Ajax)
    @RequestMapping(value="/deliInfo")
    public String itemDetailPage(Model m) {
        return "itemDelyInfo";
    }


    //    ========= 상세페이지->결제페이지 작업 중 코드(정무혁) =============

    @RequestMapping("/buy")
    public String buy(OrderDetailDto dto, Integer totalItemPrice, Model m) {
        m.addAttribute("totalItemPrice", totalItemPrice);
        m.addAttribute("dto", dto);
        return "payment";
    }

    @PostMapping("/paymentConfirm")
    public String paymentConfirm() {
        return "paymentConfirm";
    }

} //itemDetailController

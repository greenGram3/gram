package com.green.meal.controller;

import com.green.meal.domain.*;
import com.green.meal.service.DelyService;
import com.green.meal.service.ItemService;
import com.green.meal.service.UserService;
import org.apache.commons.lang.RandomStringUtils;
import org.checkerframework.checker.units.qual.A;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

@Controller
public class ItemDetailController {
    @Autowired
    ItemService itemService;

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
    public String itemDetailPage() {
        return "item/itemDelyInfo";
    }


} //itemDetailController

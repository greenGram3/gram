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
    @Autowired
    DelyService delyService;
    @Autowired
    UserService userService;

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

        try {

            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            session.setAttribute("userId", "aaa1111");
            String userId = (String)session.getAttribute("userId");

            //배송지 리스트 얻어오기
            List<DeliveryVO> list = delyService.delySelect(userId);
            UserVO vo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            Calendar dateTime = Calendar.getInstance();
            uniqueNo = sdf.format(dateTime.getTime())+"_"+ RandomStringUtils.randomAlphanumeric(6);

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보 -> jsp 전달
            m.addAttribute("totalItemPrice", totalItemPrice);
            m.addAttribute("dto", dto);
            m.addAttribute("list", list);
            m.addAttribute("vo", vo);
            m.addAttribute("uniqueNo", uniqueNo);

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("dto", dto);
            return "redirect:item/itemDetail";
        }
    }

    //주문페이지에서 배송지 상세정보를 볼 수 있도록 해주는 메서드
    @GetMapping("/delyView")
    public String delyView(HttpServletRequest request, Model m, String delyPlace, DeliveryVO vo) {

        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");

        HashMap map = new HashMap();
        map.put("userId", userId);
        map.put("delyPlace", delyPlace);

        vo = delyService.selectedDely(map);

        m.addAttribute("vo", vo);

        return "delyView";
    }

    @PostMapping("/paymentConfirm")
    public String paymentConfirm(OrderDetailDto dto, Integer totalItemPrice, String delyPlace, Model m, HttpServletRequest request, DeliveryVO vo) {

        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");

        HashMap map = new HashMap();
        map.put("userId", userId);
        map.put("delyPlace", delyPlace);

        vo = delyService.selectedDely(map);

        m.addAttribute("dto", dto);
        m.addAttribute("totalItemPrice", totalItemPrice);
        m.addAttribute("vo", vo);

        return "paymentConfirm";
    }

} //itemDetailController

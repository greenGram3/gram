package com.green.meal.controller;

import com.green.meal.domain.*;
import com.green.meal.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;

@Controller
@RequestMapping("/order")
public class OrderController {

   @Autowired
   OrderService orderService;

    @GetMapping("/list")
    public String orderList(SearchCondition sc, Model m) {

        try {

            //주문건 전체개수 구하기
            int totalCnt = orderService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            //페이지핸들러 만들기
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            //주문리스트 불러오기
            List<OrderDetailVO> list = orderService.getSearchResultPage(sc);

            //페이지핸들러, 주문리스트 -> jsp로 보내기
            m.addAttribute("ph", pageHandler);
            m.addAttribute("list", list);

        } catch (Exception e) {
            m.addAttribute("msg", "LIST_ERR");
            e.printStackTrace();
        }

        return "admin/orderList";
    }

    @GetMapping("/read")
    public String read(Integer orderNo, SearchCondition sc, Model m) {

        try {

            //주문상세 정보를 상품별로 가져오기 때문에 List에 담기
            List<OrderDetailVO> list = orderService.orderDetail(orderNo);
            
            //DB에는 우편번호, 주소, 상세주소가 있기 때문에 jsp에는 구분자를 없애고 합쳐서 띄워줘야됨
            String delyAddrTemp = list.get(0).getDelyAddr();
            String[] addrs = delyAddrTemp.split("@");
            String delyAddr = addrs[1] + " " + addrs[2];
            list.get(0).setDelyAddr(delyAddr);
            
            m.addAttribute("list", list);

            //주문 상세보기 페이지로
            return "admin/orderDetail";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "READ_ERR");

            //상세보기 실패하면 다시 상품 리스트로
            return "admin/orderList";
        }
    }

    @PostMapping("/send")
    public String sendModify(Integer orderNo, Integer[] itemNoArr, Integer[] itemAmountArr, SearchCondition sc, RedirectAttributes rattr) {

        try {

            //발송처리 눌렀을 때 주문상태를 주문완료->배송중, 아이템 재고 줄이기 두개 동시 실행
            orderService.sendUpdate(itemNoArr, itemAmountArr, orderNo);

            rattr.addAttribute("orderNo", orderNo);
            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());
            rattr.addFlashAttribute("msg", "SEND_OK");

        } catch (Exception e) {
            e.printStackTrace();
            rattr.addAttribute("orderNo", orderNo);
            rattr.addFlashAttribute("msg", "SEND_ERR");
        }

        //발송처리 하면 주문상태, 상품재고 변경되고 다시 상품 상세보기로
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



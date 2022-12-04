package com.green.meal.controller;

import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderListDto;
import com.green.meal.domain.OrderSearch;
import com.green.meal.service.UserOrderService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage")
public class UserOrderController {

    private final UserOrderService userOrderService;


    @GetMapping("/order")
    public String getList( Model model, HttpSession httpSession){

        //회원의 주문정보 가져오기
        String userId = getUserId(httpSession);

        try {
            List<OrderListDto> orderList = userOrderService.orderUserInfo(userId);
            model.addAttribute("orderList",orderList);
        }catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("msg", "LIST_ERR");
        }
        return "userOrderList";
    }


    @GetMapping("/cancel")
    public String cancelList( Model model, HttpSession httpSession){

        //회원의 취소주문정보 가져오기
        String userId = getUserId(httpSession);
    try {
        List<OrderListDto> orderList = userOrderService.cancelList(userId);
        model.addAttribute("orderList",orderList);
        model.addAttribute("cancel","cancel");
        }catch (Exception e){
        e.printStackTrace();
        model.addAttribute("msg", "LIST_ERR");
        }
        return "userOrderList";
    }


    //날짜별 주문목록 검색
    @PostMapping ("/list")
    public String searchOrder(OrderSearch orderSearch, Model model, HttpSession httpSession){
        String userId = getUserId(httpSession);
        //시작날짜나 종료날짜중 하나라도 빈칸일시 돌아가기
        if("".equals(orderSearch.getStartDate()) || "".equals(orderSearch.getEndDate())){
            model.addAttribute("msg","null");
            return "userOrderList";
        }

        try {
            //회원의 날짜별 주문정보 가져오기
            orderSearch.setUserId(userId);
            List<OrderListDto> orderList = userOrderService.searchOrder(orderSearch);
            model.addAttribute("orderList",orderList);
        }catch (Exception e){
            e.printStackTrace();
            e.printStackTrace();
            model.addAttribute("msg", "LIST_ERR");
        }
        return "userOrderList";
    }



    @GetMapping("/list")
    public String orderDetail(String order,Model model,HttpSession httpSession){

        String userId = getUserId(httpSession);
        //맵핑된 주문번호 정리하기
        Integer orderNo = Integer.parseInt(order.substring(15));
        try {
            OrderListDto orderListDto = userOrderService.order(userId,orderNo);
            model.addAttribute(orderListDto);
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg", "READ_ERR");
        }
        return "userOrderDetail";
    }

    //주문상태 변경하기
    @PatchMapping("/{orderNo}")
    public ResponseEntity<String> orderConfirm(@PathVariable Integer orderNo, @RequestBody OrderListDto orderListVO , HttpSession session) {

        String userId = getUserId(session);

        orderListVO.setUserId(userId);
        orderListVO.setOrderNo(orderNo);
        try {
            if(userOrderService.orderConfirm(orderListVO) != 1)
                throw new Exception("confirm failed");
            return new ResponseEntity<>("MOD_OK",HttpStatus.OK);
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }
    }

    //세션에서 회원 아이디 가져오기
    private static String getUserId(HttpSession httpSession) {

        return (String) httpSession.getAttribute("userId");
    }


}

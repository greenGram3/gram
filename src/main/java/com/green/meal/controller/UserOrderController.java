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

    @Autowired
    UserController userController;

    //결제페이지 에서 주문내역으로 저장
//    @PostMapping("/save")
//    public void save(List<OrderDetailDto> orderItemVO, OrderListDto orderListVO){
//
//        userOrderService.save(orderItemVO, orderListVO);
//
//    }

    @GetMapping("/order")
    public String getList( Model model, HttpSession httpSession){

        //회원의 주문정보 가져오기
        String userId = (String) httpSession.getAttribute("userId") ;


        List<OrderListDto> orderList = userOrderService.orderUserInfo(userId);

        setOrder(orderList);

        model.addAttribute("orderList",orderList);

        return "userOrderList";
    }

    @GetMapping("/cancel")
    public String cancelList( Model model, HttpSession httpSession){

        //회원의 주문정보 가져오기
        String userId = (String) httpSession.getAttribute("userId");

        List<OrderListDto> orderList = userOrderService.cancelList(userId);

        setOrder(orderList);

        model.addAttribute("orderList",orderList);
        model.addAttribute("cancel","cancel");

        return "userOrderList";
    }


    private void setOrder(List<OrderListDto> orderList) {
        for (OrderListDto listVO : orderList) {
            //회원의 주문번호별 결제한 상품내역 리스트에 담기
            List<OrderDetailDto> list = userOrderService.orderItemInfo(listVO.getOrderNo());
            //주문번호
            listVO.setOrder(listVO.getOrderDate()+"-0000"+listVO.getOrderNo());
            listVO.setList(list);

            String tmp = null;
            Integer totalPay = 0;

            for (OrderDetailDto orderDetailVO : list) {
                totalPay +=orderDetailVO.getItemPrice();
                tmp +="@"+ orderDetailVO.getItemName();
            }

            String[] splitItem = tmp.split("@");
            int length = splitItem.length;

            //주문리스트 대표상품이름
            String totalItem = splitItem[1];
            if(length>2){
                totalItem = splitItem[1]+" 외"+(length-2)+" 건";
            }


            listVO.setTotalItem(totalItem);
            listVO.setTotalPay(totalPay);

        }
    }

    @PostMapping ("/list")
    public String searchOrder(OrderSearch orderSearch, Model model, HttpSession httpSession){

        log.info("orderSearch={}",orderSearch);

        if(orderSearch.getStartDate() == "" || orderSearch.getEndDate()==""){
            model.addAttribute("msg","null");
            return "userOrderList";
        }
        //회원의 날짜별 주문정보 가져오기
        String userId = (String) httpSession.getAttribute("userId") ;
        orderSearch.setUserId(userId);
        List<OrderListDto> orderList = userOrderService.searchOrder(orderSearch);


        setOrder(orderList);

        model.addAttribute("orderList",orderList);

        return "userOrderList";
    }



    @GetMapping("/list")
    public String orderDetail(String order,Model model,HttpSession httpSession){

        Integer orderNo = Integer.parseInt(order.substring(15));
        String userId = (String)httpSession.getAttribute("userId");



        Map map = new HashMap<>();
        map.put("userId",userId);
        map.put("orderNo",orderNo);

        OrderListDto orderListDto = userOrderService.order(map);
        orderListDto.setOrder(orderListDto.getOrderDate()+"-0000"+orderListDto.getOrderNo());

        String delyAdd = orderListDto.getDelyAddr();

        String[] addrs = delyAdd.split("@");

        String delyAddr  = addrs[1] + " " + addrs[2];
        orderListDto.setDelyAddr(delyAddr);

        //주문번호로 검색한 상품 보여주기( 주문 상세 페이지 )
        List<OrderDetailDto> list = userOrderService.orderItemInfo(orderNo);
        Integer totalPay = 0;
        for (OrderDetailDto orderDetailDto : list) {
            totalPay +=orderDetailDto.getItemPrice();
        }

        orderListDto.setTotalPay(totalPay);
        orderListDto.setList(list);
        model.addAttribute(orderListDto);
        return "userOrderDetail";
    }

    @PatchMapping("/{orderNo}")
    public ResponseEntity<String> orderConfirm(@PathVariable Integer orderNo, @RequestBody OrderListDto orderListVO , HttpSession session) {
        String userId = (String)session.getAttribute("userId");
        orderListVO.setUserId(userId);
        orderListVO.setOrderNo(orderNo);
        log.info("orderListVO={}",orderListVO);
        int rowCnt = userOrderService.orderConfirm(orderListVO);

        try {
            if(rowCnt!=1) {
                throw new Exception("confirm failed");
            }
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("MOD_ERR", HttpStatus.BAD_REQUEST);
        }

        return new ResponseEntity<>("MOD_OK",HttpStatus.OK);
    }
}

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


        List<OrderListDto> orderList = userOrderService.orderUserInfo(userId);
        // 주문 번호및 주문 목록의 대표 이름 정하기
        setOrder(orderList);

        model.addAttribute("orderList",orderList);

        return "userOrderList";
    }



    @GetMapping("/cancel")
    public String cancelList( Model model, HttpSession httpSession){

        //회원의 취소주문정보 가져오기
        String userId = getUserId(httpSession);

        List<OrderListDto> orderList = userOrderService.cancelList(userId);
        // 주문 번호및 주문 목록의 대표 이름 정하기
        setOrder(orderList);

        model.addAttribute("orderList",orderList);
        model.addAttribute("cancel","cancel");

        return "userOrderList";
    }


    // 주문 번호및 주문 목록의 대표 이름 정하기
    private void setOrder(List<OrderListDto> orderList) {
        for (OrderListDto listVO : orderList) {
            //회원의 주문번호별 결제한 상품내역 리스트에 담기
            List<OrderDetailDto> list = userOrderService.orderItemInfo(listVO.getOrderNo());
            //주문번호 셋팅 ( 보여주기 식 )
            listVO.setOrder(listVO.getOrderDate()+"-0000"+listVO.getOrderNo());
            listVO.setList(list);

            String tmp = null;
            Integer totalPay = 0;
            //주문목록에서 상품 금액 합치기, 주문한상품들 이름 더하기 ( 대표이름 )
            for (OrderDetailDto orderDetailVO : list) {
                totalPay +=(orderDetailVO.getItemPrice()*orderDetailVO.getItemAmount());
                tmp +="@"+ orderDetailVO.getItemName();
            }

            String[] splitItem = tmp.split("@");
            int length = splitItem.length;

            //주문리스트 대표상품이름
            String totalItem = splitItem[1];
            //2건 이상일때 외 건 붙이기
            if(length>2){
                totalItem = splitItem[1]+" 외"+(length-2)+" 건";
            }


            listVO.setTotalItem(totalItem);
            listVO.setTotalPay(totalPay);

        }
    }

    //날짜별 주문목록 검색
    @PostMapping ("/list")
    public String searchOrder(OrderSearch orderSearch, Model model, HttpSession httpSession){

        log.info("orderSearch={}",orderSearch);
        //시작날짜나 종료날짜중 하나라도 빈칸일시 돌아가기
        if("".equals(orderSearch.getStartDate()) || "".equals(orderSearch.getEndDate())){
            model.addAttribute("msg","null");
            return "userOrderList";
        }
        //회원의 날짜별 주문정보 가져오기
        String userId = getUserId(httpSession);
        orderSearch.setUserId(userId);
        List<OrderListDto> orderList = userOrderService.searchOrder(orderSearch);

        // 주문 번호및 주문 목록의 대표 이름 정하기
        setOrder(orderList);

        model.addAttribute("orderList",orderList);

        return "userOrderList";
    }



    @GetMapping("/list")
    public String orderDetail(String order,Model model,HttpSession httpSession){
        //맵핑된 주문번호 정리하기
        Integer orderNo = Integer.parseInt(order.substring(15));
        String userId = getUserId(httpSession);


        Map map = new HashMap<>();
        map.put("userId",userId);
        map.put("orderNo",orderNo);

        OrderListDto orderListDto = userOrderService.order(map);
        orderListDto.setOrder(orderListDto.getOrderDate()+"-0000"+orderListDto.getOrderNo());
        //배송지 세팅하기
        String delyAdd = orderListDto.getDelyAddr();

        String[] addrs = delyAdd.split("@");

        String delyAddr  = addrs[1] + " " + addrs[2];
        orderListDto.setDelyAddr(delyAddr);

        //주문번호로 검색한 상품 보여주기( 주문 상세 페이지 )
        List<OrderDetailDto> list = userOrderService.orderItemInfo(orderNo);
        Integer totalPay = 0;
        for (OrderDetailDto orderDetailDto : list) {
            totalPay +=(orderDetailDto.getItemPrice()*orderDetailDto.getItemAmount());
        }

        orderListDto.setTotalPay(totalPay);
        orderListDto.setList(list);
        model.addAttribute(orderListDto);
        return "userOrderDetail";
    }

    //주문상태 변경하기
    @PatchMapping("/{orderNo}")
    public ResponseEntity<String> orderConfirm(@PathVariable Integer orderNo, @RequestBody OrderListDto orderListVO , HttpSession session) {

        String userId = getUserId(session);

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

    //세션에서 회원 아이디 가져오기
    private static String getUserId(HttpSession httpSession) {
        return (String) httpSession.getAttribute("userId");
    }


}

package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.UserVO;
import com.green.meal.service.DelyService;
import com.green.meal.service.OrderService;
import com.green.meal.service.UserService;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/buy")
public class PaymentController {

    @Autowired
    DelyService delyService;
    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;

    //제품 상세페이지에서 바로 주문 결제페이지로 넘어가는 메서드
    @PostMapping("/payment")
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

        //세션으로 아이디 얻어오기
        HttpSession session = request.getSession();
        String userId = (String)session.getAttribute("userId");

        //아이디와 배송지명을 이용해서 배송지정보 얻어오기
        HashMap map = new HashMap();
        map.put("userId", userId);
        map.put("delyPlace", delyPlace);

        vo = delyService.selectedDely(map);

        //배송지정보 -> jsp로 전달
        m.addAttribute("vo", vo);

        return "delyView";
    }

    //결제 후 결제확인 창으로 이동하는 메서드
    @PostMapping("/confirm")
    public String paymentConfirm(Integer totalItemPrice, String delyPlace, Model m, HttpServletRequest request, DeliveryVO vo, OrderDetailVO odvo) {

        try {
            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            String userId = (String)session.getAttribute("userId");

            //아이디와 배송지명을 이용해서 배송지 주소 얻어오기
            HashMap map = new HashMap();
            map.put("userId", userId);
            map.put("delyPlace", delyPlace);

            vo = delyService.selectedDely(map);
            System.out.println("vo = " + vo);

            //order_list에 구매정보 insert (실패)
//            String test = vo.getDelyAddr();
//            System.out.println("test = " + test);
//
//            odvo.setUserId(userId);
//            odvo.setDelyAddr(vo.getDelyAddr());
//            int rowCnt = orderService.buyInfoToList(odvo);
//            if(rowCnt!=1) {
//                throw new Exception("buyInfoToList error");
//            }

            //구매한 제품 정보, 총 구매금액, 배송지 정보 -> jsp로 전달
            m.addAttribute("dto", odvo);
            m.addAttribute("totalItemPrice", totalItemPrice);
            m.addAttribute("vo", vo);

            return "paymentConfirm";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("dto", odvo);
            return "redirect:item/itemDetail";
        }

    }

}

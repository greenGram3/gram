package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.UserVO;
import com.green.meal.service.DelyService;
import com.green.meal.service.OrderService;
import com.green.meal.service.UserOrderService;
import com.green.meal.service.UserService;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/buy")
public class PaymentController {

    @Autowired
    DelyService delyService;
    @Autowired
    UserService userService;
    @Autowired
    OrderService orderService;
    @Autowired
    UserOrderService userOrderService;

    //제품 상세페이지에서 바로 주문 결제페이지로 넘어가는 메서드
    @PostMapping("/payment")
    public String buy(OrderDetailVO vo, Integer totalItemPrice, Model m, HttpServletRequest request) {

        try {

            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            session.setAttribute("userId", "aaa1111");
            String userId = (String)session.getAttribute("userId");

            //배송지 리스트 얻어오기
            List<DeliveryVO> list = delyService.delySelect(userId);
            UserVO userVo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            Calendar dateTime = Calendar.getInstance();
            uniqueNo = sdf.format(dateTime.getTime())+"_"+ RandomStringUtils.randomAlphanumeric(6);

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보 -> jsp 전달
            m.addAttribute("totalItemPrice", totalItemPrice);
            m.addAttribute("vo", vo);
            m.addAttribute("list", list);
            m.addAttribute("userVo", userVo);
            m.addAttribute("uniqueNo", uniqueNo);

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("vo", vo);
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

    @PostMapping("/delyUpdate")
    public String delyUpdate(DeliveryVO vo, String newReceiver, String newDelyPhone, String newDelyAddr, HttpServletResponse response, Model m, HttpSession session){

        response.setContentType("text/html; charset=UTF-8");

        try {

            //수정 전 배송지 정보에 아이디 담기
            vo.setUserId((String) session.getAttribute("userId"));

            // 수정하는 값들 vo에 저장
            DeliveryVO newDelyVo = new DeliveryVO();
            newDelyVo.setDelyPlace(vo.getDelyPlace());
            newDelyVo.setReceiver(newReceiver);
            newDelyVo.setDelyPhone(newDelyPhone);
            newDelyVo.setDelyAddr(newDelyAddr);

            //배송지 정보 변경하기
            int rowCnt = delyService.updateDelivery3(vo, newDelyVo);
            if(rowCnt!=1) {
                throw new Exception("update delivery error");
            }

            m.addAttribute("vo", newDelyVo);

        } catch (Exception e) {
            //error 로그 찍기
            e.printStackTrace();
            m.addAttribute("vo", vo);
        }

        return "delyView";

    }

    //결제 후 결제확인 창으로 이동하는 메서드
    @PostMapping("/confirm")
    public String paymentConfirm(Integer totalItemPrice, String delyPlace, Model m, HttpServletRequest request, OrderDetailVO odvo) {

        try {
            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            session.setAttribute("userId", "aaa1111");
            String userId = (String)session.getAttribute("userId");

            //아이디와 배송지명을 이용해서 배송지 주소 얻어오기
            HashMap map = new HashMap();
            map.put("userId", userId);
            map.put("delyPlace", delyPlace);
            DeliveryVO vo = new DeliveryVO();
            vo = delyService.selectedDely(map);

            //구매자 정보 주문내용에 담기 (구매상품에 대한 정보는 이미 담겨있음)
            odvo.setUserId(userId);
            odvo.setUserPhone(vo.getDelyPhone());
            odvo.setDelyAddr(vo.getDelyAddr());
            odvo.setReceiver(vo.getReceiver());
            //구매상품 종류가 한개여도 리스트에 담아서 보내기
            List<OrderDetailVO> list = new ArrayList<>();
            list.add(odvo);

            //구매정보 order_list, order_detail에 넣기
            userOrderService.save(list, odvo);

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

package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.UserVO;
import com.green.meal.service.*;
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
    @Autowired
    CartService cartService;

    //제품 상세페이지에서 바로 주문 결제페이지로 넘어가는 메서드
    @PostMapping("/payment")
    public String buy(OrderDetailVO odvo, Integer totalPrice, Model m, HttpServletRequest request) {

        try {

            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            String userId = (String)session.getAttribute("userId");

            //넘어온 구매상품정보 리스트에 담기(한개여도 리스트에 담기)
            List<OrderDetailVO> odvoList = new ArrayList<>();
            odvoList.add(odvo);

            //배송지 리스트 얻어오기
            List<DeliveryVO> delyList = delyService.delySelect(userId);

            //구매고객 정보 얻어오기
            UserVO userVo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            Calendar dateTime = Calendar.getInstance();
            uniqueNo = sdf.format(dateTime.getTime())+"_"+ RandomStringUtils.randomAlphanumeric(6);

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보 -> jsp 전달
            m.addAttribute("odvoList", odvoList);
            m.addAttribute("totalPrice", totalPrice);
            m.addAttribute("delyList", delyList);
            m.addAttribute("userVo", userVo);
            m.addAttribute("uniqueNo", uniqueNo);

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/buy/payment";
        }
    }

    @PostMapping("/cartPayment")
    public String cartBuy(HttpServletRequest request, Integer totalPrice, Model m) {

        try {
            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
//            session.setAttribute("userId", "aaa1111");
            String userId = (String)session.getAttribute("userId");

            //해당 아이디의 장바구니 상품들 가져오기
            List<OrderDetailVO> odvoList = new ArrayList<>();
            odvoList = cartService.buyCartList(userId);

            //배송지 리스트 얻어오기
            List<DeliveryVO> delyList = delyService.delySelect(userId);

            //구매고객 정보 얻어오기
            UserVO userVo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = "";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
            Calendar dateTime = Calendar.getInstance();
            uniqueNo = sdf.format(dateTime.getTime())+"_"+ RandomStringUtils.randomAlphanumeric(6);

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보 -> jsp 전달
            m.addAttribute("totalPrice", totalPrice);
            m.addAttribute("odvoList", odvoList);
            m.addAttribute("delyList", delyList);
            m.addAttribute("userVo", userVo);
            m.addAttribute("uniqueNo", uniqueNo);
            m.addAttribute("orderType", "cartOrder");

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/buy/payment";
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

    //주문페이지에서 배송지 정보를 수정할 수 있는 메서드
    @PostMapping("/delyUpdate")
    public String delyUpdate(DeliveryVO vo, String newReceiver, String newDelyPhone, String roadAddrPart1, String addrDetail, HttpServletResponse response, Model m, HttpSession session){

        try {

            response.setContentType("text/html; charset=UTF-8");

            //수정 전 배송지 정보에 아이디 담기
            vo.setUserId((String) session.getAttribute("userId"));

            //api로 입력받은 도로명 주소 -> 새로운 주소로 조합
            String newDelyAddr = roadAddrPart1+" "+addrDetail;

            // 수정하는 값들 vo에 저장
            DeliveryVO newDelyVo = new DeliveryVO();
            newDelyVo.setDelyPlace(vo.getDelyPlace());
            newDelyVo.setReceiver(newReceiver);
            newDelyVo.setDelyPhone(newDelyPhone);
            if(" ".equals(newDelyAddr)) {
                newDelyVo.setDelyAddr(vo.getDelyAddr());
            } else {
                newDelyVo.setDelyAddr(newDelyAddr);
            }

            //배송지 정보 변경하기
            int rowCnt = delyService.updateDelivery3(vo, newDelyVo);
            if(rowCnt!=1) {
                throw new Exception("update delivery error");
            }

            m.addAttribute("vo", newDelyVo);

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("vo", vo);
        }

        return "delyView";

    }

    //결제 후 결제확인 창으로 이동하는 메서드
    @PostMapping("/confirm")
    public String paymentConfirm(Integer totalPrice, String orderType, String delyPlace, Model m, HttpServletRequest request, OrderDetailVO odvo) {

        try {
            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            String userId = (String)session.getAttribute("userId");

            //아이디와 배송지명을 이용해서 배송지 주소 얻어오기
            HashMap map = new HashMap();
            map.put("userId", userId);
            map.put("delyPlace", delyPlace);
            DeliveryVO vo = new DeliveryVO();
            vo = delyService.selectedDely(map);

            //구매자 정보 주문내용에 담기(order_list에 넣을 것) (구매상품에 대한 정보는 이미 담겨있음)
            odvo.setUserId(userId);
            odvo.setUserPhone(vo.getDelyPhone());
            odvo.setDelyAddr(vo.getDelyAddr());
            odvo.setReceiver(vo.getReceiver());

            //카트주문과 단건주문 구분하여 처리
            List<OrderDetailVO> odvoList = new ArrayList<>();
            if (orderType.equals("cartOrder")) {
                odvoList = cartService.buyCartList(userId);
            } else {
                odvoList.add(odvo);
            }

            //구매정보 order_list, order_detail에 넣기
            userOrderService.save(odvoList, odvo);

            //총 구매금액, 배송지 정보, 구매한 제품 정보 -> jsp로 전달
            m.addAttribute("totalPrice", totalPrice);
            m.addAttribute("vo", vo);
            m.addAttribute("odvoList", odvoList);

            return "paymentConfirm";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:item/itemDetail";
        }

    }

}

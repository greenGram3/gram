package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.UserVO;
import com.green.meal.service.*;
import lombok.extern.slf4j.Slf4j;
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

@Slf4j
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

            //배송지 리스트 얻어오기, 주소 형태변환
            List<DeliveryVO> delyList = getDelyList(userId);

            //구매고객 정보 얻어오기 - 주문시 주문자 정보 띄워주기 위해
            UserVO userVo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = getUniqueNo();

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보 -> jsp 전달
            m.addAttribute("odvoList", odvoList);
            m.addAttribute("totalPrice", totalPrice);
            m.addAttribute("delyList", delyList);
            m.addAttribute("userVo", userVo);
            m.addAttribute("uniqueNo", uniqueNo);

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            //에러 발생하면 메세지 띄워주고 원래 있던 상품 상세페이지로 이동
            m.addAttribute("itemNo", odvo.getItemNo());
            m.addAttribute("msg", "PAY_ERR");
            return "redirect:/item/itemDetail";
        }
    }

    //장바구니에서 결제하기 눌렀을 때 주문페이지로 이동하는 메서드
    @PostMapping("/cartPayment")
    public String cartBuy(HttpServletRequest request, Integer totalPrice, Model m) {

        try {

            //세션으로 아이디 얻어오기
            HttpSession session = request.getSession();
            String userId = (String)session.getAttribute("userId");

            //해당 아이디의 장바구니 상품들 db에서 가져오기
            List<OrderDetailVO> odvoList = new ArrayList<>();
            odvoList = cartService.buyCartList(userId);

            //배송지 리스트 얻어오기, 주소 형태변환
            List<DeliveryVO> delyList = getDelyList(userId);

            //구매고객 정보 얻어오기
            UserVO userVo = userService.userDetail(userId);

            //임시주문번호제작
            String uniqueNo = getUniqueNo();

            //전체금액, 구매할상품정보, 구매자배송지정보, 구매자정보, 임시주문정보, 카트결제여부 -> jsp 전달
            m.addAttribute("totalPrice", totalPrice);
            m.addAttribute("odvoList", odvoList);
            m.addAttribute("delyList", delyList);
            m.addAttribute("userVo", userVo);
            m.addAttribute("uniqueNo", uniqueNo);
            m.addAttribute("orderType", "cartOrder");

            return "payment";

        } catch (Exception e) {
            e.printStackTrace();
            //주문페이지로 이동 실패하면 홈으로 이동
            m.addAttribute("msg", "CARTPAY_ERR");
            return "redirect:/";
        }

    }

    //주문페이지에서 배송지 상세정보를 볼 수 있도록 해주는 메서드
    @GetMapping("/delyView")
    public String delyView(HttpServletRequest request,Model m, String delyPlace, String dely ,DeliveryVO vo) {

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

        //주소 띄워줄 때 주소 형태 변경해서 보여주기 (쪼개기)
        String[] delyAddr = vo.getDelyAddr().split("@");
        session.setAttribute("userId", userId);
        m.addAttribute("zipNo", delyAddr[0]);
        m.addAttribute("roadAddrPart1", delyAddr[1]);
        m.addAttribute("addrDetail", delyAddr[2]);

        String newAdder = (delyAddr[1]+" "+delyAddr[2]);

        m.addAttribute("newAdder",newAdder);
        m.addAttribute("dely",dely);

        return "delyView";
    }

    //주문페이지에서 배송지 정보를 수정할 수 있는 메서드
    @PostMapping("/delyUpdate")
    public String delyUpdate(DeliveryVO vo, String newReceiver, String newDelyPhone, String zipNo, String roadAddrPart1, String addrDetail,
                             String dely, HttpServletRequest request, HttpServletResponse response, Model m, HttpSession session){

        try {

            response.setContentType("text/html; charset=UTF-8");

            //배송지 정보에 아이디 담기
            String userId = (String)session.getAttribute("userId");
            vo.setUserId(userId);

            //api로 입력받은 도로명 주소 -> 새로운 주소로 형태 변환 (조합하기) -> DB에 넣기위해
            String newDelyAddr = (zipNo+"@"+roadAddrPart1+"@"+addrDetail);

            //수정하는 값들 vo에 저장 -> DB에 넣을 것
            vo.setReceiver(newReceiver);
            vo.setDelyPhone(newDelyPhone);
            vo.setDelyAddr(newDelyAddr);

            //배송지 정보 변경하기
            int rowCnt = delyService.updateDelivery3(vo);
            if(rowCnt!=1) {
                throw new Exception("update delivery error");
            }

            //주문페이지에 띄워주기 위한 변경된 주소, 모델에 담아 보내줄 것
            String newAdder = (roadAddrPart1+" "+addrDetail);

            m.addAttribute("vo", vo);
            m.addAttribute("zipNo", zipNo);
            m.addAttribute("roadAddrPart1", roadAddrPart1);
            m.addAttribute("addrDetail", addrDetail);
            m.addAttribute("newAdder",newAdder);
            m.addAttribute("dely",dely);

        } catch (Exception e) {
            e.printStackTrace();
            //변경 실패했을 때 기존 주소를 주문페이지에서 띄워주기 위해.
            m.addAttribute("vo", vo);
        }

        return "delyView";

    }

    //결제처리하는 메서드
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
            String delyAddrToDb = vo.getDelyAddr();

            //주소 형태 변환(구분자 없애기)
            String delyAddrTemp = vo.getDelyAddr();
            String[] addrs = delyAddrTemp.split("@");
            String delyAddr = addrs[1] + " " + addrs[2];
            vo.setDelyAddr(delyAddr);

            //구매자 정보 주문내용에 담기(order_list에 넣을 것)
            //구매상품에 대한 정보는 이미 매개변수로 전달 받았음
            odvo.setUserId(userId);
            odvo.setUserPhone(vo.getDelyPhone());
            odvo.setDelyAddr(delyAddrToDb);
            odvo.setReceiver(vo.getReceiver());

            //카트주문과 단건주문 구분하여 처리
            List<OrderDetailVO> odvoList = new ArrayList<>();
            if (orderType.equals("cartOrder")) {
                odvoList = cartService.buyCartList(userId);
            } else {
                odvoList.add(odvo);
            }

            //log.info("userOrderService.getClass()={}",userOrderService.getClass());
            //구매정보 order_list, order_detail에 넣기
            userOrderService.save(odvoList, odvo);

            //주문완료되면 카트에 있던 상품들 삭제
            cartService.deleteAll(userId);

            //총 구매금액, 배송지 정보, 구매한 제품 정보 -> session에 저장
            session.setAttribute("totalPrice", totalPrice);
            session.setAttribute("vo", vo);
            session.setAttribute("odvoList", odvoList);

            return "redirect:/buy/confirm";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "PAYCONFIRM_ERR");
            //결제~결제 확인 과정에서 에러가 발생했을 때 회원 주문목록으로 이동
            return "redirect:/mypage/order";
        }

    }

    //결제 후 결제처리 페이지로 이동하는 메서드
    @GetMapping("/confirm")
    public String confirm(HttpSession session, Model m){

        Integer totalPrice = (Integer)session.getAttribute("totalPrice");
        DeliveryVO vo = (DeliveryVO) session.getAttribute("vo");
        List<OrderDetailVO> odvoList = (List<OrderDetailVO>) session.getAttribute("odvoList");


        m.addAttribute("msg","PAY_OK");
        m.addAttribute("totalPrice", totalPrice);
        m.addAttribute("vo", vo);
        m.addAttribute("odvoList", odvoList);

        return "paymentConfirm";
    }

    //임시주문번호 만들어내는 메서드
    private static String getUniqueNo() {

        String uniqueNo = "";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        Calendar dateTime = Calendar.getInstance();
        uniqueNo = sdf.format(dateTime.getTime())+"_"+ RandomStringUtils.randomAlphanumeric(6);
        return uniqueNo;

    }

    //배송지 리스트 얻어온 후 주소형태 변환하는 메서드
    private List<DeliveryVO> getDelyList(String userId) {
        
        //배송지 리스트 얻어오기
        List<DeliveryVO> delyList = delyService.delySelect(userId);

        //주소 형태변환 (구분자 없애기)
        for(int i=0 ; i<delyList.size(); i++){
            String[] addrArr = delyList.get(i).getDelyAddr().split("@");
            delyList.get(i).setDelyAddr(addrArr[1]+" "+addrArr[2]);
        }
        return delyList;
    }

}

package com.green.meal.controller;


import com.green.meal.domain.CartVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.service.CartService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.C;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Stream;
@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/cart")
public class CartController {

    private final CartService cartService;

    private List<CartVO> list = new ArrayList<>();



    @GetMapping() // /cart GET
    public String cartList(Model model,HttpServletRequest request){

        HttpSession session = request.getSession();
        //비회원 장바구니 리스트
        if(!loginCheck(session)){
            //세션에 장바구니 없을 시 돌아가기
            if(session.getAttribute("list")==null){
//                model.addAttribute("msg","CART_ERR");
                return "cart";
            }
            //세션에서 장바구니 가져오기
            list = (List<CartVO>)session.getAttribute("list");

            //회원 장바구니 담기
        } else {
            String userId =(String) session.getAttribute("userId");
            list = cartService.getList(userId);
        }

        //리스트 보여주기
        model.addAttribute("list",list);
        return "cart";
    }


    @PatchMapping("/{itemNo}")
    @ResponseBody
    public ResponseEntity<String> modify(@PathVariable Integer itemNo, @RequestBody CartVO cartVO,  HttpSession session){


       if( cartVO.getCartAmount() <= 0 ){

           return new ResponseEntity<>("MOD_ERR",HttpStatus.BAD_REQUEST);
       }
        //비회원 장바구니 수정
        if(!loginCheck(session)){

            List<CartVO> oldList = (List<CartVO>)session.getAttribute("list");

            for (CartVO vo : oldList) {

                if(vo.getItemNo().equals(itemNo)){
                    vo.setCartAmount(cartVO.getCartAmount());
                }
                list.add(vo);
            }
            session.setAttribute("list",list);
            return  new ResponseEntity<>("SAVE_OK",HttpStatus.OK);

        } else {

            try {

                //회원 장바구니 수정
                String userId =(String) session.getAttribute("userId");
                cartVO.setUserId(userId);
                int rowCnt = cartService.update(cartVO);
                log.info("rowCnt={}",rowCnt);
                if(rowCnt !=1){
                    throw new Exception("Save failed");
                }
            }catch (Exception e){
                e.printStackTrace();
                return new ResponseEntity<>("MOD_ERR",HttpStatus.BAD_REQUEST);
            }
        }

        return new ResponseEntity<>("MOD_OK",HttpStatus.OK);
    }




    @ResponseBody
    @PostMapping()
    public  ResponseEntity<String> save(Integer itemNo, Integer itemAmount, HttpSession session){
        System.out.println("itemAmount = " + itemAmount);
        CartVO cartVO = new CartVO();
        cartVO.setItemNo(itemNo);
        cartVO.setCartAmount(itemAmount);

        //비회원 장바구니 저장
        if(!loginCheck(session)){
            //비회원 장바구니가 없을때
            if(session.getAttribute("list")==null){
                list.add(cartVO);
                session.setAttribute("list",list);
                return new ResponseEntity<>("SAVE_OK",HttpStatus.OK);
            }

            //장바구니가 있으면 리스트에서 같은 상품이 있는지 검사 후 다시 저장
            List<CartVO> oldList = (List<CartVO>) session.getAttribute("list");


            for (CartVO vo : oldList) {
                // 같은 상품이 있을시 수량 더하기
                if(vo.getItemNo().equals(itemNo)){
                    cartVO.setCartAmount(vo.getCartAmount()+cartVO.getCartAmount());
                } else {
                    list.add(vo);
                }
            }list.add(cartVO);

            session.setAttribute("list",list);


            return new ResponseEntity<>("SAVE_OK",HttpStatus.OK);
        }
        //회원 장바구니 저장
        String userId =(String) session.getAttribute("userId");
        cartVO.setUserId(userId);

        Map map = new HashMap();
        map.put("userId",userId);
        map.put("itemNo",itemNo);


        CartVO byItem = cartService.findByItem(map);
        int rowCnt = 0;
        //같은 상품 있는지 확인
        if(byItem == null) {
            //같은 상품 없으면 저장
             rowCnt = cartService.save(cartVO);
        }else {
            //같은 상품이 있을경우 수량 합쳐서 수정
            cartVO.setCartAmount(itemAmount+ byItem.getCartAmount());
            rowCnt = cartService.update(cartVO);
        }
        try {
            if(rowCnt!=1){
                throw new Exception("Save failed");
            }
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("SAVE_ERR",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("SAVE_OK",HttpStatus.OK);

    }

    @ResponseBody
    @DeleteMapping("/{itemNo}")
    public ResponseEntity<String>remove(@PathVariable Integer itemNo, HttpSession session){
        CartVO cartVO = new CartVO();
        cartVO.setItemNo(itemNo);
        //비회원 장바구니 삭제
        if(!loginCheck(session)){

            List<CartVO> oldList = (List<CartVO>)session.getAttribute("list");
            oldList.remove(cartVO);
            session.setAttribute("list",oldList);
            if(oldList.contains(cartVO)){
                return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>("DEL_OK",HttpStatus.OK);

        }else {
            String userId =(String) session.getAttribute("userId");
            //회원 장바구니 삭제
            Map map = new HashMap();
            map.put("userId",userId);
            map.put("itemNo",itemNo);
            try {
                int rowCnt = cartService.delete(map);

                if(rowCnt !=1)
                throw new Exception("Delete Failed");

                return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
            }
        }

    }
    @ResponseBody
    @DeleteMapping("/cart")
    public ResponseEntity<String>removeAll(HttpSession session){

        //비회원 장바구니 삭제
        if(!loginCheck(session)){

            session.removeAttribute("list");
          
            if(session.getAttribute("list")!=null){
                return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
            }

            return new ResponseEntity<>("DEL_OK",HttpStatus.OK);

        }else {
            String userId =(String) session.getAttribute("userId");
            //회원 장바구니 삭제
  
            try {
                int rowCnt = cartService.deleteAll(userId);

                if(rowCnt == 0)
                    throw new Exception("Delete Failed");

                return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
            } catch (Exception e) {
                e.printStackTrace();
                return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
            }
        }

    }



    private boolean loginCheck(HttpSession session){

        return session.getAttribute("userId")!=null;
    }

    private boolean findByItem(Integer itemNo,String userId){
        Map map = new HashMap();
        map.put("userId",userId);
        map.put("itemNO",itemNo);

        return cartService.findByItem(map) != null;
    }


    }






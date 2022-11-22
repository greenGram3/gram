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


    @GetMapping() // /cart GET
    public String cartList(Model model,HttpServletRequest request){

        HttpSession session = request.getSession();
        List<CartVO> oldList = (List<CartVO>)session.getAttribute("list");
        //비회원 장바구니 리스트
        if(!loginCheck(session)){
            return "cart";
        }

        String userId =(String) session.getAttribute("userId");
        //로그인 전의 장바구니가 있을 때
        if(oldList!=null) {
            Map map = new HashMap();
            map.put("userId",userId);

            for (CartVO vo : oldList) {
                map.put("itemNo",vo.getItemNo());
                CartVO getCart = cartService.findByItem(map);
                if(getCart==null) {
                    vo.setUserId(userId);
                    cartService.save(vo);
                }
            }
           session.removeAttribute("list");
        }
        List<CartVO> list = cartService.getList(userId);
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
            }
            session.setAttribute("list",oldList);
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



    @PostMapping()
    @ResponseBody
    public  ResponseEntity<String> save(@RequestBody CartVO cartVO, HttpSession session){

        //비회원 장바구니 저장------------------------------------------------------------------
        if(!loginCheck(session)){
            //세션에서 장바구니 꺼내기
            List<CartVO> oldList = (List<CartVO>) session.getAttribute("list");

            //비회원 장바구니가 없을때
            if(oldList==null){
                List<CartVO> list = new ArrayList<>();
                list.add(cartVO);
                session.setAttribute("list",list);
                return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
            }

            //비회원 장바구니가 있을때
            //세션의 장바구니에서 같은 상품있는지 확인
            boolean containCart= false;
            for (CartVO vo : oldList) {
                // 같은 상품이 있을시 수량 더하기
                if(vo.getItemNo()==cartVO.getItemNo()){
                    vo.setCartAmount(vo.getCartAmount()+cartVO.getCartAmount());
                    containCart = true;
                }
            }
            //같은 상품이 없을시 장바구니에 추가
                if(!containCart)
                    oldList.add(cartVO);

            session.setAttribute("list",oldList);
            return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
            }


        //회원 장바구니 저장------------------------------------------------------------------
        String userId =(String) session.getAttribute("userId");
        cartVO.setUserId(userId);

        Map map = new HashMap();
        map.put("userId",userId);
        map.put("itemNo",cartVO.getItemNo());

        CartVO byItem = cartService.findByItem(map);
        int rowCnt = 0;
        //같은 상품 있는지 확인
        if(byItem == null) {
            //같은 상품 없으면 저장
             rowCnt = cartService.save(cartVO);
        }else {
            //같은 상품이 있을경우 수량 합쳐서 수정
            cartVO.setCartAmount(cartVO.getCartAmount()+ byItem.getCartAmount());
            rowCnt = cartService.update(cartVO);
        }
        try {
            if(rowCnt!=1){
                throw new Exception("Save failed");
            }
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("DEL_OK",HttpStatus.OK);

    }

    @ResponseBody
    @DeleteMapping("/{itemNo}")
    public ResponseEntity<String>remove(@PathVariable Integer itemNo, HttpSession session){
        CartVO cartVO = new CartVO();
        cartVO.setItemNo(itemNo);
        List<CartVO> oldList = (List<CartVO>) session.getAttribute("list");

        //비회원 장바구니 삭제
        if(!loginCheck(session)){

            for(int i =0; i<oldList.size();i++){
               if(oldList.get(i).getItemNo()==itemNo){
                   oldList.remove(i);
               }
            }
            session.setAttribute("list",oldList);

            return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
        }

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
                System.out.println("e = " + e);
                return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
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

        }


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






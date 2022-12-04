package com.green.meal.controller;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.green.meal.domain.CartVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.service.CartService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.checkerframework.checker.units.qual.C;
import org.springframework.http.HttpEntity;
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


    @GetMapping() // 장바구니목록 보여주기
    public String cartList(Model model, HttpSession session){

        String userId = getUserId(session);
        //비회원 일때
        if(userId==null){
            return "cart";
        }

        try {
            //회원일때
            //세션에서 장바구니 꺼내기 ( 로그인 전 장바구니 )
            List<CartVO> guestCart = getList(session);
            //로그인 전 장바구니와 아이디를 넘겨서 회원 장바구니 받기
            List<CartVO> list = cartService.getList(userId, guestCart);

            session.removeAttribute("list");
            model.addAttribute("list",list);

        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg", "LIST_ERR");
        }
        return "cart";
    }


    //장바구니 수정
    @PatchMapping("/{itemNo}")
    @ResponseBody
    public ResponseEntity<String> modify(@PathVariable Integer itemNo, @RequestBody CartVO cartVO,  HttpSession session){

        //장바구니 수량이 0 이하로 수정할때 걸려주기
       if( cartVO.getCartAmount() <= 0 )
           return new ResponseEntity<>("MOD_ERR",HttpStatus.BAD_REQUEST);

        String userId = getUserId(session);
        try{
            //비회원 장바구니 수정
            if(userId==null){
                //세션에서 비회원장바구니 꺼내기
                List<CartVO> oldList = getList(session);
                //비회원장바구니 수량 변경
                List<CartVO> list = cartService.guestUpdate(cartVO, oldList);
                if(list == null)
                    throw new Exception("Modify failed");
                // 세션에 저장
                session.setAttribute("list",list);
            } else {
                //회원 장바구니 수정
                cartVO.setUserId(userId);
                if(cartService.userUpdate(cartVO) !=1)
                    throw new Exception("Modify failed");
            }
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("MOD_ERR",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("MOD_OK",HttpStatus.OK);
    }

    @PostMapping()
    @ResponseBody
    public  ResponseEntity<String> save(@RequestBody CartVO cartVO, HttpSession session){
        String userId = getUserId(session);
        List<CartVO> afterCart= new ArrayList<>();
        try {
            //비회원 장바구니 저장---------------------------------------------------------
            if(userId==null){
                //세션에서 장바구니 꺼내기
                List<CartVO> beforeCart = getList(session);
                //비회원 장바구니가 없을때
                if(beforeCart==null){
                    afterCart.add(cartVO);
                }else{
                    //비회원 장바구니가 있을때
                    afterCart = cartService.guestSave(cartVO,beforeCart);
                }
                session.setAttribute("list",afterCart);
            } else {
                //회원 장바구니 저장-------------------------------------------------------
                cartVO.setUserId(userId);
                if(cartService.userSave(cartVO) != 1)
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

        List<CartVO> oldList = getList(session);
        String userId = getUserId(session);

        try {
            //비회원 장바구니 삭제
            if(userId==null){
                List<CartVO> list= cartService.guestDelete(itemNo,oldList);
                session.setAttribute("list",list);
            }
            //회원 장바구니 삭제
            if(cartService.userDelete(userId,itemNo) !=1)
                throw new Exception("Delete Failed");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
    }

    //장바구니 모두 삭제
    @ResponseBody
    @DeleteMapping("/cart")
    public ResponseEntity<String>removeAll(HttpSession session){
        String userId = getUserId(session);
        try {
            //비회원 장바구니 모두삭제
            if(userId==null){
                session.removeAttribute("list");
            }
            //회원 장바구니 삭제
            if(cartService.userDeleteAll(userId) == 0)
                throw new Exception("Delete Failed");
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("DEL_ERR",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("DEL_OK",HttpStatus.OK);
    }

    //회원아이디 꺼내오기
    private static String getUserId(HttpSession session) {
        return (String) session.getAttribute("userId");
    }

    //세션에서 장바구니 가져오기 ( 비회원 )
    private static List<CartVO> getList(HttpSession session) {
        return (List<CartVO>) session.getAttribute("list");
    }

}






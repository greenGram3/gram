package com.green.meal.service;


import com.green.meal.domain.CartVO;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.mapper.CartMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Slf4j
@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;

    @Override
    public List<CartVO> getList(String userId, List<CartVO> guestCart){
        //로그인 전의 장바구니가 있을 때
        if(guestCart!=null) {
            Map<String,Object> map = new HashMap<>();
            map.put("userId",userId);

            //장바구니 리스트를 검색하여
            for (CartVO vo : guestCart) {
                map.put("itemNo",vo.getItemNo());
                // 디비에 같은 아이템이 있는지 확인
                CartVO getCart = cartMapper.findByItem(vo);
                // 디비에 같은 아이템이 없으면 저장
                if(getCart==null) {
                    vo.setUserId(userId);
                    cartMapper.insert(vo);
                }
            }
        }
        return cartMapper.getList(userId);
    }

    @Override
    public List<CartVO> guestSave(CartVO cartVO, List<CartVO> beforeCart) {
        boolean containCart= true;
        for (CartVO vo : beforeCart) {
            // 장바구니에 같은 상품이 있을시 수량 더하기
            if(vo.getItemNo().equals(cartVO.getItemNo())){
                vo.setCartAmount(vo.getCartAmount()+cartVO.getCartAmount());
                containCart = false;
            }
        }
        //같은 상품이 없을때 장바구니에 추가
        if(containCart)
            beforeCart.add(cartVO);
        return beforeCart;
    }
    @Override
    public int userSave(CartVO cartVO){
        //회원 장바구니에 상품이 있는지 확인
        CartVO byItem = cartMapper.findByItem(cartVO);
        if(byItem == null) {
            //같은 상품 없으면 저장
            return cartMapper.insert(cartVO);
        }else {
            //같은 상품이 있을경우 수량 합쳐서 수정
            cartVO.setCartAmount(cartVO.getCartAmount()+ byItem.getCartAmount());
            return cartMapper.update(cartVO);
        }
    }


    @Override
    public int userUpdate(CartVO cartVO){
        return cartMapper.update(cartVO);
    }


    @Override
    public List<CartVO> guestUpdate(CartVO cartVO, List<CartVO> beforeCart){
        //비회원 장바구니 목록중에 같은 상품을 찾아서 수량 변경
        for (CartVO vo : beforeCart) {
            if(vo.getItemNo().equals(cartVO.getItemNo())){
                vo.setCartAmount(cartVO.getCartAmount());
            }
        }

        return beforeCart;
    }

    @Override
    public List<CartVO> guestDelete(Integer itemNo, List<CartVO> list) {

        //비회원장바구니에서 같은 상품을 찾아 삭제
        for(int i = 0; i<list.size(); i++){
            if(list.get(i).getItemNo().equals(itemNo)){
                list.remove(i);
            }
        }
        return list;
    }

    @Override
    public int userDelete(String userId, Integer itemNo){

        Map<String,Object> map = new HashMap<>();
        map.put("userId",userId);
        map.put("itemNo",itemNo);
        return cartMapper.delete(map);
    }

    @Override
    public int userDeleteAll(String userId) {
        return cartMapper.deleteAll(userId);
    }


    @Override
    public List<OrderDetailVO> buyCartList(String userId) {
        return cartMapper.selectCartItems(userId);
    }


}

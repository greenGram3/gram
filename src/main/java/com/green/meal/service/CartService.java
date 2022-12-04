package com.green.meal.service;

import com.green.meal.domain.CartVO;
import com.green.meal.domain.OrderDetailVO;

import java.util.List;
import java.util.Map;

public interface CartService {
    int userSave(CartVO cartVO);

    List<CartVO> getList(String userId, List<CartVO> guestCart);

    int userUpdate(CartVO cartVO);

    int userDelete(String userId, Integer itemNo);


    int userDeleteAll(String userId);

    List<OrderDetailVO> buyCartList(String userId);

    List<CartVO> guestUpdate(CartVO cartVO, List<CartVO> list);
    List<CartVO> guestSave(CartVO cartVO, List<CartVO> list);

    List<CartVO> guestDelete(Integer itemNo, List<CartVO> list);

}

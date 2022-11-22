package com.green.meal.service;

import com.green.meal.domain.CartVO;
import com.green.meal.domain.OrderDetailVO;

import java.util.List;
import java.util.Map;

public interface CartService {
    int save(CartVO cartVO);

    List<CartVO> getList(String userId);

    int update(CartVO cartVO);

    int delete(Map map);

    CartVO findByItem(Map map);

    int deleteAll(String userId);

    List<OrderDetailVO> buyCartList(String userId);

}

package com.green.meal.service;


import com.green.meal.domain.CartVO;
import com.green.meal.mapper.CartMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;

    @Override
    public int save(CartVO cartVO){

        return cartMapper.insert(cartVO);
    }

    @Override
    public List<CartVO> getList(String userId){

        return cartMapper.getList(userId);
    }

    @Override
    public int update(CartVO cartVO){


        return cartMapper.update(cartVO);
    }

    @Override
    public int delete(Map map){

       return cartMapper.delete(map);
    }

    @Override
    public CartVO findByItem(Map map) {
        return cartMapper.findByItem(map);
    }

    @Override
    public int deleteAll(String userId) {
        return cartMapper.deleteAll(userId);
    }

}

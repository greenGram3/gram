package com.green.meal.mapper;

import com.green.meal.domain.CartVO;
import com.green.meal.domain.OrderDetailVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CartMapper {

    List<CartVO> getList(String userId);

    int insert(CartVO cartVO);

    int delete(Map map);

    int update(CartVO cartVO);

    CartVO findByItem(CartVO cartVO);

    int deleteAll(String userId);

    List<OrderDetailVO> selectCartItems(String userId);

}

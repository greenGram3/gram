package com.green.meal.mapper;

import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderListDto;
import com.green.meal.domain.OrderSearch;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UserOrderMapper {

    List<OrderDetailDto> orderDetail(Integer orderNo);
    List<OrderListDto> orderList(String userId);
    List<OrderListDto> cancelList(String userId);

    List<OrderListDto> searchOrder(OrderSearch orderSearch);

    int insertUser(OrderListDto orderListVO);

    int insertItem(OrderDetailDto orderDetailVO);

    OrderListDto order(Map map);

    int orderConfirm(OrderListDto orderListVO);




}

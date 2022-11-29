package com.green.meal.service;

import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.OrderListDto;
import com.green.meal.domain.OrderSearch;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

public interface UserOrderService {
    @Transactional(rollbackFor = Exception.class)
    int save(List<OrderDetailVO> list, OrderDetailVO odvo) throws Exception;

    List<OrderDetailDto> orderItemInfo(Integer orderNo);

    List<OrderListDto> orderUserInfo(String userId);

    List<OrderListDto> searchOrder(OrderSearch orderSearch);

    OrderListDto order(Map map);

    int orderConfirm(OrderListDto orderListVO);

    List<OrderListDto> cancelList(String userId);
}

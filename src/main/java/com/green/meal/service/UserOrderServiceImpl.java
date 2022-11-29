package com.green.meal.service;

import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.OrderListDto;
import com.green.meal.domain.OrderSearch;
import com.green.meal.mapper.UserOrderMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserOrderServiceImpl implements UserOrderService {

    private final UserOrderMapper userOrderMapper;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public int save(List<OrderDetailVO> list, OrderDetailVO odvo) throws Exception{
        int rowCntV2 = 0;
        int rowCntV1 = userOrderMapper.insertUser(odvo);

        for (OrderDetailVO vo : list) {
            vo.setOrderNo(odvo.getOrderNo());
             rowCntV2 = userOrderMapper.insertItem(vo);
        }


        if((rowCntV1+rowCntV2) <= 1) {
            throw new Exception("주문저장실패");
        }

        return rowCntV1+rowCntV2;
    }

    @Override
    public  List<OrderDetailDto>orderItemInfo(Integer orderNo) {
       return userOrderMapper.orderDetail(orderNo);
    }

    @Override
    public List<OrderListDto> orderUserInfo(String userId) {
     return userOrderMapper.orderList(userId);
    }



    @Override
    public List<OrderListDto> searchOrder(OrderSearch orderSearch) {
        log.info("orderSearch={}",orderSearch);
        return userOrderMapper.searchOrder(orderSearch);
    }

    @Override
    public OrderListDto order(Map map) {
        return userOrderMapper.order(map);
    }

    @Override
    public int orderConfirm(OrderListDto orderListVO) {
        return userOrderMapper.orderConfirm(orderListVO);
    }

    @Override
    public List<OrderListDto> cancelList(String userId) {
        return userOrderMapper.cancelList(userId);
    }


}

package com.green.meal.mapper;

import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.OrderItemDTO;
import com.green.meal.domain.SearchCondition;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Mapper
public interface OrderMapper {

    int sendAmountUpdate(HashMap map);
    int returnAmountUpdate(HashMap map);

    int sendStateUpdate(Integer orderNo);
    int returnStateUpdate(Integer orderNo);



    List<OrderDetailVO> selectDetail(Integer orderNo);

    int searchResultCnt(SearchCondition sc);


    List<OrderDetailVO> searchSelectPage(SearchCondition sc);

    int buyInfoToList(OrderDetailVO vo);

    int buyInfoToDetail(OrderDetailVO vo);

}

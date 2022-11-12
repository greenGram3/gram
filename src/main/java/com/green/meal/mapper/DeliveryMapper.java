package com.green.meal.mapper;

import com.green.meal.domain.DeliveryVO;

import java.util.List;
import java.util.Map;


public interface DeliveryMapper {
    List<DeliveryVO> selectDelivery(String userId);

    int delyProc(DeliveryVO dely);

    int updateDelivery(Map map);

    int deleteDelivery(DeliveryVO dely);

//    int insertDelivery(DeliveryVO dely);
//
//    int setZero(String userId);
}

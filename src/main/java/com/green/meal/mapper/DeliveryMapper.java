package com.green.meal.mapper;

import com.green.meal.domain.DeliveryVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface DeliveryMapper {
    List<DeliveryVO> selectDelivery(String userId);

    int delyProc(DeliveryVO dely);

    int updateDelivery(Map map);

    int updateDelivery2(String userId);

    int updateDelivery3(Map map);

    int deleteDelivery(DeliveryVO dely);

    int selectBase(String userId);

    List<DeliveryVO> delyList(String userId);

    DeliveryVO selectedDely(HashMap map);

}

package com.green.meal.service;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.domain.UserVO;
import org.apache.ibatis.annotations.Mapper;


import java.util.HashMap;
import java.util.List;
import java.util.Map;


public interface DelyService {

    List<DeliveryVO> selectDelivery(String userId);

    int delyProc(DeliveryVO dely);

    int updateDelivery(DeliveryVO dely0, DeliveryVO dely1);

    public int deleteDelivery(DeliveryVO dely);

    int updateDelivery2(String userId);

    int updateDelivery3(DeliveryVO vo, DeliveryVO newDelyVo);

    int selectBase(String userId);

    List<DeliveryVO> delySelect(String userId);

    DeliveryVO selectedDely(HashMap map);

    int baseDely(UserVO user);
}

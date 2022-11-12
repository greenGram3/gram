package com.green.meal.service;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.mapper.DeliveryMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequiredArgsConstructor
@Service
public class DelyService {

    private final DeliveryMapper mapper;

    public List<DeliveryVO> selectDelivery(String userId){
        return mapper.selectDelivery(userId);
    }

    public int delyProc(DeliveryVO dely){
        return mapper.delyProc(dely);
    }

    public int updateDelivery(DeliveryVO dely0, DeliveryVO dely1){
        Map map = new HashMap();
        map.put("dely0", dely0);
        map.put("dely1", dely1);
        return mapper.updateDelivery(map);
    }

    public int deleteDelivery(DeliveryVO dely){
        return mapper.deleteDelivery(dely);
    }

}

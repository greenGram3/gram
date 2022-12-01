package com.green.meal.service;

import com.green.meal.domain.EventVO;
import com.green.meal.mapper.EventMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@RequiredArgsConstructor
@Service
public class EventService {

    private final EventMapper mapper;

    public List<EventVO> selectEvent(){
        return mapper.selectEvent();
    }

    public int insertEvent(EventVO eventVO){
        return mapper.insertEvent(eventVO);
    }

    public int updateEvent(EventVO eventVO ,Integer eventNo){
        HashMap map = new HashMap();
        map.put("eventVO", eventVO);
        map.put("eventNo", eventNo);

        return mapper.updateEvent(map);
    }

    public EventVO selectOne(Integer eventNo){
        return mapper.selectOne(eventNo);
    }

    public int deleteEvent(Integer eventNo){
        return mapper.deleteEvent(eventNo);
    }
}

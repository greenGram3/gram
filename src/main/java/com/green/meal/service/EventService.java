package com.green.meal.service;

import com.green.meal.domain.EventVO;
import com.green.meal.mapper.EventMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class EventService {

    private final EventMapper mapper;

    public List<EventVO> selectEvent(){
        return mapper.selectEvent();
    }

    public int insertEvent(EventVO event){
        return mapper.insertEvent(event);
    }

    public int updateEvent(Integer eventNo){
        return mapper.updateEvent(eventNo);
    }

    public int deleteEvent(Integer eventNo){
        return mapper.deleteEvent(eventNo);
    }
}

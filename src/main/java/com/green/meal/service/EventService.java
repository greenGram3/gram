package com.green.meal.service;

import com.green.meal.domain.EventVO;

import java.util.List;

public interface EventService {
    List<EventVO> selectEvent();

    List<EventVO> selectBanner();

    int insertEvent(EventVO eventVO, String realPath) throws Exception;

    int updateEvent(EventVO eventVO, String realPath) throws Exception;

    EventVO selectOne(Integer eventNo);

    int deleteEvent(Integer eventNo);
}

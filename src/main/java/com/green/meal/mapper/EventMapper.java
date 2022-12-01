package com.green.meal.mapper;

import com.green.meal.domain.EventVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EventMapper {
    List<EventVO> selectEvent();

    int insertEvent(EventVO event);

    int updateEvent(Integer eventNo);

    int deleteEvent(Integer eventNo);
}

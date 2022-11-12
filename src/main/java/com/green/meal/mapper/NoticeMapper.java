package com.green.meal.mapper;

import com.green.meal.domain.NoticeVO;
import com.green.meal.paging.SearchCriteria;

import java.util.List;

public interface NoticeMapper {

    List<NoticeVO> noticelist(SearchCriteria cri);
    int searchCount(SearchCriteria cri);

    NoticeVO noticedetail(NoticeVO vo);

    int noticeinsert(NoticeVO vo);

    int noticeupdate(NoticeVO vo);

    int noticedelete(NoticeVO vo);

}

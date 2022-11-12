package com.green.meal.service;

import com.green.meal.domain.NoticeVO;
import com.green.meal.paging.SearchCriteria;

import java.util.List;

public interface NoticeService {

    // 공지리스트 출력
    List<NoticeVO> noticelist(SearchCriteria cri);
    int searchCount(SearchCriteria cri);

    // 공지디테일 출력
    NoticeVO noticedetail(NoticeVO vo);

    // 공지 인서트
    int noticeinsert(NoticeVO vo);

    // 공지 업데이트
    int noticeupdate(NoticeVO vo);

    // 공지 삭제
    int noticedelete(NoticeVO vo);





}

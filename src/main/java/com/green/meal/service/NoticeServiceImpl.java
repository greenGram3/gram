package com.green.meal.service;

import com.green.meal.domain.NoticeVO;
import com.green.meal.mapper.NoticeMapper;
import com.green.meal.paging.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeMapper noticeMapper;

    @Override
    public List<NoticeVO> noticelist(SearchCriteria cri) {
        return noticeMapper.noticelist(cri);
    }

    @Override
    public int searchCount(SearchCriteria cri) {
        return noticeMapper.searchCount(cri);
    }

    @Override
    public NoticeVO noticedetail(NoticeVO vo){
        return noticeMapper.noticedetail(vo);

    }

    @Override
    public int noticeinsert(NoticeVO vo) {
       return noticeMapper.noticeinsert(vo);
    }

    @Override
    public int noticeupdate(NoticeVO vo) {
        return noticeMapper.noticeupdate(vo);
    }

    @Override
    public int noticedelete(NoticeVO vo) {
        return noticeMapper.noticedelete(vo);
    }
}

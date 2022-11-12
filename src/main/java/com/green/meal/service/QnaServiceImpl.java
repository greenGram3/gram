package com.green.meal.service;

import com.green.meal.domain.QnaVO;
import com.green.meal.mapper.QnaMapper;
import com.green.meal.paging.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Service
public class QnaServiceImpl implements QnaService {
    @Autowired
    QnaMapper qnaMapper;

    // 관리자용 list 불러오기
    @Override
    public List<QnaVO> qnalistAll(SearchCriteria cri) {
        return qnaMapper.qnalistAll(cri);
    }
    public int searchCount(SearchCriteria cri) {return qnaMapper.searchCount(cri);}

    // user용 list 불러오기
//    @Override
//    public List<QnaVO> qnalistOne(SearchCriteria cri, QnaVO vo) { return qnaMapper.qnalistOne(cri, vo); }

    // QnA 작성
    @Override
    public int qnainsert(QnaVO vo) { return qnaMapper.qnainsert(vo); }

    // qna Detail 출력
    @Override
    public QnaVO qnadetail(QnaVO vo) { return qnaMapper.qnadetail(vo); }

    // qna 수정
    @Override
    public int qnaupdate(QnaVO vo) { return qnaMapper.qnaupdate(vo); }

    // qna 삭제
    @Override
    public int qnadelete(QnaVO vo) { return qnaMapper.qnadelete(vo); }

    // qna 답변작성
    @Override
    public int qnarinsert(QnaVO vo) { return qnaMapper.qnarinsert(vo); }

    // qna답변출력
    @Override
    public QnaVO qnarDetail(QnaVO vo) {
        return qnaMapper.qnarDetail(vo);
    }
} //class

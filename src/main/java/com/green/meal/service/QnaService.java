package com.green.meal.service;

import com.green.meal.domain.QnaVO;
import com.green.meal.paging.SearchCriteria;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface QnaService {

    // 답변 중복 체크
    QnaVO qnaDupCheck(int qnaRoot);

    // 관리자용 QNA list 출력
    List<QnaVO> qnalistAll(SearchCriteria cri);
    int searchCount(SearchCriteria cri);

    // user용 QNA list 출력
//    List<QnaVO> qnalistOne(SearchCriteria cri, QnaVO vo);

    // qna 작성
    int qnainsert(QnaVO vo);

    // qna Detail 출력
    QnaVO qnadetail(QnaVO vo);

    // qna 수정
    int qnaupdate(QnaVO vo);

    // qna 삭제
    int qnadelete(QnaVO vo);

    // qna답변 작성
    int qnarinsert(QnaVO vo);

    // qna답변 출력
    QnaVO qnarDetail(QnaVO vo);

}

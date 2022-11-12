package com.green.meal.mapper;

import com.green.meal.domain.QnaVO;
import com.green.meal.paging.SearchCriteria;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface QnaMapper {

    // 관리자용 QNA list 출력
    List<QnaVO> qnalistAll(SearchCriteria cri);
    int searchCount(SearchCriteria cri);

    // user용 QNA list 출력
//    List<QnaVO> qnalistOne(SearchCriteria cri, QnaVO vo);

    // qna작성
    int qnainsert(QnaVO vo);

    // qna Detail 출력
    QnaVO qnadetail(QnaVO vo);

    // qna 수정
    int qnaupdate(QnaVO vo);

    // qna 삭제
    int qnadelete(QnaVO vo);

    // qna 답변 작성
    int qnarinsert(QnaVO vo);

    // qna답변 출력
    QnaVO qnarDetail(QnaVO vo);
}

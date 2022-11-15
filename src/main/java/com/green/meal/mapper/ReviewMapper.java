package com.green.meal.mapper;

import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.SearchCriteria;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReviewMapper {

    // 상세페이지 ReviewList 출력
    List<ReviewVO> reviewlistD(Map map);

    // Reviewlist 출력
    List<ReviewVO> reviewlist(SearchCriteria cri);
    int searchCount(SearchCriteria cri);

    // Reviewlist(MyPage) 출력
    List<ReviewVO> reviewlistM(Map map);

    // Review Detail 출력
    ReviewVO reviewdetail(ReviewVO vo);

    // Review insert
    int reviewinsert(ReviewVO vo);

    // Review 수정
    int reviewupdate(ReviewVO vo);

    // Review 답변작성
    int reviewrinsert(ReviewVO vo);

    // Review 답변 출력
    ReviewVO reviewrDetail(ReviewVO vo);

    // Review 삭제
    int reviewdelete(ReviewVO vo);

}

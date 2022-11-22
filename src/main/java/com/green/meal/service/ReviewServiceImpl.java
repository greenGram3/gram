package com.green.meal.service;

import com.green.meal.domain.ReviewVO;
import com.green.meal.mapper.ReviewMapper;
import com.green.meal.paging.SearchCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    ReviewMapper reviewMapper;

    // 상세페이지 ReviewList 출력
    @Override
    public List<ReviewVO> reviewlistD(SearchCriteria cri, ReviewVO vo) {
        Map map = new HashMap();
        map.put("itemNo",vo.getItemNo());
        map.put("sno",cri.getSno());
        map.put("rowsPerPage", cri.getRowsPerPage());

        return reviewMapper.reviewlistD(map);
    }

    // Reviewlist 출력
    @Override
    public List<ReviewVO> reviewlist(SearchCriteria cri) { return reviewMapper.reviewlist(cri); }
    public int searchCount(SearchCriteria cri) { return reviewMapper.searchCount(cri); }
    public int searchCount2(String userId) { return reviewMapper.searchCount2(userId); }
    public int searchCount3(ReviewVO vo) { return reviewMapper.searchCount3(vo); }

    // Reviewlist(MyPage) 출력
    @Override
    public List<ReviewVO> myReview(SearchCriteria cri, String userId) {
        Map map = new HashMap();
        map.put("userId", userId);
        map.put("sno", cri.getSno());
        map.put("rowsPerPage", cri.getRowsPerPage());
        return reviewMapper.myReview(map);
    }

    // Review Detail 출력
    @Override
    public ReviewVO reviewdetail(ReviewVO vo) { return reviewMapper.reviewdetail(vo); }

    // Review Insert+후기중복체크
    @Override
    public int reviewinsert(ReviewVO vo) { return reviewMapper.reviewinsert(vo); }
    @Override
    public ReviewVO dupCheck(ReviewVO vo) {return reviewMapper.dupCheck(vo);}

    // Review 수정
    @Override
    public int reviewupdate(ReviewVO vo) { return reviewMapper.reviewupdate(vo); }

    // Review 답변작성
    @Override
    public int reviewrinsert(ReviewVO vo) {
        return reviewMapper.reviewrinsert(vo);
    }

    // Review 답변 출력+답변DupCheck
    @Override
    public ReviewVO reviewrDetail(ReviewVO vo) { return reviewMapper.reviewrDetail(vo); }

    // Review 삭제
    @Override
    public int reviewdelete(ReviewVO vo) {
        return reviewMapper.reviewdelete(vo);
    }

    // Review 답변 업데이트
    @Override
    public int reviewRupdate(ReviewVO vo) {
        return reviewMapper.reviewRupdate(vo);
    }
}

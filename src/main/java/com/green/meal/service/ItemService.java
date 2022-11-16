package com.green.meal.service;

import com.green.meal.domain.ImageVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import org.springframework.stereotype.Service;

import java.util.List;

public interface ItemService {
    ItemVO itemAdmin(Integer itemNo) throws Exception;

    int itemUpload(ItemVO vo) throws Exception;

    int itemRemove(Integer itemNo) throws Exception;

    int itemModify(ItemVO vo) throws Exception;

    List<ItemVO> selectAll() throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<ItemVO> getSearchResultPage(SearchCondition sc) throws Exception;


    // heeJeong item 상세페이지------------------------------------------------------------- //
    ItemVO itemdetail(ItemVO vo) throws Exception;

    // image테이블 이미지 여러장 출력
    List<ImageVO> imageDetail(ImageVO vo1) throws Exception;

    // item등록 이미지 등록
    int itemImgUpload(ItemVO vo) throws Exception;

    // item 업데이트 이미지 업데이트
    int imageModify(ItemVO vo) throws Exception;

}

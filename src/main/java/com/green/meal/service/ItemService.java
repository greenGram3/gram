package com.green.meal.service;

import com.green.meal.domain.ImageVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

public interface ItemService {
    ItemVO itemAdmin(Integer itemNo) throws Exception;

    // Heejeong - 이미지 관리폼에서 등록된 이미지 두장 다 보이게
    ImageVO imageAdmin(Integer itemNo) throws Exception;

    int itemUpload(ItemVO vo) throws Exception;

    int itemRemove(Integer itemNo) throws Exception;

    int itemModify(ItemVO vo) throws Exception;

    List<ItemVO> selectAll() throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<ItemVO> getSearchResultPage(SearchCondition sc) throws Exception;

    List<ItemVO> searchItems(SearchCondition sc) throws Exception; // 홈 검색기능

    // heeJeong item 상세페이지------------------------------------------------------------- //
    ItemVO itemdetail(ItemVO vo) throws Exception;

    // image테이블 이미지 여러장 출력
    ImageVO imageDetail(ImageVO vo1) throws Exception;

    // item등록 이미지 등록
    int itemImgUpload(ImageVO vo1) throws Exception;

    // item 업데이트 이미지 업데이트
    int imageModify(ImageVO vo1) throws Exception;



    // seolhee home 페이지 --------------------------------------------------------------
    List<ItemVO> bestItems();
    List<ItemVO> newItems();


    int selectItemNo(String itemName);

    //카테고리 별 리스트 페이지 --------------------------------------------------------------
    List<ItemVO> category1(String category);
    List<ItemVO> category2(String category);

    List<ItemVO> highPrice(String category);
    List<ItemVO> lowPrice(String category);
    List<ItemVO> latest(String category);
    List<ItemVO> review(String category);
}

package com.green.meal.mapper;

import com.green.meal.domain.ImageVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ItemMapper {

    ItemVO selectOne(Integer itemNo);

    // Heejeong - 이미지 관리폼에서 등록된 이미지 두장 다 보이게
    ImageVO imageAdmin(Integer itemNo);

    int insert(ItemVO vo);

    int delete(Integer itemNo);

    int update(ItemVO vo);

    List<ItemVO> selectAll();

    int searchResultCnt(SearchCondition sc);

    List<ItemVO> searchSelectPage(SearchCondition sc);

    List<ItemVO> searchItems(SearchCondition sc); //홈 검색 기능
    // heeJeong item 상세페이지------------------------------------------------------------- //
    ItemVO itemdetail(ItemVO vo);

    // ** image테이블 이미지 여러장 출력
    ImageVO imageDetail(ImageVO vo1);

    // item등록 이미지 등록
    int itemImgUpload(ImageVO vo1);

    // item 업데이트 이미지 업데이트
    int imageModify(ImageVO vo1);

    // seolhee home 페이지 -------------------------------------------------------
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

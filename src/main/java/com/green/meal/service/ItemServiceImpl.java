package com.green.meal.service;

import com.green.meal.domain.ImageVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import com.green.meal.mapper.ItemMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class ItemServiceImpl implements ItemService {

    @Autowired
    ItemMapper mapper;

    @Override
    public ItemVO itemAdmin(Integer itemNo) {
        return mapper.selectOne(itemNo);
    }

    // Heejeong - 이미지 관리폼에서 등록된 이미지 두장 다 보이게

    @Override
    public ImageVO imageAdmin(Integer itemNo) throws Exception { return mapper.imageAdmin(itemNo); }

    @Override
    public int itemUpload(ItemVO vo) {
        return mapper.insert(vo);
    }

    @Override
    public int itemRemove(Integer itemNo) {
        return mapper.delete(itemNo);
    }

    @Override
    public int itemModify(ItemVO vo) {

        return mapper.update(vo);

    }

    @Override
    public List<ItemVO> selectAll() {
        return mapper.selectAll();
    }

    //나중에 검색설정 하게될 때 매개변수 넣어줘야돼
    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return mapper.searchResultCnt(sc);
    }

    @Override
    public List<ItemVO> getSearchResultPage(SearchCondition sc) throws Exception {
        return mapper.searchSelectPage(sc);
    }

    // heeJeong item 상세페이지------------------------------------------------------------- //
    @Override
    public ItemVO itemdetail(ItemVO vo) throws Exception {
        return mapper.itemdetail(vo);
    }

    // ** image테이블 이미지 여러장 출력
    @Override
    public ImageVO imageDetail(ImageVO vo1) throws Exception {
        return mapper.imageDetail(vo1);
    }

    // item등록 이미지 등록
    @Override
    public int itemImgUpload(ImageVO vo1) throws Exception {
        return mapper.itemImgUpload(vo1);
    }

    // item 업데이트 이미지 업데이트

    @Override
    public int imageModify(ImageVO vo1) throws Exception {
        return mapper.imageModify(vo1);
    }
}

package com.green.meal.service;

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
}

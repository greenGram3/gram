package com.green.meal.service;

import com.green.meal.domain.*;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface OrderService {

    void sendUpdate(Integer[] itemNoArr, Integer[] itemNoAmount, Integer orderNo) throws Exception;

    void returnUpdate(Integer[] itemNoArr, Integer[] itemNoAmount, Integer orderNo) throws Exception;

    List<OrderDetailVO> orderDetail(Integer orderNo) throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;

    List<OrderDetailVO> getSearchResultPage(SearchCondition sc) throws Exception;

    int buyInfoToList(OrderDetailVO vo) throws Exception;

    int buyInfoToDetail(OrderDetailVO vo) throws Exception;

}

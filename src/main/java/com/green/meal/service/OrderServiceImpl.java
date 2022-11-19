package com.green.meal.service;

import com.green.meal.domain.*;
import com.green.meal.mapper.OrderMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.sql.DataSource;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderMapper mapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void sendUpdate(Integer[] itemNoArr, Integer[] itemAmountArr, Integer orderNo) throws Exception {
        for(int i = 0; i < itemNoArr.length; i++) {

            HashMap map = new HashMap();
            map.put("itemNo", itemNoArr[i]);
            map.put("itemAmount", itemAmountArr[i]);

            if(mapper.sendAmountUpdate(map)!=1){
                throw new Exception();
            }

        }

        if(mapper.sendStateUpdate(orderNo)!=1){
            throw new Exception();
        }

    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void returnUpdate(Integer[] itemNoArr, Integer[] itemAmountArr, Integer orderNo) throws Exception {

        for(int i = 0; i < itemNoArr.length; i++) {

            HashMap map = new HashMap();
            map.put("itemNo", itemNoArr[i]);
            map.put("itemAmount", itemAmountArr[i]);

            if(mapper.returnAmountUpdate(map)!=1){
                throw new Exception();
            }

        }

        if(mapper.returnStateUpdate(orderNo)!=1){
            throw new Exception();
        }
    }


    @Override
    public List<OrderDetailVO> orderDetail(Integer orderNo) throws Exception {
        return mapper.selectDetail(orderNo);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return mapper.searchResultCnt(sc);
    }

    @Override
    public List<OrderDetailVO> getSearchResultPage(SearchCondition sc) throws Exception {
        return mapper.searchSelectPage(sc);
    }

    @Override
    public int buyInfoToList(OrderDetailVO vo) throws Exception {
        return mapper.buyInfoToList(vo);
    }

    @Override
    public int buyInfoToDetail(OrderDetailVO vo) throws Exception {
        return mapper.buyInfoToDetail(vo);
    }

}

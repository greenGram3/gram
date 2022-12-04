package com.green.meal.service;

import com.green.meal.domain.OrderDetailDto;
import com.green.meal.domain.OrderDetailVO;
import com.green.meal.domain.OrderListDto;
import com.green.meal.domain.OrderSearch;
import com.green.meal.mapper.UserOrderMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserOrderServiceImpl implements UserOrderService {

    private final UserOrderMapper userOrderMapper;


    @Override
    @Transactional(rollbackFor = Exception.class)
    public int save(List<OrderDetailVO> list, OrderDetailVO odvo) throws Exception{
        int rowCntV2 = 0;
        int rowCntV1 = userOrderMapper.insertUser(odvo);

        for (OrderDetailVO vo : list) {
            vo.setOrderNo(odvo.getOrderNo());
             rowCntV2 = userOrderMapper.insertItem(vo);
        }


        if((rowCntV1+rowCntV2) <= 1) {
            throw new Exception("주문저장실패");
        }

        return rowCntV1+rowCntV2;
    }

    @Override
    public List<OrderListDto> orderUserInfo(String userId) {
        List<OrderListDto> orderList = userOrderMapper.orderList(userId);
        setOrder(orderList);

        return orderList;
    }


    @Override
    public List<OrderListDto> searchOrder(OrderSearch orderSearch) {

        List<OrderListDto> orderList = userOrderMapper.searchOrder(orderSearch);
        setOrder(orderList);
        return orderList;
    }

    @Override
    public OrderListDto order(String userId, Integer orderNo) {
        //맵핑된 주문번호 정리하기

        Map map = new HashMap<>();
        map.put("userId",userId);
        map.put("orderNo",orderNo);

        OrderListDto orderListDto =  userOrderMapper.order(map);

        orderListDto.setOrder(orderListDto.getOrderDate()+"-0000"+orderListDto.getOrderNo());
        //맵핑된 배송지 세팅하기
        String delyAdd = orderListDto.getDelyAddr();

        String[] addrs = delyAdd.split("@");

        String delyAddr  = addrs[1] + " " + addrs[2];
        orderListDto.setDelyAddr(delyAddr);

        List<OrderDetailDto> list = userOrderMapper.orderDetail(orderNo);
        Integer totalPay = 0;
        for (OrderDetailDto orderDetailDto : list) {
            totalPay +=(orderDetailDto.getItemPrice()*orderDetailDto.getItemAmount());
        }

        orderListDto.setTotalPay(totalPay);
        orderListDto.setList(list);

        return orderListDto;
    }

    @Override
    public int orderConfirm(OrderListDto orderListVO) {
        return userOrderMapper.orderConfirm(orderListVO);
    }

    @Override
    public List<OrderListDto> cancelList(String userId) {
        List<OrderListDto> cancelList= userOrderMapper.cancelList(userId);
        setOrder(cancelList);

        return cancelList;
    }


    // 주문 번호및 주문 목록의 대표 이름 정하기
    private void setOrder(List<OrderListDto> orderList) {
        for (OrderListDto listVO : orderList) {
            //회원의 주문번호별 결제한 상품내역 리스트에 담기
            List<OrderDetailDto> list = userOrderMapper.orderDetail(listVO.getOrderNo());
            //주문번호 셋팅 ( 보여주기 식 )
            listVO.setOrder(listVO.getOrderDate()+"-0000"+listVO.getOrderNo());
            listVO.setList(list);

            String tmp = null;
            Integer totalPay = 0;
            //주문목록에서 상품 금액 합치기, 주문한상품들 이름 더하기 ( 대표이름 )
            for (OrderDetailDto orderDetailVO : list) {
                totalPay +=(orderDetailVO.getItemPrice()*orderDetailVO.getItemAmount());
                tmp +="@"+ orderDetailVO.getItemName();
            }

            assert tmp != null;
            String[] splitItem = tmp.split("@");
            int length = splitItem.length;

            //주문리스트 대표상품이름
            String totalItem = splitItem[1];
            //2건 이상일때 외 건 붙이기
            if(length>2){
                totalItem = splitItem[1]+" 외"+(length-2)+" 건";
            }


            listVO.setTotalItem(totalItem);
            listVO.setTotalPay(totalPay);

        }
    }
}

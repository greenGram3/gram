package com.green.meal.domain;

import lombok.Data;

import java.util.List;

@Data
public class OrderListDto {
    private Integer orderNo;
    private String userId;
    private String receiver;
    private String userPhone;
    private String delyAddr;

    private String payment;
    private String orderReq;
    private String orderState;
    private int totalPay;
    private String totalItem;
    private String orderDate;

    private List<OrderDetailDto> list;
    private String order;
    private String confirm;


    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate.substring(0,10);
    }
}

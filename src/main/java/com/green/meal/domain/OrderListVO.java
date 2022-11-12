package com.green.meal.domain;

import java.util.Objects;

public class OrderListVO {

    private int orderNo;
    private String userId;
    private String delyAddr;
    private String userPhone;
    private String orderDate;
    private String payment;
    private String orderReq;
    private String orderState;

    public OrderListVO() {}

    public OrderListVO(int orderNo, String userId, String delyAddr, String userPhone, String orderDate, String payment, String orderReq, String orderState) {
        this.orderNo = orderNo;
        this.userId = userId;
        this.delyAddr = delyAddr;
        this.userPhone = userPhone;
        this.orderDate = orderDate;
        this.payment = payment;
        this.orderReq = orderReq;
        this.orderState = orderState;
    }

    public int getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDelyAddr() {
        return delyAddr;
    }

    public void setDelyAddr(String delyAddr) {
        this.delyAddr = delyAddr;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getOrderReq() {
        return orderReq;
    }

    public void setOrderReq(String orderReq) {
        this.orderReq = orderReq;
    }

    public String getOrderState() {
        return orderState;
    }

    public void setOrderState(String orderState) {
        this.orderState = orderState;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderListVO that = (OrderListVO) o;
        return orderNo == that.orderNo && Objects.equals(userId, that.userId) && Objects.equals(delyAddr, that.delyAddr) && Objects.equals(userPhone, that.userPhone) && Objects.equals(orderDate, that.orderDate) && Objects.equals(payment, that.payment) && Objects.equals(orderReq, that.orderReq) && Objects.equals(orderState, that.orderState);
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderNo, userId, delyAddr, userPhone, orderDate, payment, orderReq, orderState);
    }

    @Override
    public String toString() {
        return "OrderListVO{" +
                "orderNo=" + orderNo +
                ", userId='" + userId + '\'' +
                ", delyAddr='" + delyAddr + '\'' +
                ", userPhone='" + userPhone + '\'' +
                ", orderDate='" + orderDate + '\'' +
                ", payment='" + payment + '\'' +
                ", orderReq='" + orderReq + '\'' +
                ", orderState='" + orderState + '\'' +
                '}';
    }

}
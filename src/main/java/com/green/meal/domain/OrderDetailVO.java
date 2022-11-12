package com.green.meal.domain;

import java.util.Objects;

public class OrderDetailVO extends OrderListVO {

    private int oderNo;
    private int itemNo;
    private int itemPrice;
    private int itemAmount;

    public OrderDetailVO() {}

    public OrderDetailVO(int oderNo, int itemNo, int itemPrice, int itemAmount) {
        this.oderNo = oderNo;
        this.itemNo = itemNo;
        this.itemPrice = itemPrice;
        this.itemAmount = itemAmount;
    }

    public OrderDetailVO(int orderNo, String userId, String delyAddr, String userPhone, String orderDate, String payment, String orderReq, String orderState, int oderNo, int itemNo, int itemPrice, int itemAmount) {
        super(orderNo, userId, delyAddr, userPhone, orderDate, payment, orderReq, orderState);
        this.oderNo = oderNo;
        this.itemNo = itemNo;
        this.itemPrice = itemPrice;
        this.itemAmount = itemAmount;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        OrderDetailVO that = (OrderDetailVO) o;
        return oderNo == that.oderNo && itemNo == that.itemNo && itemPrice == that.itemPrice && itemAmount == that.itemAmount;
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), oderNo, itemNo, itemPrice, itemAmount);
    }

    public int getOderNo() {
        return oderNo;
    }

    public void setOderNo(int oderNo) {
        this.oderNo = oderNo;
    }

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }

    public int getItemAmount() {
        return itemAmount;
    }

    public void setItemAmount(int itemAmount) {
        this.itemAmount = itemAmount;
    }

    @Override
    public String toString() {
        return "OrderDetailVO{" +
                "oderNo=" + oderNo +
                ", itemNo=" + itemNo +
                ", itemPrice=" + itemPrice +
                ", itemAmount=" + itemAmount +
                '}';
    }
}

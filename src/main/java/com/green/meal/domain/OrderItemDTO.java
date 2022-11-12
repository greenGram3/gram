package com.green.meal.domain;

import java.util.Objects;

public class OrderItemDTO {

    private int itemNo;
    private int itemAmount;
    private String itemName;
    private int itemPrice;

    public OrderItemDTO() {}

    public OrderItemDTO(int itemNo, int itemAmount, int itemPrice) {
        this.itemNo = itemNo;
        this.itemAmount = itemAmount;
        this.itemPrice = itemPrice;
    }

    public OrderItemDTO(int itemNo, int itemAmount, String itemName, int itemPrice) {
        this.itemNo = itemNo;
        this.itemAmount = itemAmount;
        this.itemName = itemName;
        this.itemPrice = itemPrice;
    }

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public int getItemAmount() {
        return itemAmount;
    }

    public void setItemAmount(int itemAmount) {
        this.itemAmount = itemAmount;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getItemPrice() {
        return itemPrice;
    }

    public void setItemPrice(int itemPrice) {
        this.itemPrice = itemPrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderItemDTO that = (OrderItemDTO) o;
        return itemNo == that.itemNo && itemAmount == that.itemAmount && itemPrice == that.itemPrice && Objects.equals(itemName, that.itemName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemNo, itemAmount, itemName, itemPrice);
    }

    @Override
    public String toString() {
        return "OrderItemDTO{" +
                "itemNo=" + itemNo +
                ", itemAmount=" + itemAmount +
                ", itemName='" + itemName + '\'' +
                ", itemPrice=" + itemPrice +
                '}';
    }

}



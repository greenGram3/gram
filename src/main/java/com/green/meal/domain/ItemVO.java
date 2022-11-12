package com.green.meal.domain;

import java.util.Objects;

public class ItemVO {

    private int itemNo;
    private String itemCategory1;
    private String itemCategory2;
    private String itemName;
    private int itemAmount;
    private int itemPrice;

    public ItemVO () { }

    public ItemVO(String itemCategory1, String itemCategory2, String itemName, int itemAmount, int itemPrice) {
        this.itemCategory1 = itemCategory1;
        this.itemCategory2 = itemCategory2;
        this.itemName = itemName;
        this.itemAmount = itemAmount;
        this.itemPrice = itemPrice;
    }

    public ItemVO(int itemNo, String itemCategory1, String itemCategory2, String itemName, int itemAmount, int itemPrice) {
        this.itemNo = itemNo;
        this.itemCategory1 = itemCategory1;
        this.itemCategory2 = itemCategory2;
        this.itemName = itemName;
        this.itemAmount = itemAmount;
        this.itemPrice = itemPrice;
    }

    public int getItemNo() {
        return itemNo;
    }

    public void setItemNo(int itemNo) {
        this.itemNo = itemNo;
    }

    public String getItemCategory1() {
        return itemCategory1;
    }

    public void setItemCategory1(String itemCategory1) {
        this.itemCategory1 = itemCategory1;
    }

    public String getItemCategory2() {
        return itemCategory2;
    }

    public void setItemCategory2(String itemCategory2) {
        this.itemCategory2 = itemCategory2;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public int getItemAmount() {
        return itemAmount;
    }

    public void setItemAmount(int itemAmount) {
        this.itemAmount = itemAmount;
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
        ItemVO itemVO = (ItemVO) o;
        return itemNo == itemVO.itemNo && itemAmount == itemVO.itemAmount && itemPrice == itemVO.itemPrice && Objects.equals(itemCategory1, itemVO.itemCategory1) && Objects.equals(itemCategory2, itemVO.itemCategory2) && Objects.equals(itemName, itemVO.itemName);
    }

    @Override
    public int hashCode() {
        return Objects.hash(itemNo, itemCategory1, itemCategory2, itemName, itemAmount, itemPrice);
    }

    @Override
    public String toString() {
        return "ItemVO{" +
                "itemNo=" + itemNo +
                ", itemCategory1='" + itemCategory1 + '\'' +
                ", itemCategory2='" + itemCategory2 + '\'' +
                ", itemName='" + itemName + '\'' +
                ", itemAmount=" + itemAmount +
                ", itemPrice=" + itemPrice +
                '}';
    }
}

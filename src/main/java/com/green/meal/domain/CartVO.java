package com.green.meal.domain;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data @NoArgsConstructor
public class CartVO {
    private String userId;
    private Integer itemNo;
    private String itemName;
    private Integer cartAmount;
    private Integer itemPrice;
    private String path;


    public CartVO(String userId, Integer itemNo, Integer cartAmount) {
        this.userId = userId;
        this.itemNo = itemNo;
        this.cartAmount = cartAmount;
    }

    public CartVO(Integer itemNo, String itemName, Integer cartAmount, Integer itemPrice, String path) {
        this.itemNo = itemNo;
        this.itemName = itemName;
        this.cartAmount = cartAmount;
        this.itemPrice = itemPrice;
        this.path = path;
    }

    public CartVO(String userId, Integer itemNo, String itemName, Integer cartAmount, Integer itemPrice, String path) {
        this.userId = userId;
        this.itemNo = itemNo;
        this.itemName = itemName;
        this.cartAmount = cartAmount;
        this.itemPrice = itemPrice;
        this.path = path;
    }

    @Override
    public String toString() {
        return "CartVO{" +
                "userId='" + userId + '\'' +
                ", itemNo=" + itemNo +
                ", itemName='" + itemName + '\'' +
                ", cartAmount=" + cartAmount +
                ", itemPrice=" + itemPrice +
                ", path='" + path + '\'' +
                '}';
    }
}
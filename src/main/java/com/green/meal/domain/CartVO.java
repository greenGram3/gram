package com.green.meal.domain;

import lombok.*;

@Data @RequiredArgsConstructor
public class CartVO {
    private String userId;
    private Integer itemNo;
    private String itemName;
    private Integer cartAmount;
    private Integer itemPrice;
    private String path;


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
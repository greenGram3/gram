package com.green.meal.domain;

import lombok.Data;

@Data
public class OrderDetailDto {
    private Integer orderNo;
    private Integer itemNo;

    private String itemName;
    private Integer itemPrice;
    private Integer itemAmount;
    private String fileName;
}

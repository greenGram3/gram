package com.green.meal.domain;

import lombok.*;

import java.util.Objects;

@Getter
@Setter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
public class OrderDetailVO extends OrderListVO {

    private int itemNo;
    private int itemPrice;
    private int itemAmount;
    private int cartAmount;
    private String itemName;
    private String fileName;

}

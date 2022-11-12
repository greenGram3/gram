package com.green.meal.domain;

import lombok.Data;

@Data
public class OrderSearch {

    private String startDate;
    private String endDate;
    private String userId;

    private Integer orderNo;
}

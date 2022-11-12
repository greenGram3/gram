package com.green.meal.domain;

import lombok.Data;

@Data
public class NoticeVO {
    private int noticeNo;
    private String noticeTitle;
    private String noticeContent;
    private String regDate;
    private String userId;
    private String noticeType;

}

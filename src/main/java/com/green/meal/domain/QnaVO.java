package com.green.meal.domain;

import lombok.Data;

@Data
public class QnaVO {
    private int qnaNo;
    private String userId;
    private String regDate;
    private String qnaTitle;
    private String qnaContent;

    private int qnaRoot;
    private int qnaStep;
    private int qnaChild;
}

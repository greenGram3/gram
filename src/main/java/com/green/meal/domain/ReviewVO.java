package com.green.meal.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ReviewVO {
    private int reviewNo;
    private String userId;
    private int orderNo;
    private int itemNo;

    private String reviewTitle;
    private String reviewContent;
    private String regDate;

    private int reviewRoot;
    private int reviewStep;
    private int reviewChild;

    private int reviewStar;

    private String imgName;
    //DB에 저장된 이미지 String경로 꺼내오는 용도
    // DB & ui의 컬럼명, name명과 일치

    private MultipartFile imgNamef;
    //String타입 아닌 이미지정보 저장할 객체 타입
    //UI태그의 name속성과 일치

    private String itemName;
    private int itemPrice;
}

package com.green.meal.domain;

import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.util.Objects;
@Setter @Getter  @EqualsAndHashCode
@ToString
@NoArgsConstructor
public class ItemVO {

    private int itemNo;
    private String itemCategory1;
    private String itemCategory2;
    private String itemName;
    private int itemAmount;
    private int itemPrice;

    // 이미지
    private String fileName; //DB에 저장된 이미지 String경로 꺼내오는 용

    private MultipartFile fileNamef; //img 진짜 정보 저장 객체 타입



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



}

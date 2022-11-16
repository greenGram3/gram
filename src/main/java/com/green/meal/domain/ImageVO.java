package com.green.meal.domain;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class ImageVO {
    private int itemNo;
    private String imgName;
    private MultipartFile imgNamef1;
    private String imgType;

}

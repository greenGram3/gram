package com.green.meal.domain;

import com.green.meal.annotation.PhoneCheck;
import com.green.meal.annotation.PwdCheck;
import com.green.meal.annotation.SpecialChCheck;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.validator.constraints.Length;
import org.springframework.web.multipart.MultipartFile;

@Getter @Setter @ToString @EqualsAndHashCode
@Slf4j @NoArgsConstructor
public class EventVO {
    private Integer eventNo;
    private String eventName;
    private String imgName;
    private MultipartFile fileName; //img 진짜 정보 저장 객체 타입

    private String imgPath;
    private String banner;


}

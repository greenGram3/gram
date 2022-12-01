package com.green.meal.domain;

import com.green.meal.annotation.PhoneCheck;
import com.green.meal.annotation.PwdCheck;
import com.green.meal.annotation.SpecialChCheck;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.validator.constraints.Length;

@Getter @Setter @ToString @EqualsAndHashCode
@Slf4j @NoArgsConstructor
public class EventVO {
    private Integer eventNo;
    private String eventName;
    private String imgName;
    private String imgPath;
    private String banner;
}

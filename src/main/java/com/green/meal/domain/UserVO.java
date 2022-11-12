package com.green.meal.domain;

import com.green.meal.annotation.PhoneCheck;
import com.green.meal.annotation.PwdCheck;
import com.green.meal.annotation.SpecialChCheck;
import lombok.*;
import lombok.extern.slf4j.Slf4j;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.Range;

import javax.validation.constraints.NotBlank;

@Getter @Setter @ToString @EqualsAndHashCode @Slf4j @NoArgsConstructor
public class UserVO {
    @Length(min = 4, max = 12) @SpecialChCheck
    private String userId;
    @Length(min = 1, max = 10) @SpecialChCheck
    private String userName;
    private String userEmail;
    @Length(min = 8, max = 20) @PwdCheck
    private String userPwd;
    @PhoneCheck
    private String userPhone;

    private String userAddr;
    private String userBirth;
    private String userGender;
    private String regDate;
    private String etc1;
    private String etc2;
    private String etc3;
}

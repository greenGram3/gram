package com.green.meal.validator;


import com.green.meal.annotation.PwdCheck;
import lombok.extern.slf4j.Slf4j;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class PwdValidator implements ConstraintValidator<PwdCheck, String> {
    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        Pattern pattern = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$");
        Matcher matcher = pattern.matcher(s);

        if (matcher.matches()) {
            log.info("Valid pwd success");
        } else {
            log.info("Valid pwd fail");
            return false;
        }
        return true;
    }
}

package com.green.meal.validator;


import com.green.meal.annotation.PhoneCheck;
import lombok.extern.slf4j.Slf4j;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class PhoneValidator implements ConstraintValidator<PhoneCheck, String> {

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        Pattern pattern = Pattern.compile("\\d{3}-\\d{4}-\\d{4}");
        Matcher matcher = pattern.matcher(s);

        if (matcher.matches()) {
            log.info("Valid phone number success");
        } else {
            log.info("Valid phone number fail");
            return false;
        }
        return matcher.matches();
    }

}

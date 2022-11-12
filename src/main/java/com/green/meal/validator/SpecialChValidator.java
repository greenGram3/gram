package com.green.meal.validator;


import com.green.meal.annotation.SpecialChCheck;
import lombok.extern.slf4j.Slf4j;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class SpecialChValidator implements ConstraintValidator<SpecialChCheck, String> {


    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if(Pattern.matches("^[a-zA-Z0-9]*$", s)){
            log.info("SpecialChCheck success");
        }else{
            log.info("SpecialChCheck fail");
            return false;
        }
        return true;
    }
}

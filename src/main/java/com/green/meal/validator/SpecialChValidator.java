package com.green.meal.validator;
import com.green.meal.annotation.SpecialChCheck;
import lombok.extern.slf4j.Slf4j;
import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.regex.Pattern;

@Slf4j
public class SpecialChValidator implements ConstraintValidator<SpecialChCheck, String> {
    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        if(Pattern.matches("^[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$", s)){
            log.info("SpecialChCheck success");
        }else{
            log.info("SpecialChCheck fail");
            return false;
        }
        return true;
    }
}

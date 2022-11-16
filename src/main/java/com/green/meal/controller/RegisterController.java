package com.green.meal.controller;

import com.green.meal.domain.UserVO;
import com.green.meal.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/register")
public class RegisterController {

    public static PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    private final UserService userService;

    //매인 -> 회원가입
    @GetMapping("/register")
    public String register(){
        return "userInfo/registerForm";
    }

    //회원가입 -> 메인
    @PostMapping("/register")
    public String register2(@Valid UserVO user, BindingResult result, RedirectAttributes attr, String[] userEmailArr, Model model, String pwdCheck) {

        if(result.hasErrors()){
            model.addAttribute("pwdCheck", pwdCheck);
            model.addAttribute("userEmailArr", userEmailArr);
            model.addAttribute("user", user);
            return "userInfo/registerForm";
        }

        //UserEmail 수동으로 넣기
        user.setUserEmail(addArr(userEmailArr));
        //패스워드 암호화
        user.getUserPwd();
        String digest = passwordEncoder.encode(user.getUserPwd());
        user.setUserPwd(digest);

        userService.register(user);
        attr.addFlashAttribute("msg","register_ok");
        return "redirect:/";

    }

    //회원가입 -> 중복검사
    @PostMapping("/dupliCheck")
    @ResponseBody
    public String dupliCheck(@RequestBody String userId){
        log.info("userId : "+userId);
        userId = userId.replaceAll("\"", "");

        if(userService.idDupliCheck(userId)==null) return "available";
        else return "nonavailable";
    }

    public String addArr(String[] strings){
        String value = "";
        for (int i=0;i<strings.length;i++){
            value += strings[i];
            if(i!=strings.length-1) value+="@";
        }
        return value;
    }


}

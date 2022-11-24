package com.green.meal.controller;

import com.green.meal.domain.UserVO;
import com.green.meal.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import static com.green.meal.controller.RegisterController.passwordEncoder;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/update")
public class UpdateController {
    private final UserService userService;

    @GetMapping("/user")
    public String updateUser(HttpServletRequest request, Model model){
        String userId = (String) request.getSession().getAttribute("userId");
        UserVO user = userService.idDupliCheck(userId);
        // 주소 뽑아서 @ 빼고 정리
        String userAddr = user.getUserAddr();
        log.info("userAddr : "+userAddr);
        if(userAddr.length() > 0) {user.setUserAddr(userAddr.split("@")[1]+" "+userAddr.split("@")[2]);}

        model.addAttribute("user", user);
        return "userInfo/updateUser";
    }

    // 비밀번호변경
    @PostMapping("/userPwd")
    @ResponseBody
    public int updateUserPwd(@RequestBody String data,HttpSession session ){

        data = data.replaceAll("\"", "");
        String[] datas = data.split("/");
        String cp = datas[0]; String np1 = datas[1];
        String userId = (String)session.getAttribute("userId");

        String RealPwd = userService.idDupliCheck(userId).getUserPwd();
        // 현재 비밀번호 안맞을경우
        if(!passwordEncoder.matches(cp , RealPwd))
            return 2;

        int result = userService.changePwd(passwordEncoder.encode(np1), userId);

        return result;
    }

    // 이름 변경
    @PostMapping("/userName")
    public String updateUserName(String newName, HttpSession session){
        updateUser(newName, session);
        return "redirect:/update/user";
    }

    // 이메일 변경
    @PostMapping("/userEmail")
    public String updateUserEmail(String[] userEmailArr, HttpSession session){
        String newEmail = userEmailArr[0] + "@" + userEmailArr[1];
        updateUser(newEmail, session);
        return "redirect:/update/user";
    }

    // 휴대전화 변경
    @PostMapping("/userPhone")
    public String updateUserPhone(String newPhone, HttpSession session){
        updateUser(newPhone, session);
        return "redirect:/update/user";
    }

    // 주소 변경
    @PostMapping("/userAddr")
    public String updateUserAddr(String roadAddrPart1, String addrDetail, String zipNo,HttpSession session){
        String newAddr = zipNo+"@"+roadAddrPart1+"@"+addrDetail;
        userService.changeAddr(newAddr, (String) session.getAttribute("userId"));
        return "redirect:/update/user";
    }
    //============================================================================================================
    //회원탈퇴
    @GetMapping("/userDelete")
    public String delUserGet(){
        return "userInfo/deleteUser";
    }

    @PostMapping("/userDelete")
    public String delUserPost(String userPwd, HttpSession session, RedirectAttributes rettr){
        String RealPwd = userService.idDupliCheck((String) session.getAttribute("userId")).getUserPwd();
        if(passwordEncoder.matches(userPwd , RealPwd)){
            userService.deleteUser((String) session.getAttribute("userId"));
            rettr.addFlashAttribute("msg","deleteUser_ok");
            session.invalidate();
            return "redirect:/";
        }else rettr.addFlashAttribute("msg","deleteUser_fail");

        return "redirect:/update/userDelete";
    }

    @PostMapping("/userDelete2")
    public String delUserPost2(HttpSession session, RedirectAttributes rettr){
        // User DB에서삭제
        rettr.addFlashAttribute("msg","deleteUser_ok");
        userService.deleteNaverUser((String) session.getAttribute("userId"));

        //네이버 접근 토근 삭제
        String clientId = "eELpwpqlV0GXGymjU5cB";
        String clientSecret = "fuLNwvC5Wz";
        String access_token = (String) session.getAttribute("access_token");
        log.info("access_token : "+access_token);
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=delete"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&access_token=" + access_token
                + "&&service_provider=NAVER";
        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuilder res = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }
            br.close();
            if (responseCode == 200) {
                log.info("deleteToken_ok "+res.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.invalidate();
        return "redirect:/";
    }


    public int updateUser(String userInfo, HttpSession session){
        String userId = (String) session.getAttribute("userId");
        if(userInfo.contains("@")) {return userService.changeEmail(userInfo, userId); }
        else if(userInfo.contains("-")) {return userService.changePhone(userInfo, userId);}
        else return userService.changeName(userInfo, userId);
    }

}

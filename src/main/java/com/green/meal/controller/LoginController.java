package com.green.meal.controller;

import com.green.meal.domain.UserVO;
import com.green.meal.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.http.MediaType;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.Map;

import static com.green.meal.controller.RegisterController.passwordEncoder;
import static java.lang.System.out;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginController {

    private final UserService userService;

    @GetMapping("/login")
    public String loginForm() {
        return "userInfo/loginForm";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes rettr) {
        // 1. 세션을 종료
        session.invalidate();

        rettr.addFlashAttribute("msg","logout_ok");
        // 2. 홈으로 이동
        return "redirect:/";
    }


    @PostMapping("/login")
    public String login(String userId, String userPwd, boolean rememberId,
                        HttpServletRequest request, HttpServletResponse response, RedirectAttributes rettr) throws Exception {

        // 1. id와 pwd를 확인
        if(!loginCheck(userId, userPwd)) {
            // 2-1   일치하지 않으면, loginForm으로 이동
            String msg = URLEncoder.encode("id 또는 pwd가 일치하지 않습니다.", "utf-8");
            return "redirect:/login/login?msg="+msg;
        }
        // 2-2. id와 pwd가 일치하면,
        //  세션 객체를 얻어오기
        HttpSession session = request.getSession();
        //  세션 객체에 id를 저장
        session.setAttribute("userId", userId);

        if(rememberId) {
            //     1. 쿠키를 생성
            Cookie cookie = new Cookie("userId", userId); // ctrl+shift+o 자동 import
//		       2. 응답에 저장
            response.addCookie(cookie);
        } else {
            // 1. 쿠키를 삭제
            Cookie cookie = new Cookie("userId", userId); // ctrl+shift+o 자동 import
            cookie.setMaxAge(0); // 쿠키를 삭제
//		       2. 응답에 저장
            response.addCookie(cookie);
        }

        rettr.addFlashAttribute("msg","login_ok");
//		       3. 홈으로 이동
        return "redirect:/";
    }

    @GetMapping("/naverLogin2")
    public String naverLogin2(HttpSession session, Model model) {
        String clientId = "eELpwpqlV0GXGymjU5cB";//애플리케이션 클라이언트 아이디값";
        String redirectURI = null;
        try {
            redirectURI = URLEncoder.encode("http://localhost:8080/meal/login/naverLogin", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        SecureRandom random = new SecureRandom();
        String state = new BigInteger(130, random).toString();
        String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
                + "&client_id=" + clientId
                + "&redirect_uri=" + redirectURI
                + "&state=" + state;
        session.setAttribute("state", state);
        model.addAttribute("apiURL", apiURL);
        return "redirect:"+apiURL;
    }

    @GetMapping("/naverLogin")
    public String naverLogin(String code, String state, HttpServletRequest request, RedirectAttributes rettr) {
        request.setAttribute("code", code);
        request.setAttribute("state", state);
        log.info("code : "+code+" "+state);

        String clientId = "eELpwpqlV0GXGymjU5cB";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "fuLNwvC5Wz";//애플리케이션 클라이언트 시크릿값";
        String redirectURI = null;
        try {
            redirectURI = URLEncoder.encode("http://localhost:8080/meal/naverJson", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectURI
                + "&code=" + code
                + "&state=" + state;
        String accessToken = "";
        String refresh_token = "";
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
                accessToken = res.toString().split(":")[1].replace(",\"refresh_token\"", "");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
//========================================================================================================================
        String apiURL2 = "https://openapi.naver.com/v1/nid/me";

        try {
            URL url = new URL(apiURL2);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestProperty("Authorization","Bearer "+accessToken);
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
                String userId = ""; String userName = ""; String userEmail = ""; String userPwd = ""; String userPhone = ""; String userAddr=""; String birthday=""; String birthyear=""; String userBirth=""; String userGender="";
                String res2 = res.toString().replace("{","").replace("}","");
                String[] info = res2.split(",");

                for(int i=1; i<info.length; i++){
                    if(info[i].contains("\"id\":")) userId = info[i];
                    if(info[i].contains("\"name\":")) userName = info[i];
                    if(info[i].contains("\"email\":")) userEmail = info[i];
                    if(info[i].contains("\"mobile\":")) userPhone = info[i];
                    if(info[i].contains("\"birthday\":")) birthday = info[i];
                    if(info[i].contains("\"birthyear\":")) birthyear = info[i];
                    if(info[i].contains("\"gender\":")) userGender = info[i];
                }
                userId = userId.substring(userId.indexOf("\"id\":")+5).replace("\"","");
                userName = userName.substring(userName.indexOf("\"name\":")+7).replace("\"","");
                userEmail = userEmail.substring(userEmail.indexOf("\"email\":")+8).replace("\"","");
                userPhone = userPhone.substring(userPhone.indexOf("\"mobile\":")+9).replace("\"","");
                if(birthday!="")birthday = birthday.substring(birthday.indexOf("\"birthday\":")+11).replace("\"","");
                if(birthyear!="")birthyear = birthyear.substring(birthyear.indexOf("\"birthyear\":")+12).replace("\"","");
                userBirth = birthyear+"-"+birthday;
                if(userGender!="") userGender = userGender.substring(userGender.indexOf("\"gender\":")+9).replace("\"","");
                UserVO user = new UserVO();
                user.setUserId(userId);
                user.setUserName(userName);
                user.setUserEmail(userEmail);
                user.setUserPwd(userPwd);
                user.setUserPhone(userPhone);
                user.setUserAddr(userAddr);
                user.setUserBirth(userBirth);
                user.setUserGender(userGender);

                try{
                    userService.register(user);
                }catch (Exception e){
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", userId);
                    rettr.addFlashAttribute("msg","login_ok");
                }

                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                rettr.addFlashAttribute("msg","login_ok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "redirect:/";
    }



    private boolean loginCheck(String userId, String userPwd) {
        UserVO user = null;
        user = userService.idDupliCheck(userId);
        return user!=null && passwordEncoder.matches(userPwd,user.getUserPwd());
    }
}

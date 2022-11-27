package com.green.meal.controller;


import com.green.meal.domain.PageHandler;
import com.green.meal.domain.SearchCondition;
import com.green.meal.domain.UserVO;
import com.green.meal.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @GetMapping("/list")
    public String userList(SearchCondition sc, Model m) {

        try {

            //페이징 하기 위해 리스트의 행 총 개수 구하기
            int totalCnt = userService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            //페이징 객체에 전체개수 넣고, 현재페이지와 페이지사이즈 등이 담겨있는 sc객체 넣기
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            //회원리스트 가져오기, 페이징 위해 매개변수로 sc전달
            List<UserVO> list = userService.getSearchResultPage(sc);

            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

        } catch (Exception e) {
            m.addAttribute("msg", "LIST_ERR");
            e.printStackTrace();
        }

        return "admin/userList";
    }

    @GetMapping("/read")
    public String read(UserVO vo, SearchCondition sc, Model m) {
        try {

            //회원 상세 정보 불러오기 (회원 리스트에서 행 하나 가져오는 것)
            vo = userService.userDetail(vo.getUserId());

            //회원정보 중 주소 형태 변환
            String userAddrTemp = vo.getUserAddr();
            if(userAddrTemp.length() > 0){
                String[] addrs = userAddrTemp.split("@");
                String userAddr  = addrs[1] + " " + addrs[2];
                vo.setUserAddr(userAddr);
            }
            m.addAttribute("vo", vo);
            m.addAttribute("sc", sc);

            return "admin/userDetail";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "READ_ERR");

            return "admin/userList";
        }
    }

    @PostMapping("/remove")
    public String remove(UserVO vo, SearchCondition sc, Model m, RedirectAttributes rattr) {
        try {

            //원래 있던 페이지로 돌아가기 위해 꼭 필요함 -> 파라미터로 전달해야되기 때문
            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());

            //회원 삭제하기
            int rowCnt = userService.userWithdraw(vo.getUserId());

            if (rowCnt != 1)
                throw new Exception("user withdraw failed");

            //새로고침시 메세지 계속 발생하는 문제 해결하기 위해
            //Model -> RedirectAttributes 로 변경
            rattr.addFlashAttribute("msg", "WDR_OK");

            //회원삭제 성공하면 다시 리스트로 이동
            return "redirect:/user/list";

        } catch (Exception e) {
            e.printStackTrace();
            //회원삭제 실패 하면 기존 회원정보 그대로 담아서 회원 상세정보 다시 보여주기
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "WDR_ERR");
            return "admin/userDetail";
        }

    }

}

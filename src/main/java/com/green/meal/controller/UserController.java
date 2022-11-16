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

            int totalCnt = userService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

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

            vo = userService.userDetail(vo.getUserId());
            System.out.println("vo = " + vo);
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

            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());
            // 원래 있던 페이지로 돌아가기 위해 꼭 필요함 -> 파라미터로 전달해야되기 때문

            int rowCnt = userService.userWithdraw(vo.getUserId());

            if (rowCnt != 1)
                throw new Exception("user withdraw failed");

            rattr.addFlashAttribute("msg", "WDR_OK");

            return "redirect:/user/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "WDR_ERR");
            return "admin/userDetail";
        }

    }

}

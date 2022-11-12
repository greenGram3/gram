package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.service.DelyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.LinkedList;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/delivery")
public class DeliveryController {

    private final DelyService delyService;

    @GetMapping("/delivery")
    public String deliveryGet(Model model, HttpSession session){
        LinkedList<DeliveryVO> list = new LinkedList<>() ;
        list.addAll(delyService.selectDelivery((String)session.getAttribute("userId")));
        BaseDelivery(list);

        model.addAttribute("list",list);
        return "delyForm";
    }

    @GetMapping("/register")
    public String delyRegisterGet(){
        return "delyRegister";
    }

    @PostMapping("/register")
    public String delyRegisterPost(HttpSession session, DeliveryVO dely, HttpServletResponse response, Model model){
        String userId = (String) session.getAttribute("userId");
        response.setContentType("text/html; charset=UTF-8");
        dely.setUserId(userId);

        int result = delyService.delyProc(dely);
        model.addAttribute("code", result);
        return "jsonView";
    }

    @GetMapping("/update")
    public String delyUpdateGet(DeliveryVO dely, Model model){
        model.addAttribute("dely", dely);
        return "updateDely";
    }

    @PostMapping("/update")
    public String delyUpdatePost(DeliveryVO dely0, String receiver1, String delyPlace1, String delyPhone1, String delyAddr1, HttpServletResponse response, Model model, HttpSession session){
        response.setContentType("text/html; charset=UTF-8");
        DeliveryVO dely1 = new DeliveryVO();
        dely0.setUserId((String) session.getAttribute("userId")); dely1.setReceiver(receiver1); dely1.setDelyPlace(delyPlace1); dely1.setDelyPhone(delyPhone1); dely1.setDelyAddr(delyAddr1);

        int result = delyService.updateDelivery(dely0, dely1);
        model.addAttribute("code",result);

       return "jsonView";
    }

    @PostMapping("/delete")
    public String delyDelete(DeliveryVO dely, Model model, HttpServletResponse response, HttpSession session){
        response.setContentType("text/html; charset=UTF-8");
        dely.setUserId((String) session.getAttribute("userId"));
        int result = delyService.deleteDelivery(dely);
        model.addAttribute("code", result);

        return "jsonView";
    }


    public LinkedList<DeliveryVO> BaseDelivery(LinkedList<DeliveryVO> list){
        int i = 0;
        for(;i<list.size();i++){
            if(list.get(i).getDelyNo()==1) {
                list.add(0, list.get(i));
                if(list.size() >=1) list.remove(i+1);
                break;
            }
        }
        return list;
    }
}
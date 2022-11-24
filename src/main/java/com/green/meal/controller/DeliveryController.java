package com.green.meal.controller;

import com.green.meal.domain.DeliveryVO;
import com.green.meal.service.DelyService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;


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

        model.addAttribute("realDely", list); // mapper용 찐 주소인 list

        for(int i=0 ; i<list.size(); i++){
            String[] addrArr = list.get(i).getDelyAddr().split("@");
            list.get(i).setDelyAddr(addrArr[1]+" "+addrArr[2]);
        }
        BaseDelivery(list);

        model.addAttribute("list",list);

        return "userInfo/delyForm";
    }

    @GetMapping("/register")
    public String delyRegisterGet(){
        return "userInfo/delyRegister";
    }

    @PostMapping
    public String countDelyPlace(HttpSession session, HttpServletResponse response, Model model){
        String userId = (String) session.getAttribute("userId");
        response.setContentType("text/html; charset=UTF-8");

        return "jsonView";
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

    @PostMapping("/register2")
    public String delyRegisterPost2(HttpSession session, HttpServletResponse response, Model model){
        String userId = (String) session.getAttribute("userId");
        response.setContentType("text/html; charset=UTF-8");

        int result = delyService.selectBase(userId);
        model.addAttribute("code", result);
        return "jsonView";
    }

    @GetMapping("/update")
    public String delyUpdateGet(DeliveryVO dely, Model model, HttpSession session){
        HashMap map = new HashMap();
        map.put("userId",session.getAttribute("userId"));
        map.put("delyPlace", dely.getDelyPlace());
        dely = delyService.selectedDely(map);
        model.addAttribute("dely", dely);
        String[] delyAddr = dely.getDelyAddr().split("@");

        model.addAttribute("zipNo", delyAddr[0]);
        model.addAttribute("roadAddrPart1", delyAddr[1]);
        model.addAttribute("addrDetail", delyAddr[2]);
        return "userInfo/updateDely";
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

    @PostMapping("/update2")
    public String delyUpdatePost2(HttpServletResponse response, Model model, HttpSession session){
        response.setContentType("text/html; charset=UTF-8");
        int result = delyService.updateDelivery2((String) session.getAttribute("userId"));
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
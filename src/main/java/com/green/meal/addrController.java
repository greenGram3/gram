package com.green.meal;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public class addrController {
    @RequestMapping("/addr")
        String addr(){
        return "addr";
    }
}

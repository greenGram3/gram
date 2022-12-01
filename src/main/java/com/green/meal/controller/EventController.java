package com.green.meal.controller;

import com.green.meal.domain.EventVO;
import com.green.meal.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {

    private final EventService eventService;

    @GetMapping()
    public String eventList(Model model){
        List<EventVO> list = eventService.selectEvent();
        model.addAttribute("list", list);
        return "eventList";
    }

}
package com.green.meal.controller;

import com.green.meal.domain.EventVO;
import com.green.meal.service.EventService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.List;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {
    private final EventService eventService;

    //이벤트 목록 페이지 이동
    @GetMapping("/list")
    public String eventList(String link,Model model){
        List<EventVO> list = eventService.selectEvent();
        model.addAttribute("link",link);
        model.addAttribute("list", list);
        return "/eventList";
    }

    // 디테일 페이지 이동
    @GetMapping()
    public String eventDetail(Integer eventNo, HttpSession session, Model model){

        String userId = (String)session.getAttribute("userId");
        log.info("userId={}",userId);
        EventVO eventVO = eventService.selectOne(eventNo);
        model.addAttribute("eventVO",eventVO);
        return "/eventDetail";
    }

    // 이벤트 등록 페이지 이동
    @GetMapping("/upload")
    public String uploadPage(){return "admin/eventForm";    }

    // 등록 버튼 눌러서 등록했을때
    @PostMapping("/upload")
    public String eventUpload(EventVO eventVO, HttpServletRequest request, Model model){
        // ** 이미지 업로드
        String realPath = request.getSession().getServletContext().getRealPath("/");
        realPath += "resources\\eventImage\\";

        MultipartFile fileName = eventVO.getFileName();

        try {
            fileName.transferTo(new File(realPath + fileName.getOriginalFilename()));
            eventVO.setImgPath("/eventImage/"+fileName.getOriginalFilename());
            eventService.insertEvent(eventVO);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("eventVO",eventVO);
            model.addAttribute("msg","SAVE_ERR");
            return "admin/eventForm";
        }




        return "redirect:/event/list?link=A";
    }

    // 수정 페이지로 이동
    @GetMapping("/modify")
    public String modifyPage(Integer eventNo, Model model){
        log.info("eventNo={}",eventNo);
        EventVO eventVO = eventService.selectOne(eventNo);
        MultipartFile fileName = eventVO.getFileName();
        log.info("fileName={}",fileName);
        model.addAttribute("eventVO",eventVO);
        return "admin/eventForm";
    }

    // 수정하기
    @PostMapping( "/modify")
    public String modify(EventVO eventVO , HttpServletRequest request, Model model){

        String realPath = request.getSession().getServletContext().getRealPath("/");
        realPath += "resources\\eventImage\\";
        MultipartFile fileName = eventVO.getFileName();
        try {
            if(!fileName.isEmpty()) {
                fileName.transferTo(new File(realPath + fileName.getOriginalFilename()));
                eventVO.setImgPath("/eventImage/"+fileName.getOriginalFilename());
            }
            eventService.updateEvent(eventVO);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("eventVO",eventVO);
            model.addAttribute("msg","MOD_ERR");
            return "admin/eventForm";
        }



        return "redirect:/event/list?link=A";
    }

    // 삭제하기
    @ResponseBody
    @DeleteMapping("/{eventNo}")
    public ResponseEntity<String> delete(@PathVariable Integer eventNo){
        try {
            eventService.deleteEvent(eventNo);
        }catch (Exception e){
            return new ResponseEntity<>("fail",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("ok",HttpStatus.OK);
    }


}
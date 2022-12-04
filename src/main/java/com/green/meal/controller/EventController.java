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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    public String eventList(String link, String msg, Model model, RedirectAttributes redirectAttributes){
        try {
            List<EventVO> list = eventService.selectEvent();
            model.addAttribute("link",link);
            redirectAttributes.addFlashAttribute("msg",msg);
            model.addAttribute("list", list);
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg", "LIST_ERR");
        }
        return "/eventList";
    }

    // 디테일 페이지 이동
    @GetMapping()
    public String eventDetail(Integer eventNo,String link, HttpSession session, Model model){
        try {
            EventVO eventVO = eventService.selectOne(eventNo);
            model.addAttribute("link",link);
            model.addAttribute("eventVO",eventVO);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "/eventDetail";
    }

    // 이벤트 등록 페이지 이동
    @GetMapping("/upload")
    public String uploadPage(){
        return "admin/eventForm";
    }

    // 등록 버튼 눌러서 등록했을때
    @PostMapping("/upload")
    public String eventUpload(EventVO eventVO, HttpServletRequest request, Model model,RedirectAttributes redirectAttributes){

        //이미지 저장할 폴더의 절대경로 얻기
        String realPath = request.getSession().getServletContext().getRealPath("/");
        try {
            if(eventService.insertEvent(eventVO, realPath) != 1)
                throw new Exception("save failed");
            redirectAttributes.addFlashAttribute("msg","SAVE_OK");
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("eventVO",eventVO);
            redirectAttributes.addFlashAttribute("msg","SAVE_ERR");
            return "admin/eventForm";
        }
        return "redirect:/event/list?link=A";
    }

    // 수정 페이지로 이동
    @GetMapping("/modify")
    public String modifyPage(Integer eventNo, Model model){

        try{
            EventVO eventVO = eventService.selectOne(eventNo);
            model.addAttribute("eventVO",eventVO);
            return "admin/eventForm";
        }catch (Exception e){
            e.printStackTrace();
            model.addAttribute("msg", "LIST_ERR");
            return "redirect:/event/list?link=A";
        }
    }

    // 수정하기
    @PostMapping( "/modify")
    public String modify(EventVO eventVO , HttpServletRequest request, Model model,RedirectAttributes redirectAttributes){
        //이미지 저장할 폴더의 절대경로 얻기
        String realPath = request.getSession().getServletContext().getRealPath("/");

        try {

            if(eventService.updateEvent(eventVO,realPath)!=1)
                throw new Exception("modify failed");
            redirectAttributes.addFlashAttribute("msg","MOD_OK");

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("eventVO",eventVO);
            redirectAttributes.addFlashAttribute("msg","MOD_ERR");
            return "admin/eventForm";
        }
        return "redirect:/event/list?link=A";
    }

    // 삭제하기
    @ResponseBody
    @DeleteMapping("/delete/{eventNo}")
    public ResponseEntity<String> delete(@PathVariable Integer eventNo){
        try {
            if(eventService.deleteEvent(eventNo)!= 1)
                throw new Exception("delete failed");
        }catch (Exception e){
            e.printStackTrace();
            return new ResponseEntity<>("fail",HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<>("ok",HttpStatus.OK);
    }


}
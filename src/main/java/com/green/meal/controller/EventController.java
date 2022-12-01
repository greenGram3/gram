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
import java.io.File;
import java.util.List;


@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/event")
public class EventController {
    private final EventService eventService;

    //이벤트 목록 페이지 이동
    @GetMapping("/list")
    public String eventList(Model model){
        List<EventVO> list = eventService.selectEvent();
        model.addAttribute("list", list);
        return "/eventList";
    }

    // 디테일 페이지 이동
    @GetMapping("/detail")
    public String eventDetail(Integer eventNo, Model model){
        EventVO eventVO = eventService.selectOne(eventNo);
        model.addAttribute("eventVO",eventVO);
        return "/eventDetail";
    }

    // 이벤트 등록 페이지 이동
    @GetMapping("/upload")
    public String uploadPage(){
        return "";
    }

    // 등록 버튼 눌러서 등록했을때
    @PostMapping()
    public String eventUpload(EventVO eventVO, HttpServletRequest request){
        // ** 이미지 업로드
        String realPath = request.getSession().getServletContext().getRealPath("/");
        realPath += "resources\\eventImage\\";

        MultipartFile fileName = eventVO.getFileName();

        try {
            fileName.transferTo(new File(realPath + fileName.getOriginalFilename()));
        } catch (Exception e) {
            e.printStackTrace();
        }

        eventVO.setImgPath("/itemImage/"+fileName.getOriginalFilename());

        eventService.insertEvent(eventVO);
        return "redirect:/event";
    }

    // 수정 페이지로 이동
    @GetMapping("/modify")
    public String modifyPage(){
        return "";
    }

    // 수정하기
    @PatchMapping(value = "/{eventNo}", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> modify(@PathVariable Integer eventNo, @RequestPart EventVO eventVO){
//        log.info("이름 : {}, 이미지 : {}",eventVO.getEventName(), imgFile);
        log.info("이름 : {}",eventVO.getEventName());

//        eventService.updateEvent(eventVO, eventNo);
        return new ResponseEntity<>("ok",HttpStatus.OK);
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
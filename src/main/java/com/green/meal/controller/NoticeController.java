package com.green.meal.controller;

import com.green.meal.domain.NoticeVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@Controller
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    //---------------------------------------------------------------------------------------------------------//
    @RequestMapping(value="/noticelist")
    public String noticelist (HttpServletRequest request, HttpServletResponse response, Model model,
                              SearchCriteria cri, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산

        List<NoticeVO> list = new ArrayList<NoticeVO>();
        list = noticeService.noticelist(cri); //search,Paging적용한 매서드 실행
        if(list != null) {
            model.addAttribute("noticeResult", list);
        } else {
            model.addAttribute("message", "출력 가능한 자료가 없습니다.");
        }

        pageMaker.setCri(cri);
        pageMaker.setTotalRowsCount(noticeService.searchCount(cri));
        model.addAttribute("pageMaker",pageMaker);

        return "/notice/noticeList";
    }

    //---------------------------------------------------------------------------------------------------------//

    @RequestMapping(value="/noticedetail")
    public String noticedetail (HttpServletRequest request, HttpServletResponse response, Model model, NoticeVO vo) {
        NoticeVO voRe;
        // 1. 성공 시 detail폼
        String uri = "/notice/noticeDetail";

        // 2. detail 실행, 저장
        voRe = noticeService.noticedetail(vo);

        if( voRe != null ) { //detail 저장 성공이면

            if("U".equals(request.getParameter("jCode"))) { //수정요청이면 수정폼으로
                uri = "/notice/noticeUpdate";
            }
            model.addAttribute("noticeResult",voRe);
        } else { //저장 실패 error면
            model.addAttribute("message","자료를 불러오는 데 실패했습니다.");
            uri = "redirect:noticelist";
        }
        return uri;
    }

    //---------------------------------------------------------------------------------------------------------//

    @RequestMapping(value = "/noticeinsertf")
    public String noticeinsertf(HttpServletRequest request, HttpServletResponse response) {
        return "/notice/noticeInsert";
    }

    @RequestMapping(value = "/noticeinsert", method= RequestMethod.POST)
    public String noticeinsert(HttpServletRequest request, HttpServletResponse response, NoticeVO vo, Model model, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri = "redirect:noticelist";

        // 2. service 처리
        if (noticeService.noticeinsert(vo)>0) { //인서트 성공
            rttr.addFlashAttribute("message","공지 등록 성공");
        } else {
            model.addAttribute("message","공지 등록 실패. 다시하시기 바랍니다.");
            uri = "/notice/noticeInsert";
        }

        return uri;
    }

    //---------------------------------------------------------------------------------------------------------//

    @RequestMapping(value = "/noticeupdate", method=RequestMethod.POST)
    public String noticeupdate(HttpServletRequest request, HttpServletResponse response, NoticeVO vo, Model model) {
        // 1. 요청분석
        String uri = "/notice/noticeDetail"; //성공 시 디테일 폼
        model.addAttribute("noticeResult",vo); //업뎃 실패시에도 값 저장

        // 2. service 처리
        if(noticeService.noticeupdate(vo)>0) {
            model.addAttribute("message","공지 수정 성공");
        } else {
            model.addAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
            uri = "/notice/noticeUpdate";
        }
        return uri;
    }

    //---------------------------------------------------------------------------------------------------------//
    @RequestMapping(value="noticedelete")
    public String noticedelete(HttpServletRequest request, HttpServletResponse response,
                               NoticeVO vo, Model model, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri ="redirect:noticelist";

        // 2. service처리
        if (noticeService.noticedelete(vo)>0) {
            rttr.addFlashAttribute("message","공지 삭제 성공");
        } else {
            rttr.addFlashAttribute("message","삭제 실패. 다시 시도하시기 바랍니다.");
            uri ="redirect:noticedetail?noticeNo="+vo.getNoticeNo();
        }
        return uri;
    }

} //Controller class

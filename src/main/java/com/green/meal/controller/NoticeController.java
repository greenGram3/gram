package com.green.meal.controller;

import com.green.meal.domain.NoticeVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
    public String noticelist (Model model, SearchCriteria cri,String link, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산
        if(link != null){
            model.addAttribute("link",link);
        }

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
    public String noticedetail (String link,HttpServletRequest request, Model model, NoticeVO vo) {
        NoticeVO voRe;

        if(link != null){
            model.addAttribute("link",link);
        }

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
    public String noticeinsertf(String link, Model model) {
        if(link != null){
            model.addAttribute("link",link);
        }
        return "/notice/noticeInsert";
    }

    @RequestMapping(value = "/noticeinsert", method= RequestMethod.POST)
    public String noticeinsert(NoticeVO vo, @RequestBody String link, Model model, RedirectAttributes rttr) {
        String link2 = null;
        if(link != null){
            int index = link.length();
            link2 = link.substring(index - 1);
            model.addAttribute("link",link2);
        }
        // 1. 요청분석
        String uri = "redirect:noticelist?link="+link2;
        // 2. service 처리
        if (noticeService.noticeinsert(vo)>0) { //인서트 성공
            rttr.addFlashAttribute("message","공지 등록 성공");
        } else {
            model.addAttribute("message","공지 등록 실패. 다시하시기 바랍니다.");
            uri = "/notice/noticeInsert?link="+link2;
        }

        return uri;
    }

    //---------------------------------------------------------------------------------------------------------//

    @RequestMapping(value = "/noticeupdate", method=RequestMethod.POST)
    public String noticeupdate(@RequestBody String link, NoticeVO vo, Model model) {
        // 1. 요청분석
        String uri = "/notice/noticeDetail";
        if(link != null){
            int index = link.length();
            String link2 = link.substring(index - 1);
            model.addAttribute("link",link2);
            System.out.println("link2 = " + link2);
        }
        // 2. service 처리
        if(noticeService.noticeupdate(vo)>0) {
            model.addAttribute("noticeResult",noticeService.noticedetail(vo));
            model.addAttribute("message","공지 수정 성공");
        } else {
            model.addAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
            uri = "/notice/noticeUpdate?link="+link;
        }
        return uri;
    }

    //---------------------------------------------------------------------------------------------------------//
    @RequestMapping(value="noticedelete")
    public String noticedelete(NoticeVO vo, String link, RedirectAttributes rttr) {
        System.out.println("link:"+link);
        // 1. 요청분석
        String uri ="redirect:noticelist?link="+link;

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

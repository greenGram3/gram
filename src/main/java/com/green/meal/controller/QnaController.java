package com.green.meal.controller;

import com.green.meal.domain.QnaVO;
import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class QnaController {

    @Autowired
    QnaService qnaService;

    // ** QnA List
    @RequestMapping(value="/qnalist")
    public String qnalist(HttpServletRequest request, HttpServletResponse response, Model model,
                          QnaVO vo, SearchCriteria cri, String link, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산
        if(link != null){
            model.addAttribute("link",link);
        }
        // 1. 요청분석
        List<QnaVO> list = new ArrayList<QnaVO>(); // 결과 담을 list
        String uri = "/qna/qnaList"; //성공 시 list로
        HttpSession session = request.getSession(false); //session 가져오기
        String userId = (String)session.getAttribute("userId"); //session의 userID 가져오기

        // 1) userId가 null은 로그인X -> 로그인창으로
        if (userId == null) {
            model.addAttribute("message","로그인 하세요.");
            uri = "userInfo/loginForm";
        } else { // 2) userId != null은 로그인O
                list = qnaService.qnalistAll(cri); // 3) qna list 담기
                if( list!=null ) {
                    model.addAttribute("qnaResult",list);
                } else {
                    model.addAttribute("message","QnA가 없습니다.");
                }
            model.addAttribute("userId", userId);
            model.addAttribute("qnaRoot", vo.getQnaRoot());

            pageMaker.setCri(cri);
            pageMaker.setTotalRowsCount(qnaService.searchCount(cri));
            model.addAttribute("pageMaker",pageMaker);
            }

        return uri;
    } // qnalist

    // -----------------------------------------------------------------------------------------//
    // ** QnA 작성
    @RequestMapping(value="/qnainsertf")
    public String qnainsertf(HttpServletRequest request, HttpServletResponse response,String link, Model model) {
        if(link != null){
            model.addAttribute("link",link);
        }

        return "/qna/qnaInsert";
    }

    @RequestMapping(value="/qnainsert", method = RequestMethod.POST)
    public String qnainsert(QnaVO vo, Model model, String link, HttpServletResponse response) {
        response.setContentType("text/html; charset=UTF-8");

        Integer index = link.length();
        String link2 = link.substring(index - 1);

        // 1. service 처리
        if (qnaService.qnainsert(vo)>0) { //인서트 성공
            model.addAttribute("code","200");
            if(link != null){
                model.addAttribute("link",link2);
            }
        } else {
            model.addAttribute("code","500");
            model.addAttribute("message","QnA Insert 오류. 다시 시도 하시기 바랍니다.");
        }
        return "jsonView";
    }
    // -----------------------------------------------------------------------------------------//
    // ** QnA Detail
    @RequestMapping(value="/qnadetail")
    public String qnadetail (HttpServletRequest request, HttpServletResponse response, Model model, QnaVO vo,String link) {

        if(link != null){
            model.addAttribute("link",link);
        }
        QnaVO voRe;
        // 1. 성공 시 detail폼
        String uri = "/qna/qnaDetail";

        // 2. detail 실행, 저장
        voRe = qnaService.qnadetail(vo);

        if( voRe != null ) { //detail 저장 성공이면

            if("U".equals(request.getParameter("jCode"))) { //수정요청이면 수정폼으로
                uri = "/qna/qnaUpdate";
            }
            model.addAttribute("qnaResult",voRe);
        } else { //저장 실패 error면
            model.addAttribute("message","자료를 불러오는 데 실패했습니다.");

            uri = "redirect:qnalist";
        }
        return uri;
    }

    // -----------------------------------------------------------------------------------------//
    // ** QnA Update
    @RequestMapping(value = "/qnaupdate", method=RequestMethod.POST)
    public String qnaupdate(HttpServletRequest request, HttpServletResponse response, QnaVO vo, Model model,@RequestBody String link) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");

        Integer index = link.length();
        String link2 = link.substring(index - 1);

        System.out.println("link2 = " + link2);

        if(link != null){
            model.addAttribute("link",link2);
        }
        // 1. 요청분석
        model.addAttribute("qnaResult",vo); //업뎃 실패시에도 값 저장

        // 2. service 처리
        if(qnaService.qnaupdate(vo)>0) {
            model.addAttribute("code","200");
        } else {
            model.addAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
            model.addAttribute("code","500");
        }

        return "jsonView";
    }
    // -----------------------------------------------------------------------------------------//
    // ** QnA Delete
    @RequestMapping(value="qnadelete")
    public String qnadelete(HttpServletRequest request, HttpServletResponse response,
                               QnaVO vo, String link, Model model, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri ="redirect:qnalist?link="+link;
        if(link != null){
            model.addAttribute("link",link);
        }
        // 2. service처리
        if (qnaService.qnadelete(vo)>0) {
            rttr.addFlashAttribute("message","문의 삭제 성공");
        } else {
            rttr.addFlashAttribute("message","삭제 실패. 다시 시도하시기 바랍니다.");
            uri ="redirect:qnadetail?qnaNo="+vo.getQnaNo()+"&link="+link;
        }
        return uri;
    }
    // -----------------------------------------------------------------------------------------//
    // ** QnA reply insert
    @RequestMapping(value="/qnarinsertf")
    public String qnarinsertf(Model model,String link, QnaVO vo) {
        if(link != null){
            model.addAttribute("link",link);
        }
        System.out.println("link = " + link);
        return "/qna/qnarInsert";
    }

    @RequestMapping(value="/qnarinsert", method=RequestMethod.POST)
    public String qnarinsert(HttpServletResponse response, Model model, QnaVO vo) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");

        // 1. 요청분석
        vo.setQnaStep(vo.getQnaStep()+1);
        vo.setQnaChild(vo.getQnaChild()+1);

        // 2. Service 처리
        if ( qnaService.qnarinsert(vo)>0 ) {
            model.addAttribute("code","200");
        }else {
            model.addAttribute("code","500");
            model.addAttribute("message","답변 등록에 실패했습니다.");
        }
        return "jsonView";
    }
    // -----------------------------------------------------------------------------------------//
    // ** QnA Reply Detail
    @RequestMapping(value="/qnarDetail")
    public String qnarDetail(HttpServletRequest request,String link, HttpServletResponse response, Model model, QnaVO vo) {
        // 1. 성공 시 detail폼
        String uri = "/qna/qnaRdetail";
        if(link != null){
            model.addAttribute("link",link);
        }
        // session에서 userId받아 전달 => 관리자만 수정, 삭제 가능하게
        String userId = (String)request.getSession().getAttribute("userId"); //session의 userID 가져오기
        model.addAttribute("userId",userId);

        // 2. detail 실행, 저장
        vo = qnaService.qnarDetail(vo);

        if( vo != null ) { //detail 저장 성공이면
            model.addAttribute("qnaResult",vo);
        } else { //저장 실패 error면
            model.addAttribute("message","자료를 불러오는 데 실패했습니다.");
            uri="redirect:qnadetail?qnaNo="+vo.getQnaNo();
        }
        return uri;
    }

    // -----------------------------------------------------------------------------------------//
    // ** QnA 답변 업데이트 폼(팝업) 띄우기
    @RequestMapping(value="/qnarupdatef")
    public String qnarupdatef(QnaVO vo, Model model) {
        vo.setUserId(vo.getUserId());
        vo.setQnaNo(vo.getQnaNo());

        model.addAttribute("qnaResult",vo);

        return "/qna/qnaRupdate";
    }

    // ** QnA 답변 업데이트하기(JSON)
    @RequestMapping(value="/qnarupdate", method= RequestMethod.POST)
    public String qnarupdate(HttpServletResponse response, Model model, QnaVO vo, HttpServletRequest request) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");

        // 1. 요청분석
        model.addAttribute("qnaResult",vo);

        // 2. service 처리
        if(qnaService.qnaupdate(vo) > 0) {
            model.addAttribute("code","200");
        } else {
            model.addAttribute("code","500");
        }
        return "jsonView";
    }

} //qnaController

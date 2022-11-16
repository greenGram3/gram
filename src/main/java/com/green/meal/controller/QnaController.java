package com.green.meal.controller;

import com.green.meal.domain.QnaVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.QnaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
                          QnaVO vo, SearchCriteria cri, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산

        // 1. 요청분석
        List<QnaVO> list = new ArrayList<QnaVO>(); // 결과 담을 list
        String uri = "/qna/qnaList"; //성공 시 list로
        HttpSession session = request.getSession(false); //session 가져오기
        String userId = (String)session.getAttribute("userId"); //session의 userID 가져오기

        // 1) userId가 null은 로그인X -> 로그인창으로
        if (userId == null) {
            model.addAttribute("message","로그인 하세요.");
            uri = "loginForm";
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

    @RequestMapping(value="/qnalistM")
    public String qnalistM(HttpServletRequest request, HttpServletResponse response, Model model,
                          QnaVO vo, SearchCriteria cri, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산


        // 1. 요청분석
        List<QnaVO> list = new ArrayList<QnaVO>(); // 결과 담을 list
        String uri = "/qna/qnaListM"; //성공 시 list로
        HttpSession session = request.getSession(false); //session 가져오기
        String userId = (String)session.getAttribute("userId"); //session의 userID 가져오기

        // 1) userId가 null은 로그인X -> 로그인창으로
        if (userId == null) {
            model.addAttribute("message","로그인 하세요.");
            uri = "loginForm";
        } else { // 2) userId != null은 로그인O
            list = qnaService.qnalistAll(cri); // 3) qna list 담기
            if( list!=null ) {
                model.addAttribute("qnaResult",list);
            } else {
                model.addAttribute("message","QnA가 없습니다.");
            }
            model.addAttribute("userId", userId);
            model.addAttribute("qnaRoot", vo.getQnaRoot());
            String link="M";
            model.addAttribute("link",link);
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
    public String qnainsert(HttpServletRequest request, HttpServletResponse response, QnaVO vo,
                            Model model, String link, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri = "redirect:qnalist"+link;

        if(link != null){
            model.addAttribute("link",link);
        }

        // 2. service 처리
        if (qnaService.qnainsert(vo)>0) { //인서트 성공
            rttr.addFlashAttribute("message","문의 등록 성공");
        } else {
            model.addAttribute("message","문의 등록 실패. 다시하시기 바랍니다.");
            uri = "/qna/qnaInsert";
        }
        return uri;
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

            uri = "redirect:qnalist"+link;
        }
        return uri;
    }

    // -----------------------------------------------------------------------------------------//
    // ** QnA Update
    @RequestMapping(value = "/qnaupdate", method=RequestMethod.POST)
    public String qnaupdate(HttpServletRequest request, HttpServletResponse response, QnaVO vo, Model model,String link) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");


        if(link != null){
            model.addAttribute("link",link);
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
        String uri ="redirect:qnalist"+link;

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
    public String qnarinsertf(HttpServletRequest request, HttpServletResponse response,
                                 Model model,String link, QnaVO vo) { //vo에 detail의 root 담김
        if(link != null){
            model.addAttribute("link",link);
        }

        return "/qna/qnarInsert";
    }

    @RequestMapping(value="/qnarinsert", method=RequestMethod.POST)
    public String qnarinsert(HttpServletRequest request, HttpServletResponse response,
                                Model model, QnaVO vo, RedirectAttributes rttr) {
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
    public String qnarDetail(HttpServletRequest request, HttpServletResponse response, Model model, QnaVO vo) {
        // 1. 성공 시 detail폼
        String uri = "/qna/qnaRdetail";

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
} //qnaController

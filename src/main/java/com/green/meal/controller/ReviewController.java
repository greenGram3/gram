package com.green.meal.controller;

import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ReviewController {

    @Autowired
    ReviewService reviewService;

    // ** 상세페이지 리뷰리스트
    @RequestMapping(value="/reviewlistD")
    public String reviewlistD(Model model, SearchCriteria cri, PageMaker pageMaker, ReviewVO vo) {
        cri.setSnoEno(); //Sno, Eno 계산

        List<ReviewVO> list = new ArrayList<ReviewVO>();
        list = reviewService.reviewlistD(cri, vo);

        if (list!=null) {
            model.addAttribute("reviewResult", list);

            pageMaker.setCri(cri);
            pageMaker.setTotalRowsCount(reviewService.searchCount3(vo));
            model.addAttribute("pageMaker",pageMaker);

        } else {
            model.addAttribute("message", "아직 후기가 없습니다.");
        }

        return "/review/reviewListD";
    }
    //-------------------------------------------------------------------------------------------------//
    // ** ReviewList 출력
    @RequestMapping(value="/reviewlist")
    public String reviewlist (Model model, SearchCriteria cri, String link, PageMaker pageMaker) {
        cri.setSnoEno();
        if(link != null){
            model.addAttribute("link",link);
        }
        List<ReviewVO> list = new ArrayList<ReviewVO>();
        list = reviewService.reviewlist(cri);

        if(list != null) {
            model.addAttribute("reviewResult", list);
        } else {
            model.addAttribute("message", "아직 후기가 없습니다.");
        }
        pageMaker.setCri(cri);
        pageMaker.setTotalRowsCount(reviewService.searchCount(cri));
        model.addAttribute("pageMaker",pageMaker);

        return "/review/reviewList";
    }
    //------------------------------------------------------------------------------------------------------//
    // ** ReviewContent Detail 출력(Json)
    @RequestMapping(value="/reviewDetailD")
    public String reviewDetailD(HttpServletResponse response, Model model, ReviewVO vo) {
        response.setContentType("text/html; charset=UTF-8");

        vo = reviewService.reviewdetail(vo);
        model.addAttribute("reviewContent", vo.getReviewContent());
        return "jsonView";
    }
    //------------------------------------------------------------------------------------------------------//
    // ** ReviewDetail 출력
    @RequestMapping(value="/reviewdetail")
    public String reviewdetail(HttpServletRequest request, Model model, ReviewVO vo) {
        ReviewVO voRe;
        // 1. 성공 시 detail폼
        String uri = "/review/reviewDetail";

        // 2. detail 실행, 저장
        voRe = reviewService.reviewdetail(vo);

        if( voRe != null ) { //detail 저장 성공이면

            if("U".equals(request.getParameter("jCode"))) { //수정요청이면 수정폼으로
                uri = "/review/reviewUpdate";
            }
            model.addAttribute("reviewResult",voRe);
        } else { //저장 실패 error면
            model.addAttribute("message","후기를 불러오는데 실패했습니다.");
            uri = "redirect:reviewlist";
        }
        return uri;
    }
    //------------------------------------------------------------------------------------------------------//
    // ** Review 작성
    @RequestMapping(value="/reviewinsertf")
    public String reviewinsertf (ReviewVO vo, HttpServletResponse response) throws IOException {
        System.out.println("itemNo: "+vo.getItemNo()+","+"orderNo: "+vo.getOrderNo());
        response.setContentType("text/html; charset=UTF-8"); //response 한글

        PrintWriter out = response.getWriter();

        // Review 중복체크
        if (reviewService.dupCheck(vo)!=null) { //후기 중복
            out.println("<script>alert('후기는 한번만 작성가능합니다.'); " +
                    "history.back(); </script>");
            out.flush();
            return null;
        } else { //중복X, 작성가능
            return "/review/reviewInsert";
        }
    }
    //------------------------------------------------------------------------------------------------------//
    // ** 후기 insert(+이미지까지)
    @RequestMapping(value="/reviewinsert", method= RequestMethod.POST)
    public String reviewinsert(HttpServletRequest request, Model model,
                               ReviewVO vo, RedirectAttributes rttr) throws IOException {
        String uri = "redirect:reviewlist"; // uri경로
//------------------------------------------------------------------------//
        String realPath = request.getSession().getServletContext().getRealPath("/");
        System.out.println("** realPath => "+realPath);

        realPath += "resources\\reviewImage\\"; // 실제 폴더 저장위치
        String file1, file2="reviewImage/noImage.JPG"; // 기본 이미지 지정

        // ** MultipartFile
        MultipartFile imgNamef = vo.getImgNamef();
        if ( imgNamef !=null && !imgNamef.isEmpty() ) {
            file1 = realPath + imgNamef.getOriginalFilename();
            imgNamef.transferTo(new File(file1));
            file2="reviewImage/"+imgNamef.getOriginalFilename();
        }
        vo.setImgName(file2);
//-----------------------------------------------------------------------------//
        // Service 처리
        if ( reviewService.reviewinsert(vo)>0 ) {
            rttr.addFlashAttribute("message","후기가 등록되었습니다.");
        }else {
            model.addAttribute("message","후기 등록 실패. 다시 이용하시기 바랍니다.");
            uri = "/review/reviewInsert";
        }
        return uri;
    }
    //------------------------------------------------------------------------------------------------------//
    // Review 답변
    @RequestMapping(value="/reviewrinsertf")
    public String reviewrinsertf() {
        return "/review/reviewrInsert";
    }

    @RequestMapping(value="/reviewrinsert", method = RequestMethod.POST)
    public String reviewrinsert(HttpServletResponse response, Model model, ReviewVO vo) {
        response.setContentType("text/html; charset=UTF-8");

        vo.setReviewStep(vo.getReviewStep()+1); // 답글 DB입력 위해 step,child +1 set
        vo.setReviewChild(vo.getReviewChild()+1);

        // Service 처리
        if ( reviewService.reviewrinsert(vo)>0 ) { //성공
            model.addAttribute("code","200");
        } else { //실패
            model.addAttribute("code","500");
            model.addAttribute("message","답변 등록에 실패했습니다.");
        }
        return "jsonView";
    }
    //------------------------------------------------------------------------------------------------------//
    // ** Review Update
    @RequestMapping(value="/reviewupdate", method = RequestMethod.POST)
    public String reviewupdate(HttpServletRequest request, Model model, ReviewVO vo) throws IOException {
        // 1. 요청분석
        String uri = "redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        model.addAttribute("reviewResult",vo); //업뎃 실패시에도 값 저장
        // 이미지 저장
            String realPath = request.getSession().getServletContext().getRealPath("/");
            System.out.println("** realPath => "+realPath);
            // 실제 폴더 저장 위치
            realPath += "resources\\reviewImage\\";
            // ** 기본 이미지 지정하기
            String file1, file2="reviewImage/noImage.JPG";
            // ** MultipartFile
            MultipartFile imgNamef = vo.getImgNamef();

            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                // 1) 물리적 저장경로에 Image저장
                file1 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file1));
                // 2) Table 저장
                file2="reviewImage/"+imgNamef.getOriginalFilename();
                vo.setImgName(file2);
            }
        // 2. service처리
        if(reviewService.reviewupdate(vo)>0) {
            model.addAttribute("message","수정 성공");
        } else {
            model.addAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
        }
        return uri;
    }
    //------------------------------------------------------------------------------------------------------//
    // ** Review Delete
    @RequestMapping(value="reviewdelete")
    public String reviewdelete( ReviewVO vo, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri ="redirect:reviewlist";

        // 2. service처리
        if (reviewService.reviewdelete(vo)>0) {
            rttr.addFlashAttribute("message","후기 삭제 성공");
        } else {
            rttr.addFlashAttribute("message","삭제 실패. 다시 시도하시기 바랍니다.");
            uri ="redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        }
        return uri;
    }

    //-------------------------------------------------------------------------------------------------//
    // ** Review Reply Detail 출력
    // ** ReviewDetail 출력
    @RequestMapping(value="/reviewrDetail")
    public String reviewrDetail(Model model, ReviewVO vo) {
        // 1. 요청분석
        String uri = "/review/reviewRdetail";
        // 2. 디테일 실행, 저장
        vo = reviewService.reviewrDetail(vo);

        if( vo != null ) { //성공
            model.addAttribute("reviewResult",vo);
        } else { //실패
            model.addAttribute("message","후기를 불러오는데 실패했습니다.");
            uri="redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        }
        return uri;
    }

    // ** MyPage reviewList
    @RequestMapping(value="/reviewlistM")
    public String reviewlistM(HttpServletRequest request, SearchCriteria cri, Model model, PageMaker pageMaker) {
        // 1. 요청분석
        String uri = "/review/reviewListM";
        String userId = null;

        // 2. session의 userId 받아서 저장
        HttpSession session = request.getSession(false);
        if ((session.getAttribute("userId"))!=null ) {
            userId = (String)(session.getAttribute("userId"));
        }
        // 3. paging cri 기초 계산
        cri.setSnoEno(); //Sno, Eno 계산

        // 4. service 실행 & 담기
        List<ReviewVO> list = new ArrayList<ReviewVO>();
        list = reviewService.reviewlistM(cri, userId);

        if(list != null) {
            model.addAttribute("reviewResult", list);
            pageMaker.setCri(cri);
            pageMaker.setTotalRowsCount(reviewService.searchCount2(userId));
            model.addAttribute("pageMaker",pageMaker);
        } else {
            model.addAttribute("message", "작성한 후기가 없습니다.");
            uri = "redirect:home";
        }
        return uri;
    }
    //---------------------------------------------------------------------------------//
    // ** review 답변 업데이트 폼 띄우기
    @RequestMapping(value="/reviewrupdatef")
    public String reviewrupdatef(ReviewVO vo, Model model) {
        vo.setUserId(vo.getUserId());
        vo.setReviewNo(vo.getReviewNo());

        model.addAttribute("reviewResult",vo);

        return "/review/reviewRupdate";
    }

    // ** review 답변 업데이트 하기
    @RequestMapping(value="/reviewrupdate", method= RequestMethod.POST)
    public String reviewrupdate(HttpServletResponse response, Model model, ReviewVO vo) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");

        // 1. 요청분석
        model.addAttribute("reviewResult",vo); //업뎃 실패시에도 값 저장

        // 2. service 처리
        if(reviewService.reviewRupdate(vo)>0) {
            model.addAttribute("code","200");
        } else {
            model.addAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
            model.addAttribute("code","500");
        }
        return "jsonView";
    }

    //---------------------------------------------------------------------------------------------//
    // ** Review Dup Check(답변 중복체크-보류)
/*    @RequestMapping(value="/reviewDupCheck")
    public String qnaDupCheck(ReviewVO vo, Model model) {
        System.out.println("reviewRoot: "+vo.getReviewRoot());

        if (reviewService.reviewrDetail(vo) != null) { //답글 있음
            model.addAttribute("code","200");
        } else { //답글 없음
            model.addAttribute("code","500");
        }
        return "jsonView";
    }*/
} //Controller

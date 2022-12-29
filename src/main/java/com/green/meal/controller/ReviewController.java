package com.green.meal.controller;

import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.ItemService;
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

    // 22.12.29 - git bash Test

    // ** 상세페이지 리뷰리스트
    @RequestMapping(value="/itemReview")
    public String itemReview(Model model, SearchCriteria cri, PageMaker pageMaker, ReviewVO vo) {
        try {
            // 1) 현재페이지 시작 data row 계산
            cri.setSnoEno();
            // 2) 매서드 실행 결과 담을 List 생성
            List<ReviewVO> list = new ArrayList<ReviewVO>();
            // 3) itemReview select 매서드 실행(매개변수: 페이징, itemNo) => Mapper.xml
            list = reviewService.itemReview(cri, vo);

            if (list!=null) { //4) 실행결과 후기 있을 시
                //5) list 결과 model에 저장
                model.addAttribute("reviewResult", list);
                //6) 페이징(하단 페이지 수, 결과 row 수 count)
                pageMaker.setCri(cri);
                pageMaker.setTotalRowsCount(reviewService.searchCount3(vo));
                //7) 페이징 결과 model에 저장
                model.addAttribute("pageMaker",pageMaker);
            } else {
                model.addAttribute("message", "아직 후기가 없습니다.");
            }
        } catch (Exception e) {
            //8) Exception발생 시 원인파악
            e.printStackTrace();
        }
        return "/review/itemReview";
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
        // itemNo, orderNo 확인
        System.out.println("itemNo: "+vo.getItemNo()+","+"orderNo: "+vo.getOrderNo());

        // 요청분석
        response.setContentType("text/html; charset=UTF-8"); //response 한글
        PrintWriter out = response.getWriter();

        // Review 중복체크
        if (reviewService.dupCheck(vo)!=null) { //후기 중복인 경우
            out.println("<script>alert('후기는 한번만 작성가능합니다.'); " +
                    "history.back(); </script>");
            out.flush(); //alert 띄우고 돌아가기
            return null;
        } else { //중복X, 작성가능 => insertForm으로 이동
            return "/review/reviewInsert";
        }
    }
    //------------------------------------------------------------------------------------------------------//
    // ** 후기 insert(+이미지까지)
    @RequestMapping(value="/reviewinsert", method= RequestMethod.POST)
    public String reviewinsert(HttpServletRequest request, Model model,
                               ReviewVO vo, RedirectAttributes rttr) throws IOException {
        try {
            // 이미지 저장
            String realPath = request.getSession().getServletContext().getRealPath("/");
            System.out.println("** realPath => "+realPath);
            realPath += "resources\\reviewImage\\";
            String file1, file2="reviewImage/noImage.JPG";

            // ** MultipartFile
            MultipartFile imgNamef = vo.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                file1 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file1));
                file2="reviewImage/"+imgNamef.getOriginalFilename();
            }
            vo.setImgName(file2);

            // Service 실행
            reviewService.reviewinsert(vo);
            rttr.addFlashAttribute("message","후기가 등록되었습니다.");
            return "redirect:myReview";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("message","후기 등록 실패. 다시 이용하시기 바랍니다.");
            return "/review/reviewInsert";
        }
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
    public String reviewupdate(HttpServletRequest request, Model model,
                               ReviewVO vo, RedirectAttributes rttr) throws IOException {
        try {
            model.addAttribute("reviewResult",vo);
            // 이미지 저장
            String realPath = request.getSession().getServletContext().getRealPath("/");
            System.out.println("** realPath => "+realPath);
            realPath += "resources\\reviewImage\\";
            String file1, file2;

            // ** MultipartFile
            MultipartFile imgNamef = vo.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                file1 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file1));
                file2="reviewImage/"+imgNamef.getOriginalFilename();
                vo.setImgName(file2);
            }
            // 2. service처리
            reviewService.reviewupdate(vo);
            rttr.addFlashAttribute("message","수정 성공");
            return "redirect:reviewdetail?reviewNo="+vo.getReviewNo();

        } catch (Exception e) {
            e.printStackTrace();
            rttr.addFlashAttribute("message","수정 실패. 다시 시도하시기 바랍니다.");
            return "redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        }
    }
    //------------------------------------------------------------------------------------------------------//
    // ** Review Delete
    @RequestMapping(value="reviewdelete")
    public String reviewdelete( ReviewVO vo, HttpServletRequest request, RedirectAttributes rttr) {
        // 1. 요청분석
        String uri = "";
        if("admin".equals(request.getSession().getAttribute("userId"))) {
            uri = "redirect:reviewlist";
        } else {
            uri = "redirect:myReview";
        }
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
    @RequestMapping(value="/myReview")
    public String myReview(HttpServletRequest request, SearchCriteria cri, Model model, PageMaker pageMaker) {
        // 1. 요청분석
        String uri = "/review/myReview";
        String userId = null;

        // 2. session의 userId(매개변수로 활용)
        HttpSession session = request.getSession(false);
        if ((session.getAttribute("userId"))!=null ) {
            userId = (String)(session.getAttribute("userId"));
        }
        // 3. paging cri 기초 계산
        cri.setSnoEno(); //Sno, Eno 계산

        // 4. service 실행 & 담기
        List<ReviewVO> list = new ArrayList<ReviewVO>();
        list = reviewService.myReview(cri, userId);

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
} //Controller

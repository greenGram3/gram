package com.green.meal.controller;

import com.green.meal.domain.QnaVO;
import com.green.meal.domain.ReviewVO;
import com.green.meal.paging.PageMaker;
import com.green.meal.paging.SearchCriteria;
import com.green.meal.service.ReviewService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ReviewController {

    @Autowired
    ReviewService reviewService;

    // ** 상세페이지 리뷰리스트
    @RequestMapping(value="/reviewlistD")
    public String reviewlistD(HttpServletRequest request, HttpServletResponse response,
                              Model model, SearchCriteria cri, PageMaker pageMaker, ReviewVO vo) {
        cri.setSnoEno(); //Sno, Eno 계산

        List<ReviewVO> list = new ArrayList<ReviewVO>();
        list = reviewService.reviewlistD(cri, vo);

        if (list!=null) {
            model.addAttribute("reviewResult", list);

            pageMaker.setCri(cri);
            pageMaker.setTotalRowsCount(reviewService.searchCount(cri));
            model.addAttribute("pageMaker",pageMaker);

        } else {
            model.addAttribute("message", "아직 후기가 없습니다.");
        }

        return "/review/reviewListD";
    }

    //-------------------------------------------------------------------------------------------------//
    // ** ReviewList 출력
    @RequestMapping(value="/reviewlist")
    public String reviewlist (HttpServletRequest request, HttpServletResponse response, Model model,
                              SearchCriteria cri, PageMaker pageMaker) {
        cri.setSnoEno(); //Sno, Eno 계산

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
    public String reviewDetailD(HttpServletRequest request, HttpServletResponse response, Model model, ReviewVO vo) {
        ReviewVO voRe;
        response.setContentType("text/html; charset=UTF-8");

        voRe = reviewService.reviewdetail(vo);

        model.addAttribute("reviewContent", voRe.getReviewContent());
        return "jsonView";
    }
    //------------------------------------------------------------------------------------------------------//
    // ** ReviewDetail 출력
    @RequestMapping(value="/reviewdetail")
    public String reviewdetail(HttpServletRequest request, HttpServletResponse response, Model model, ReviewVO vo) {
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
    public String reviewinsertf(HttpServletRequest request, HttpServletResponse response, ReviewVO vo, Model model) {
        return "/review/reviewInsert";
    }

    //------------------------------------------------------------------------------------------------------//
    // ** 후기 insert(+이미지까지)
    @RequestMapping(value="/reviewinsert", method= RequestMethod.POST)
    public String reviewinsert(HttpServletRequest request, HttpServletResponse response,
                             Model model, ReviewVO vo) throws IOException {
        // 1. 요청분석
        String uri = "redirect:reviewlist";

//------------------------------------------------------------------------//
        String realPath = request.getRealPath("/");
        System.out.println("** realPath => "+realPath);

        // 2) 위 값을 이용해서 실제저장위치 확인
        realPath = "C:\\Users\\Eom hee jeong\\IdeaProjects\\gram\\src\\main\\webapp\\resources\\reviewImage\\";

        // ** 기본 이미지 지정하기
        String file1, file2="reviewImage/noImage.JPG";

        // ** MultipartFile
        MultipartFile imgNamef = vo.getImgNamef();//이미지정보들 모두 들어있음.
        if ( imgNamef !=null && !imgNamef.isEmpty() ) {//이미지 첨부하고 이미지정보도 있는 경우
            // ** Image를 선택 -> Image저장
            // 1) 물리적 저장경로에 Image저장
            file1 = realPath + imgNamef.getOriginalFilename(); // 경로완성(ctrlc)
            imgNamef.transferTo(new File(file1)); // Image저장(ctrlv[경로]->File타입으로 변환★)
            // 2) Table 저장 준비
            file2="reviewImage/"+imgNamef.getOriginalFilename();
        }
        // ** Table에 완성 String경로 set
        vo.setImgName(file2);
//-----------------------------------------------------------------------------//
        // 2. Service 처리
        if ( reviewService.reviewinsert(vo)>0 ) {
            model.addAttribute("message","후기등록 성공");
        }else {
            model.addAttribute("message","후기 등록 실패. 다시 이용하시기 바랍니다.");
            uri = "/review/reviewInsert";
        }
        return uri;
    }

    //------------------------------------------------------------------------------------------------------//
    // Review 답변
    @RequestMapping(value="/reviewrinsertf")
    public String reviewrinsertf(HttpServletRequest request, HttpServletResponse response,
                              Model model, ReviewVO vo) { //vo에 detail의 root 담김
        return "/review/reviewrInsert";
    }

    @RequestMapping(value="/reviewrinsert", method = RequestMethod.POST)
    public String reviewrinsert(HttpServletRequest request, HttpServletResponse response,
                                 Model model, ReviewVO vo) {
        // 한글처리
        response.setContentType("text/html; charset=UTF-8");

        // 요청분석 (json은 jsonView return 해야함)
        vo.setReviewStep(vo.getReviewStep()+1);
        vo.setReviewChild(vo.getReviewChild()+1);

        // Service 처리
        if ( reviewService.reviewrinsert(vo)>0 ) { // 인서트 성공 시
            model.addAttribute("code","200"); // success에 성공 표시 전달
        } else {
            model.addAttribute("code","500"); // success에 실패 표시 전달
            model.addAttribute("message","답변 등록에 실패했습니다.");
        }

        return "jsonView";
    }
    //------------------------------------------------------------------------------------------------------//
    // ** Review Update
    @RequestMapping(value="/reviewupdate", method= RequestMethod.POST)
    public String reviewupdate(HttpServletRequest request, HttpServletResponse response,
                               Model model, ReviewVO vo) throws IOException {
        // 1. 요청분석
        String uri = "redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        model.addAttribute("reviewResult",vo); //업뎃 실패시에도 값 저장
        //------------------------------------------------------------------------//
        // * 이미지 저장
        String realPath = request.getRealPath("/");
        System.out.println("** realPath => "+realPath);
        // 2) 위 값을 이용해서 실제저장위치 확인
        realPath = "C:\\Users\\Eom hee jeong\\IdeaProjects\\gram\\src\\main\\webapp\\resources\\reviewImage\\";
        // ** 기본 이미지 지정하기
        String file1, file2="reviewImage/noImage.JPG";
        // ** MultipartFile
        MultipartFile imgNamef = vo.getImgNamef();//이미지정보들 모두 들어있음.
        if ( imgNamef !=null && !imgNamef.isEmpty() ) {//이미지 첨부하고 이미지정보도 있는 경우
            // ** Image를 선택 -> Image저장
            // 1) 물리적 저장경로에 Image저장
            file1 = realPath + imgNamef.getOriginalFilename(); // 경로완성(ctrlc)
            imgNamef.transferTo(new File(file1)); // Image저장(ctrlv[경로]->File타입으로 변환★)
            // 2) Table 저장 준비
            file2="reviewImage/"+imgNamef.getOriginalFilename();
            // ** Table에 완성 String경로 set
            vo.setImgName(file2);
        }
//-----------------------------------------------------------------------------//
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
    public String reviewdelete(HttpServletRequest request, HttpServletResponse response,
                            ReviewVO vo, Model model, RedirectAttributes rttr) {
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
    public String reviewrDetail(HttpServletRequest request, HttpServletResponse response, Model model, ReviewVO vo) {
        // 1. 성공 시 detail폼
        String uri = "/review/reviewRdetail";

        // 2. detail 실행, 저장
        vo = reviewService.reviewrDetail(vo);

        if( vo != null ) { //detail 저장 성공이면
            model.addAttribute("reviewResult",vo);
        } else { //저장 실패 error면
            model.addAttribute("message","후기를 불러오는데 실패했습니다.");
            uri="redirect:reviewdetail?reviewNo="+vo.getReviewNo();
        }
        return uri;
    }

    //-------------------------------------------------------------------------------------------------//
    //-------------------------------------------------------------------------------------------------//

    @RequestMapping(value="/reviewlistM")
    public String reviewlistM(HttpServletRequest request, HttpServletResponse response,
                              SearchCriteria cri, Model model, PageMaker pageMaker) {
        // 1. 요청분석
        String uri = "/review/reviewListM"; // 성공 시 list
        String userId = null;

        // 2. session의 userId 받아서/ userId변수에 저장
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
        } else {
            model.addAttribute("message", "작성한 후기가 없습니다.");
            uri = "redirect:home";
        }
        pageMaker.setCri(cri);
        pageMaker.setTotalRowsCount(reviewService.searchCount(cri));
        model.addAttribute("pageMaker",pageMaker);

        return uri;
    }
    //---------------------------------------------------------------------------------//
    // ** review 답변 업데이트 폼 띄우기
    @RequestMapping(value="/reviewrupdatef")
    public String reviewrupdatef(HttpServletRequest request, HttpServletResponse response, ReviewVO vo, Model model) {
        vo.setUserId(vo.getUserId());
        vo.setReviewNo(vo.getReviewNo());
        vo.setReviewTitle(vo.getReviewTitle());
        vo.setReviewContent(vo.getReviewContent());

        model.addAttribute("reviewResult",vo);

        return "/review/reviewRupdate";
    }

    // ** review 답변 업데이트 하기
    @RequestMapping(value="/reviewrupdate", method= RequestMethod.POST)
    public String reviewrupdatef(HttpServletResponse response, Model model, ReviewVO vo) {
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

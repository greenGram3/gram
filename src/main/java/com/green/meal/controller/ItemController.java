package com.green.meal.controller;


import com.green.meal.domain.ImageVO;
import com.green.meal.domain.ItemVO;
import com.green.meal.domain.PageHandler;
import com.green.meal.domain.SearchCondition;
import com.green.meal.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/item")
public class ItemController {

    @Autowired
    ItemService itemService;

    @GetMapping("/list")
    public String itemList(SearchCondition sc, Model m) {

        try {

            //상품 리스트의 상품 개수가 총 몇개인지 구하기(페이징 목적)
            int totalCnt = itemService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            //페이지핸들러 만들고 총 상품 개수 매개변수로 전달
            //페이지 사이즈, 현재 페이지 등을 알아야되기 때문에 sc도 매개변수로 전달
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            //item 리스트 중에서 sc에 해당하는 페이지를 가져오기 위해 sc를 매개변수로 전달
            //sc에는 페이지 사이즈, offset이 포함되어있음(페이징 목적)
            List<ItemVO> list = itemService.getSearchResultPage(sc);

            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

        } catch (Exception e) {
            m.addAttribute("msg", "LIST_ERR");
            e.printStackTrace();
        }

        return "admin/itemList";
    }

    @GetMapping("/read")
    public String read(ItemVO vo, SearchCondition sc, Model m, ImageVO vo1) {
        try {
            
            //itemNo에 해당하는 image 정보 가져오기
            vo1 = itemService.imageAdmin(vo1.getItemNo());
            //itemNo에 해당한는 item 정보 가져오기
            vo = itemService.itemAdmin(vo.getItemNo());
            
            m.addAttribute("vo", vo);
            m.addAttribute("vo1",vo1);
            m.addAttribute("sc", sc);

            return "admin/itemAdmin";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "READ_ERR");
            //상품 상세보기 실패하면 다시 리스트로 돌아가
            return "admin/itemList";
        }
    }

    @PostMapping("/modify")
    public String modify(Model m, SearchCondition sc, ItemVO vo, ImageVO vo1, RedirectAttributes rattr, HttpServletRequest request) {

        try {
            System.out.println("** vo.getImageName"+vo.getFileName());
            System.out.println("** vo1.getImageName"+vo1.getImgName());

            //원래 있던 페이지로 돌아가기 위해 필요함 -> 파라미터로 전달
            //이렇게 안하고 리다이렉트에 sc.겟쿼리스트링 적는 방법도 있음 => 적용 잘 안돼서 일단 보류
            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());
            rattr.addAttribute("option", sc.getOption());
            rattr.addAttribute("keyword", sc.getKeyword());

            // --------------------------------------------------------------------------//
            // * 이미지 업데이트 - itemImage
            String realPath = request.getSession().getServletContext().getRealPath("/");
            System.out.println("** realPath => "+realPath);
            // 실제 저장 위치(배포 전 - 컴마다 다름)
            realPath += "resources\\itemImage\\";

            // 기본 이미지 지정
            String file1, file2, file3, file4;

            // ** MultipartFile
            MultipartFile fileNamef = vo.getFileNamef();
            if ( fileNamef !=null && !fileNamef.isEmpty() ) { //대표이미지가 null이 아니면
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file1 = realPath + fileNamef.getOriginalFilename();
                fileNamef.transferTo(new File(file1));
                // 2) Table 저장 준비
                file2="/itemImage/"+fileNamef.getOriginalFilename();

                // ** Table에 완성 String경로 set
                vo.setFileName(file2);
            }

            // --------------------------------------------------------------------------//
            // ImageImage 업데이트
            MultipartFile imgNamef = vo1.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) { //상세이미지가 null이면
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file3 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file3));
                // 2) Table 저장 준비
                file4 = "/itemImage/"+imgNamef.getOriginalFilename();

                // Table에 완성 String경로 set
                vo1.setImgName(file4);
            }

            // --------------------------------------------------------------------------//

            //수정 입력된 vo로 item 정보 update
            int rowCnt = itemService.itemModify(vo);

            vo1.setItemNo(vo.getItemNo());
            int itemNo = vo1.getItemNo();
            System.out.println("itemNo = " + itemNo);

            int rowCnt1 = itemService.imageModify(vo1);

            if(rowCnt!=1 && rowCnt1!=1)
                throw new Exception("item modify failed");

            rattr.addFlashAttribute("msg", "MOD_OK");

            //수정 성공하면 원래 있던 리스트 페이지로
            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            //수정 실패하면 수정하던 내용 그대로 상품 수정 페이지로
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "MOD_ERR");
            return "admin/itemAdmin";
        }
    }

    @PostMapping("/remove")
    public String remove(ItemVO vo, SearchCondition sc, Model m, RedirectAttributes rattr) {
        try {

            //원래 있던 페이지로 돌아가기 위해 꼭 필요함 -> 파라미터로 전달해야되기 때문
            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());

            //itemNo에 해당하는 상품 테이블에서 delete
            int rowCnt = itemService.itemRemove(vo.getItemNo());

            if (rowCnt != 1)
                throw new Exception("item remove failed");

            rattr.addFlashAttribute("msg", "DEL_OK");

            //삭제 성공하면 원래 있던 리스트 페이지로
            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            //실패하면 원래 있던 상품 정보 가지고 상품 상세보기 페이지로
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "DEL_ERR");
            return "admin/itemAdmin";
        }

    }

    @GetMapping("/upload")
    public String upload() {

        //상품목록에서 상품등록 버튼 누르면 상품등록 폼으로 이동
        return "admin/itemUpload";

    }

    @PostMapping("/upload")
    public String upload(ItemVO vo, ImageVO vo1, Model m, RedirectAttributes rattr, HttpServletRequest request) {

        try {
            //----------------------------------------------------------------------//
            // ** 이미지 업로드
            String realPath = request.getSession().getServletContext().getRealPath("/");
            realPath += "resources\\itemImage\\";

            // 기본 이미지 지정
            String file1, file2 = "/itemImage/noImage.JPG";
            String file3, file4 = "/itemImage/noImage.JPG";

            // item에 저장하는 Image
            // MultipartFile
            MultipartFile fileNamef = vo.getFileNamef();
            if ( fileNamef !=null && !fileNamef.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file1 = realPath + fileNamef.getOriginalFilename();
                fileNamef.transferTo(new File(file1));
                // 2) Table 저장 준비
                file2="/itemImage/"+fileNamef.getOriginalFilename();
            }
            // Table에 완성 String경로 set
            vo.setFileName(file2);
//-------------------------------------------------------------//
            // Image에 저장하는 Image
            // MultipartFile
            MultipartFile imgNamef = vo1.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file3 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file3));
                // 2) Table 저장 준비
                file4="/itemImage/"+imgNamef.getOriginalFilename();
            }
            // Table에 완성 String경로 set
            vo1.setImgName(file4);
 //--------------------------------------------------------------//

            //상품정보 가지고 item 테이블에 insert
            int rowCnt = itemService.itemUpload(vo);

            int itemNo = itemService.selectItemNo(vo.getItemName());
            vo1.setItemNo(itemNo);
            vo1.setImgType("e");

            String imgType = vo1.getImgType();


            int rowCntI = itemService.itemImgUpload(vo1);

            if(rowCnt!=1 && rowCntI!=1){

                throw new Exception("item upload failed");
            }


            rattr.addFlashAttribute("msg", "UPL_OK");

            //상품등록 성공하면 상품 리스트로(원래 페이지로 이동하지는 않음)
            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "UPL_ERR");
            //실패하면 다시 상품등록 페이지로 이동
            return "admin/itemUpload";
        }
    }
}



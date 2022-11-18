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
import java.awt.*;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/item")
public class ItemController {

    @Autowired
    ItemService itemService;

    List<ItemVO> itemList = new ArrayList<>();


    @GetMapping("/list")
    public String itemList(SearchCondition sc, Model m) {

        try {

            int totalCnt = itemService.getSearchResultCnt(sc);
            m.addAttribute("totalCnt", totalCnt);

            PageHandler pageHandler = new PageHandler(totalCnt, sc);

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
            vo1 = itemService.imageAdmin(vo1.getItemNo());
            vo = itemService.itemAdmin(vo.getItemNo());
            m.addAttribute("vo", vo);
            m.addAttribute("vo1",vo1);
            m.addAttribute("sc", sc);

            return "admin/itemAdmin";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "READ_ERR");
//            m.addAttribute("sc", sc);
//            이거 이렇게 전달해주지 않아도 매개변수에 있으면 읽을 수 있는거 같음
            return "admin/itemList";
        }
    }

    @PostMapping("/modify")
    public String modify(Model m, SearchCondition sc, ItemVO vo, ImageVO vo1, RedirectAttributes rattr, HttpServletRequest request) {

        try {

            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());
            rattr.addAttribute("option", sc.getOption());
            rattr.addAttribute("keyword", sc.getKeyword());
            //원래 있던 페이지로 돌아가기 위해 필요함 -> 파라미터로 전달
            //이렇게 안하고 리다이렉트에 sc.겟쿼리스트링 적는 방법도 있음 => 적용 잘 안돼서 일단 포기

            // --------------------------------------------------------------------------//
            // * 이미지 업데이트 - itemImage
            String realPath = request.getSession().getServletContext().getRealPath("/");
            /*String realPath = request.getRealPath("/");*/
            System.out.println("** realPath => "+realPath);
            // 실제 저장 위치(배포 전 - 컴마다 다름)
            /*realPath = "C:\\Users\\Eom hee jeong\\IdeaProjects\\gram\\src\\main\\webapp\\resources\\itemImage\\";*/
            realPath += "resources\\itemImage\\";

            // 기본 이미지 지정
            String file1, file2="/itemImage/noImage.JPG";
            String file3, file4="/itemImage/noImage.JPG";

            // ** MultipartFile
            MultipartFile imgNamef = vo.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file1 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file1));
                // 2) Table 저장 준비
                file2="/itemImage/"+imgNamef.getOriginalFilename();
                // ** Table에 완성 String경로 set
                vo.setImgName(file2);
            }
            // --------------------------------------------------------------------------//
            // ImageImage 업데이트
            MultipartFile imgNamef1 = vo1.getImgNamef1();
            if ( imgNamef1 !=null && !imgNamef1.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file3 = realPath + imgNamef1.getOriginalFilename();
                imgNamef1.transferTo(new File(file3));
                // 2) Table 저장 준비
                file4 = "/itemImage/"+imgNamef1.getOriginalFilename();
            }
            // Table에 완성 String경로 set
            vo1.setImgName(file4);
            // --------------------------------------------------------------------------//

            int rowCnt = itemService.itemModify(vo);


            vo1.setItemNo(vo.getItemNo());
            int itemNo = vo1.getItemNo();
            System.out.println("itemNo = " + itemNo);

            int rowCnt1 = itemService.imageModify(vo1);

            if(rowCnt!=1 && rowCnt1!=1)
                throw new Exception("item modify failed");

            rattr.addFlashAttribute("msg", "MOD_OK");

            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "MOD_ERR");
            return "admin/itemAdmin";
        }
    }

    @PostMapping("/remove")
    public String remove(ItemVO vo, SearchCondition sc, Model m, RedirectAttributes rattr) {
        try {

            rattr.addAttribute("page", sc.getPage());
            rattr.addAttribute("pageSize", sc.getPageSize());
            // 원래 있던 페이지로 돌아가기 위해 꼭 필요함 -> 파라미터로 전달해야되기 때문

            int rowCnt = itemService.itemRemove(vo.getItemNo());

            if (rowCnt != 1)
                throw new Exception("item remove failed");

            rattr.addFlashAttribute("msg", "DEL_OK");

            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("vo", vo);
            m.addAttribute("msg", "DEL_ERR");
            return "admin/itemAdmin";
        }

    }

    @GetMapping("/upload")
    public String upload() {

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
            String file1, file2="/itemImage/noImage.JPG";
            String file3, file4="/itemImage/noImage.JPG";

            // item에 저장하는 Image
            // MultipartFile
            MultipartFile imgNamef = vo.getImgNamef();
            if ( imgNamef !=null && !imgNamef.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file1 = realPath + imgNamef.getOriginalFilename();
                imgNamef.transferTo(new File(file1));
                // 2) Table 저장 준비
                file2="/itemImage/"+imgNamef.getOriginalFilename();
            }
            // Table에 완성 String경로 set
            vo.setImgName(file2);
//-------------------------------------------------------------//
            // Image에 저장하는 Image
            // MultipartFile
            MultipartFile imgNamef1 = vo1.getImgNamef1();
            if ( imgNamef1 !=null && !imgNamef1.isEmpty() ) {
                // ** Image를 선택 -> Image저장
                // 1) 물리적 저장경로에 Image저장
                file3 = realPath + imgNamef1.getOriginalFilename();
                imgNamef1.transferTo(new File(file3));
                // 2) Table 저장 준비
                file4="/itemImage/"+imgNamef1.getOriginalFilename();
            }
            // Table에 완성 String경로 set
            vo1.setImgName(file4);

 //--------------------------------------------------------------//
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

            return "redirect:/item/list";

        } catch (Exception e) {
            e.printStackTrace();
            m.addAttribute("msg", "UPL_ERR");
            return "admin/itemUpload";
        }
    }

//    ============= 사용 보류 ================

//    @PostMapping("/upload")
//    public String upload(ItemVO vo, Model m, RedirectAttributes rattr) throws Exception {
//
//
//            int rowCnt = itemService.itemUpload(vo);
//
//            if(rowCnt!=1)
//                throw new Exception("item upload failed");
//
//            rattr.addFlashAttribute("msg", "UPL_OK");
//
//            return "redirect:/item/list";
//
//    }

//    @ExceptionHandler(Exception.class)
//    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR) // 200 -> 500
//    public String catcher1(Model m) {
//        m.addAttribute("msg", "UPL_ERR");
//        System.out.println("Exception.class - start");
//        return "itemUpload";
//    }
//
//    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
//    public String catcher2(Model m) {
//        m.addAttribute("msg", "UiqueKey_ERR");
//        return "itemUpload";
//    }

//    ==============================================================================
    @GetMapping("/category1")
    public String category1( String category1, Model model){

        List<ItemVO> itemList = itemService.category1(category1);
        model.addAttribute("category",category1);
        model.addAttribute("itemList",itemList);


    return "/item/itemList";
    }

    @GetMapping("/category2")
    public String category2(String category2, Model model){

        List<ItemVO> itemList = itemService.category2(category2);
        model.addAttribute("category",category2);
        model.addAttribute("itemList",itemList);

        return "/item/itemList";
    }

    @GetMapping("/bestMeal")
    public String bestList(String category,Model model){
        List<ItemVO> list = itemService.bestItems();
        itemList=list.subList(0,16);

        model.addAttribute("category",category);
        model.addAttribute("itemList",itemList);

        return "/item/itemList";
    }
    @GetMapping("/newMeal")
    public String newList(String category,Model model){
        List<ItemVO> list = itemService.newItems();
        itemList=list.subList(0,16);

        model.addAttribute("category",category);
        model.addAttribute("itemList",itemList);

        return "/item/itemList";
    }

}



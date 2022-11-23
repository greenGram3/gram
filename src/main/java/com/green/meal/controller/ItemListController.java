package com.green.meal.controller;

import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import com.green.meal.service.ItemService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping("/itemList")
@RequiredArgsConstructor
@Controller
public class ItemListController {

    private final ItemService itemService;

    @GetMapping("/category1")
    public String category1( String category1, Model model){
        String category = null;
        switch (category1){
            case "1001": category = "한식";break;
            case "1002": category = "양식";break;
            case "1003": category = "중식/일식";break;
            case "1004": category = "분식";break;
            case "1005": category = "세트상품";break;
        }
        List<ItemVO> itemList = itemService.category1(category);
        giveCategoryPage(category,itemList,model);


        return "/item/itemList";
    }

    @GetMapping("/category2")
    public String category2(String category2, Model model){
        String category = null;
        switch (category2){
            case "1001": category = "비오는날";break;
            case "1002": category = "집들이";break;
            case "1003": category = "캠핑";break;
            case "1004": category = "술안주";break;
            case "1005": category = "혼밥";break;
        }

        List<ItemVO> itemList = itemService.category2(category);
        giveCategoryPage(category,itemList,model);

        return "/item/itemList";
    }

    @GetMapping("/bestMeal")
    public String bestList( Model model){
        String category = "베스트";

        List<ItemVO> list = itemService.bestItems();
        List<ItemVO> itemList=list.subList(0,16);

        giveCategoryPage(category,itemList,model );

        return "/item/itemList";
    }
    @GetMapping("/newMeal")
    public String newList(Model model){
        String category = "신메뉴";
        List<ItemVO> list = itemService.newItems();
        List<ItemVO> itemList=list.subList(0,16);

        giveCategoryPage(category, itemList,model );

        return "/item/itemList";
    }

    @GetMapping("/allItems")
    public String allList(Model model)  {
        String category = "전체보기";

        try {
            List<ItemVO> itemList = itemService.selectAll();

            giveCategoryPage(category, itemList, model);

        } catch (Exception e) {
            throw new RuntimeException(e);

        }

        return  "/item/itemList";

    }


    @GetMapping("/search")
    public String itemSearchList(SearchCondition sc, Model m) {
        try {
            List<ItemVO> list = itemService.searchItems(sc);

            giveCategoryPage("검색결과", list, m);

        } catch (Exception e) {
            e.printStackTrace();
        }


        return "item/itemList";
    }


    //모델에 카테고리, 아이템리스트 넘겨주기
    private void giveCategoryPage(String category, List<ItemVO> itemList, Model model ) {
        model.addAttribute("category", category);

        model.addAttribute("itemList",itemList);
    }
}

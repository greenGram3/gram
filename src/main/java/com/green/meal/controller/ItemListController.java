package com.green.meal.controller;

import com.green.meal.domain.ItemVO;
import com.green.meal.domain.SearchCondition;
import com.green.meal.service.ItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@RequestMapping("/itemList")
@RequiredArgsConstructor
@Controller
public class ItemListController {
    DecimalFormat format = new DecimalFormat("###,###");

    private final ItemService itemService;

    //카테고리1 별 아이템 리스트 보여주기
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
    //카테고리2 별 아이템 리스트 보여주기
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

    //베스트 아이템 리스트
    @GetMapping("/bestMeal")
    public String bestList( Model model){
        String category = "베스트";

        List<ItemVO> itemList = itemService.bestItems();


        giveCategoryPage(category,itemList,model);

        return "/item/itemList";
    }

    //신메뉴 아이템 리스트
    @GetMapping("/newMeal")
    public String newList(Model model){

        String category = "신메뉴";
        List<ItemVO> itemList = itemService.newItems();


        giveCategoryPage(category, itemList,model);

        return "/item/itemList";
    }
    //전체보기아이템 리스트
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

    //검색별 아이템 리스트
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

    @PostMapping("/select")
    public String selectOption(HttpServletResponse response, String value, String category,Model model) throws Exception{
        log.info("category = {}",category);
        response.setContentType("text/html; charset=UTF-8");
        switch(value) {
            case "highPrice":
                setItems(itemService.highPrice(category), model);
                break;
            case "lowPrice":
                setItems(itemService.lowPrice(category), model);
                break;
            case "latest":
                setItems(itemService.latest(category), model);
                break;
            case "review":
                setItems(itemService.review(category), model);
                break;
        }
        return "jsonView";
    }


    public void setItems(List<ItemVO> list, Model model){     // 정렬 조건별 배열세팅
        List<String> tmpList1 = new ArrayList();  List<String> tmpList2 = new ArrayList();
        List<String> tmpList3 = new ArrayList();  List<String> tmpList4 = new ArrayList();
        String[] itemNo ;
        String[] itemName;
        String[] fileName;
        String[] itemPrice;

        for (int i=0; i<list.size(); i++){
            tmpList1.add(String.valueOf(list.get(i).getItemNo()));
            tmpList2.add(String.valueOf(list.get(i).getItemName()));
            tmpList3.add(String.valueOf(list.get(i).getFileName()));
            tmpList4.add(String.valueOf(list.get(i).getItemPrice()));
        }
        itemNo = tmpList1.toArray(new String[tmpList1.size()]);
        itemName = tmpList2.toArray(new String[tmpList1.size()]);
        fileName = tmpList3.toArray(new String[tmpList1.size()]);
        itemPrice = tmpList4.toArray(new String[tmpList1.size()]);

        for(int i=0; i< itemPrice.length; i++){
            itemPrice[i] = format.format(Integer.parseInt(itemPrice[i]));
        }

        model.addAttribute("itemNo", itemNo);
        model.addAttribute("itemName", itemName);
        model.addAttribute("fileName", fileName);
        model.addAttribute("itemPrice", itemPrice);
    }

}

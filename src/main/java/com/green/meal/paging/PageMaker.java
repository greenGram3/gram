package com.green.meal.paging;

import lombok.Getter;
import lombok.ToString;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@ToString
public class PageMaker {
    private int totalRowsCount; //전체 record 갯수(전체 페이지 몇개될지 계산하는데 필요)

    // 1페이지 당 출력할 page갯수 계산 위해
    private int spageNo; //view에 표시할 첫 페이지 no(두번째글자 대문자 경우 고려해서 네이밍)
    private int epageNo; //view에 표시할 마지막 페이지 no
    private int displayPageNo = 3; // 1페이지 당 출력할 page갯수
    private int lastPageNo; //전체의 lastPage - 계산으로 얻음
    private boolean prev; // 이전(PageBlock)으로
    private boolean next; // 다음으로

    private SearchCriteria cri;
    //==================================================================================//
    // ** 필요값 set
    // 1) SearchCriteria
    public void setCri(SearchCriteria cri) {this.cri=cri;}

    // 2) totalRowCount
    public void setTotalRowsCount(int totalRowsCount) { //전체 레코드만 카운트 함 ==> 조건에 맞는 record만 카운트하는 매서드 추가하기
        this.totalRowsCount=totalRowsCount; // 전체 record 갯수 결정되면 Data계산 실행
        calcData();
    }
    // 3) 위 외 필요한 값 계산하는 통일 매서드
    //    => totalRowsCount 를 이용해서
    //       spageNo, epageNo, prev, next, lastPageNo 계산
    public void calcData() {
        // ** Math.ceil(c) : 매개변수 c 보다 크면서 같은 가장 작은 정수를 double 형태로 반환
        //                ceil -> 천장   ,  예) 11/3=3.666..  -> 4
        // => Math.ceil(12.345) => 13.0
        epageNo=(int)Math.ceil(cri.getCurrPage()/(double)displayPageNo) * displayPageNo;
        spageNo=(epageNo-displayPageNo) + 1;

        // 3.2) lastPageNo 계산, epageNo 확인
        lastPageNo=(int)Math.ceil(totalRowsCount/(double)cri.getRowsPerPage());
        if ( epageNo>lastPageNo ) epageNo=lastPageNo;

        // 3.3) prev, next - spageNo 이용해서 알 수 있음
        prev = spageNo==1 ? false : true; // spageNo==1 이면 앞으로 갈일X
        next = epageNo==lastPageNo ? false : true; // epageNo==lastPageNo 면 뒤로 갈일X
    } //calcData
//=============================================================================//
    // 4) 쿼리스트링 자동생성
    public String makeQuery(int currPage) {
        UriComponents uriComponents =
            UriComponentsBuilder.newInstance().
                    queryParam("currPage", currPage).
                    queryParam("rowsPerPage",cri.getRowsPerPage()).
                    build();
        return uriComponents.toString();
    } //makeQuery

    //----------------------------------------------------------------------------//
    //     ** ver02(검색조건O/search,keyword 포함된 쿼리스트링 생성 - paging시에도 조건 유지)
    public String searchQuery(int currPage) {
        UriComponents uriComponents =
                UriComponentsBuilder.newInstance().
                        queryParam("currPage", currPage).
                        queryParam("rowsPerPage",cri.getRowsPerPage()).
                        queryParam("searchType", cri.getSearchType()).
                        queryParam("scKeyword", cri.getScKeyword()).
                        build();
        return uriComponents.toString();
    } //searchQuery
} //PageMaker

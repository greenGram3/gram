package com.green.meal.paging;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@ToString
public class SearchCriteria {
    private int rowsPerPage; // 1Page 당 출력할 Row 갯수
    private int currPage; // 현재 Page
    private int sno; // start RowNo(현재페이지 start row번호)
    private int eno; // end RowNo

    @Setter
    private String searchType;

    @Setter
    private String scKeyword;

    // 1) 필요한 "★기본값(처음)" 초기화는 생성자 이용
    public SearchCriteria () {
        this.rowsPerPage=5; // 1페이지 당 row data 5개 씩 출력
        this.currPage=1; // 제일 처음 시작 페이지는 1페이지
    } //SearchCriteria 생성자

//-------------------------------------------------------------------------------------//
    // 2) setCurrPage : param으로 요청받은(출력할) PageNo
    public void setCurrPage(int currPage) {
        if (currPage>1) this.currPage=currPage;
        else this.currPage=1;
    }
    // 3) setRowsPerPage (한 화면에 출력할 data(row) 갯수 - n개씩 보기)
    //    3.1) 제한조건 점검 가능(n개 까지 허용)
    //    3.2) 당장 실행은 아니더라도 원할 때 사용 가능되도록 작성
    public void setRowsPerPage(int rowsPerPage) {
        if ( rowsPerPage>5 && rowsPerPage<=50 ) { //default 갯수를 5로 했으니까 범위 3-30
            this.rowsPerPage=rowsPerPage;
        } else this.rowsPerPage=5;
    }
    // 4) setSnoEno : sno 계산
    //              => currPage, RowsPerPage를 이용
    //      ★★ 출력 순번(sql문 처리시 resultSet 안에 rowNumber를 자동으로 set한걸 이용)
    public void setSnoEno() {
        // 처음이면 무조건 sno 는 1
        if ( this.sno<1 ) { //int 가 0 는 처음 초기상태란 뜻 -> 1번부터 시작
            this.sno=1;
        }
        this.sno = (this.currPage-1)*this.rowsPerPage;
        this.eno = this.sno+this.rowsPerPage-1;
    }
} //SearchCriteria

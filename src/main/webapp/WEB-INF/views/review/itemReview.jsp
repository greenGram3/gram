<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewList</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
            // ** 후기 내용 게시글 바로 밑 출력 json
            function reviewDetailD(e, reviewNo, itemNo, count) {
                e.stopPropagation(); //부모로 이벤트 올라가는 거 방지

                console.log('*** e.type =>' + e.type);
                console.log('*** e.target =>' + e.target);

                if ($('#' + count).html() == '') {

                    $.ajax({
                        type: 'Get',
                        url: 'reviewDetailD?reviewNo=' + reviewNo + "&itemNo=" + itemNo,

                        success: function (resultData) {
                            $('#' + count).html(resultData.reviewContent);
                        },
                        error: function () {
                            $('#resultArea2').html('서버 오류. 다시 시도하시기 바랍니다.');
                        }
                    });
                } else {
                    $('#' + count).html('');
                }
            } //reviewDetailD
//------------------------------------------------------------------------------------------//
            // ** 상품후기 Ajax Paging
            // 1) Page버튼에 Ajax 요청 용도의 class 만들기
            // 2) 요청 URL - 해당 클래스의 href 속성(url = itemReview?currPage=ㅁ&rowsPerPage=ㅁ&searchType=ㅁ&scKeyword=ㅁ)
            // 3.1) Page클릭 시 ReviewController/itemReview 로 요청
            // 3.2) 요청 시 itemNo를 매개변수로 전달
            // 4) 요청 성공 시 itemReview.jsp Ajax로 출력 / 실패 시 오류 메세지
            // 5) click 한 class에서만 작동하고 종료하도록 return false로 click 종료
            $(function () {
                $('.axPaging').click(function(){
                    let url = $(this).attr('href');

                    $.ajax({
                        type:'Get',
                        url:url+"&itemNo="+$('#itemNo').val(),
                        success:function(resultPage){
                            $('#resultArea1').html(resultPage);
                        },
                        error:function(){
                            $('#resultArea1').html('itemReview Paging 오류');
                        }
                    }); //ajax
                    return false;
                }); //axPaging click
            }) //ready
    </script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <div class="main">
        <div class="reviewD">
            <section class="section_container">
                <table>
                    <tr>
                        <th class="reviewItem">상품 정보</th>
                        <th class="reviewTitle">제목</th>
                        <th class="writer">작성인</th>
                    </tr>
                    <c:if test="${not empty reviewResult}">
                        <c:forEach var="review" items="${reviewResult}" varStatus="reviewVs">
                            <tr>
                                <c:if test="${not empty review.imgName}">
                                    <td><img src="${review.imgName}" width=50 height=50></td>
                                </c:if>

                                <c:if test="${review.reviewStep < 1}">
                                    <td>
                                        <a href="javascript:;"
                                           onclick="reviewDetailD(event, ${review.reviewNo}, ${review.itemNo}, ${reviewVs.count})">${review.reviewTitle}</a>
                                    </td>
                                </c:if>

                                <c:if test="${review.reviewStep > 0}">
                                    <td></td>
                                    <td>
                                        <a href="javascript:;"
                                           onclick="reviewDetailD(event, ${review.reviewNo}, ${review.itemNo}, ${reviewVs.count})">&nbsp;&nbsp;ㄴ답변&nbsp;${review.reviewTitle}</a>
                                    </td>
                                </c:if>
                                <c:if test="${review.userId != 'admin'}">
                                    <td>${review.userId}</td>
                                </c:if>
                                <c:if test="${review.userId == 'admin'}">
                                    <td>관리자</td>
                                </c:if>
                            </tr>
                            <tr>
                                <td style="border-bottom: none;"></td>
                                <td class="resultArea"><span class="reviewD resultArea" id="${reviewVs.count}"></span></td>
                            </tr>
                            <tr hidden>
                                <td>${review.itemNo}</td>
                                <input type="hidden" value="${review.itemNo}" id="itemNo" name="itemNo" readonly>
                            </tr>
                        </c:forEach>
                    </c:if>
                </table>
                <c:if test="${empty reviewResult}">
                    <span>아직 후기가 없습니다.</span>
                </c:if>
            </section>


            <c:if test="${not empty reviewResult}">
                <div>
                    <c:choose>
                        <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                            <a href="itemReview${pageMaker.searchQuery(1)}" class="axPaging firstBtn">◀◀</a>&nbsp;
                            <a href="itemReview${pageMaker.searchQuery(pageMaker.spageNo-1)}" class="axPaging forwardBtn">&lt;</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
                        <c:if test="${i==pageMaker.cri.currPage}">
                            <span class="currPage">${i}</span>
                        </c:if>
                        <c:if test="${i!=pageMaker.cri.currPage}">
                            <a href="itemReview${pageMaker.searchQuery(i)}" class="axPaging">${i}</a>
                        </c:if>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                            <a href="itemReview${pageMaker.searchQuery(pageMaker.epageNo+1)}" class="axPaging backBtn">&nbsp;&nbsp;&gt;</a>
                            <a href="itemReview${pageMaker.searchQuery(pageMaker.lastPageNo)}" class="axPaging lastBtn">▶▶</a>
                        </c:when>
                        <c:otherwise>
                            <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewList</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#scKeyword').val('');
            }); //change
            $('#reviewSearchBtn').click(function () {
                self.location = "reviewlist"
                    + "${pageMaker.makeQuery(1)}"
                    + "&searchType="
                    + $('#searchType').val()
                    + "&scKeyword="
                    + $('#scKeyword').val()
            }); //click
        }); //ready
    </script>
</head>
<body>
<%@include file="../include/header.jsp"%>

<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>

<main class="main_container">
    <div class="main">
        <%@include file="../include/mypage.jsp"%>
        <div class="reviewList">

    <h1>상품후기</h1>
            <hr>
    <section class="section_container">
        <div id="reviewSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="in" ${pageMaker.cri.searchType=='in' ? 'selected':''}>상품명</option>
                <%--<option value="t" ${pageMaker.cri.searchType=='t' ? 'selected':''}>제목</option>--%>
            </select>
            <input type="text" name="scKeyword" id="scKeyword" value="${pageMaker.cri.scKeyword}">
            <button id="reviewSearchBtn">검색</button>
        </div>
        <table>
            <tr>
                <th>상품</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
            </tr>
            <c:if test="${not empty reviewResult}">
                <c:forEach var="review" items="${reviewResult}">
                        <tr>
                            <c:if test="${not empty review.imgName}">
                                <td><img src="${review.imgName}"></td>
                            </c:if>
                            <c:if test="${review.reviewStep < 1}">
                                <td><a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}">${review.reviewTitle}</a></td>
                            </c:if>
                            <!-- Step > 0 이면 관리자가 단글 -> 여기만 &nbsp; 적용 & colspan 3  -->
                            <c:if test="${review.reviewStep > 0}">
                                <td></td>
                                <td text-align="right">
                                    <a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}">&nbsp;&nbsp;ㄴ답변&nbsp;${review.reviewTitle}</a>
                                </td>
                            </c:if>
                            <td>${review.userId}</td>
                            <td class="regDate">${review.regDate}</td>
                        </tr>

                        <tr hidden>
                            <td>${review.itemNo}</td>
                        </tr>
                        <br>
                </c:forEach>
            </c:if>
        </table>
    </section>
    <!-- Paging 1)forward button 2)back button 3)pageNo -->
    <div class="paging">
        <!-- 1. First, Prev button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
        <c:choose>
            <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">

                <a href="reviewlist${pageMaker.searchQuery(1)}" class="firstBtn">◀◀</a>&nbsp;
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.spageNo-1)}" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
                <!-- 앞으로가기 : 현재페이지의 이전 그룹(spage-1)
                => rowsPerPage는 그대로, currPage=spage-1 : EL로 기재 -->
            </c:when>
            <c:otherwise>
                <span class="firstBtn none">◀◀&nbsp;&nbsp;&lt;&nbsp;</span>
            </c:otherwise>
        </c:choose>

        <!-- 2. Display PageNo - 반복문 begin(spage)-end(epage)(범위지정) 사용
              : ver01.pageMaker.makeQuery / ver02.searchQuery -->
        <c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
            <!-- currPage 는 cri안에 있으니까 .cri로 부르기
            i가 현재페이지라면(현재page 가 현재page라면) -->
            <c:if test="${i==pageMaker.cri.currPage}">
                <!-- 현재페이지 표식 -->
                <span class="currPage">${i}</span>&nbsp;
            </c:if>

            <c:if test="${i!=pageMaker.cri.currPage}">
                <!-- i가 현재페이지가 아닐 때 - 클릭하면 넘어가야 하니까 a href
                현재페이지 param으로 controller에 넣어줘서 기준 주고, controll동작하게 하기-->
                <a href="reviewlist${pageMaker.searchQuery(i)}">${i}</a>
            </c:if>
        </c:forEach>

        <!-- 3. Next, Last button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
        <c:choose>
            <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.epageNo+1)}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                <!-- 뒤로가기 : 현재 페이지의 다음그룹
                => rowsPerPage는 그대로, currPage=epage+1 -->
                <a href="reviewlist${pageMaker.searchQuery(pageMaker.lastPageNo)}" class="lastBtn">▶▶</a>
                <!-- lastPage는 pageMaker에서 계산해놨으니까 그대로 넣어주기 -->
            </c:when>
            <c:otherwise>
                <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
            </c:otherwise>
        </c:choose>
    </div>
        </div>
    </div>
</main>
<%@include file="../include/footer.jsp"%>
</body>
</html>

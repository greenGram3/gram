<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaList</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#scKeyword').val('');
            }); //change
            $('#qnaSearchBtn').click(function () {
                self.location = "qnalist"
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
<jsp:include page="../include/header.jsp" flush="false" />

<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <div class="main">
        <jsp:include page="../include/mypage.jsp" flush="false" />
        <div class="qnaList">
    <h1>1:1문의</h1>
            <hr>
    <section class="section_container">
        <div id="qnaSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="i" ${pageMaker.cri.searchType=='i' ? 'selected':''}>아이디</option>
                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected':''}>제목</option>
                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected':''}>내용</option>
            </select>
            <input type="text" name="scKeyword" id="scKeyword" value="${pageMaker.cri.scKeyword}">
            <button id="qnaSearchBtn">검색</button>
        </div>
        <br>

        <table>
            <tr>
                <th>아이디</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
            <c:if test="${not empty qnaResult}">
                <c:forEach var="qna" items="${qnaResult}">
                    <tr>
                        <td>${qna.userId}</td>
                        <td>
                            <c:if test="${qna.qnaChild > 0}">
                                <c:forEach begin="1" end="${qna.qnaChild}">
                                    <span>&nbsp;&nbsp;</span>
                                </c:forEach>
                                <span style="color:blue">ㄴ</span>
                            </c:if>
                            <!-- 유저 -->
                            <c:if test="${userId != 'admin'}">
                                <c:choose>
                                    <c:when test="${userId == qna.userId}">
                                        <a href="qnadetail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
                                    </c:when>
                                    <c:when test="${userId != qna.userId && qna.userId != 'admin'}">
                                        [작성자 혹은 관리자만 확인 가능한 문의입니다.]
                                    </c:when>
                                    <c:when test="${qna.userId == 'admin'}">
                                        [답변완료]
                                    </c:when>
                                </c:choose>
                            </c:if>

                            <!-- 관리자 -->
                            <c:if test="${userId == 'admin'}">
                                <a href="qnadetail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
                            </c:if>
                        </td>
                        <td>${qna.regDate}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </section>
    <!-- Paging 1)forward button 2)back button 3)pageNo -->
    <div class="paging">
        <!-- 1. First, Prev button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
        <c:choose>
            <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">

                <a href="qnalist${pageMaker.searchQuery(1)}" class="firstBtn">◀◀</a>&nbsp;
                <a href="qnalist${pageMaker.searchQuery(pageMaker.spageNo-1)}" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
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
                <span class="currPage">${i}</span>
            </c:if>

            <c:if test="${i!=pageMaker.cri.currPage}">
                <!-- i가 현재페이지가 아닐 때 - 클릭하면 넘어가야 하니까 a href
                현재페이지 param으로 controller에 넣어줘서 기준 주고, controll동작하게 하기-->
                <a href="qnalist${pageMaker.searchQuery(i)}">${i}</a>
            </c:if>
        </c:forEach>

        <!-- 3. Next, Last button: ver01.pageMaker.makeQuery / ver02.SearchQuery -->
        <c:choose>
            <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                <a href="qnalist${pageMaker.searchQuery(pageMaker.epageNo+1)}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                <!-- 뒤로가기 : 현재 페이지의 다음그룹
                => rowsPerPage는 그대로, currPage=epage+1 -->
                <a href="qnalist${pageMaker.searchQuery(pageMaker.lastPageNo)}" class="lastBtn">▶▶</a>
                <!-- lastPage는 pageMaker에서 계산해놨으니까 그대로 넣어주기 -->
            </c:when>
            <c:otherwise>
                <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <div class="Insert">
                <c:if test="${not empty userId && userId != 'admin'}">
                    <a href="qnainsertf">1:1 문의하기</a>
                </c:if>
            </div>
        </div>
    </div>
    </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

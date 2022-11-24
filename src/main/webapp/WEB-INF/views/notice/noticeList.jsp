<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>noticeList</title>
    <link rel="stylesheet" href="<c:url value='/css/notice.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        // ** notice Search js
        $(function () {
            $('#searchType').change(function () {
                if ($(this).val() == 'a') $('#scKeyword').val('');
            }); //change
            $('#noticeSearchBtn').click(function () {
                self.location = "noticelist"
                    + "${pageMaker.makeQuery(1)}"
                    + "&searchType="
                    + $('#searchType').val()
                    + "&scKeyword="
                    + $('#scKeyword').val()
                    + "&link="
                    + "${link}"
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

        <c:if test="${link eq 'A'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${link eq 'C'}">
            <jsp:include page="../include/center.jsp" flush="false" />
        </c:if>


        <div class="noticeList">
    <h1>공지사항</h1>
            <hr>
    <section class="section_container">
        <div id="noticeSearchBar">
            <select name="searchType" id="searchType" class="searchBar">
                <option value="a" ${pageMaker.cri.searchType==null ? 'selected':''}>--전체--</option>
                <option value="t" ${pageMaker.cri.searchType=='t' ? 'selected':''}>제목</option>
                <option value="c" ${pageMaker.cri.searchType=='c' ? 'selected':''}>내용</option>
                <option value="tc" ${pageMaker.cri.searchType=='tc' ? 'selected':''}>제목+내용</option>
            </select>
            <input type="text" name="scKeyword" id="scKeyword" value="${pageMaker.cri.scKeyword}">
            <button id="noticeSearchBtn">검색</button>
        </div>
        <br>

        <table>
            <tr>
                <th>분류</th>
                <th>제목</th>
                <th>등록일</th>
            </tr>
            <c:if test="${not empty noticeResult}">
                <c:forEach var="notice" items="${noticeResult}">
                    <tr>
                        <td>${notice.noticeType}</td>
                        <td>
                            <a href="noticedetail?noticeNo=${notice.noticeNo}&link=${link}">${notice.noticeTitle}</a>
                        </td>
                        <td class="regDate">${notice.regDate}</td>
                    </tr>
                </c:forEach>
            </c:if>
        </table>
    </section>
    <hr>
        <div class="paging">
            <c:choose>
                <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                    <a href="noticelist${pageMaker.searchQuery(1)}&link=${link}" class="firstBtn">◀◀</a>&nbsp;
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.spageNo-1)}&link=${link}" class="forwardBtn">&lt;</a>&nbsp;&nbsp;
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
                    <a href="noticelist${pageMaker.searchQuery(i)}&link=${link}">${i}</a>
                </c:if>
            </c:forEach>

            <c:choose>
                <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.epageNo+1)}&link=${link}" class="backBtn">&nbsp;&nbsp;&gt;</a>
                    <a href="noticelist${pageMaker.searchQuery(pageMaker.lastPageNo)}&link=${link}" class="lastBtn">▶▶</a>
                </c:when>
                <c:otherwise>
                    <span class="lastBtn none">&nbsp;&gt;&nbsp;&nbsp;▶▶</span>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="linkBtn_container">
            <div class="linkBtn">
                <div class="Insert">
                    <c:if test="${ userId == 'admin'}">
                        <a href="noticeinsertf?link=${link}">공지등록</a>
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

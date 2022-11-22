<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewList</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>

<%@include file="../include/header.jsp" %>
<main class="main_container">
    <div class="main">

        <jsp:include page="../include/mypage.jsp" flush="false"/>


        <div class="reviewList">
            <h1>상품후기</h1>
            <hr>

            <section class="section_container">
                <table>
                    <tr>
                        <th>이미지 미리보기</th>
                        <th colspan="2">제목</th>
                        <th>아이디</th>
                    </tr>
                    <c:if test="${not empty reviewResult}">
                        <c:forEach var="review" items="${reviewResult}">
                            <c:if test="${review.reviewStep < 1}">
                                <tr>
                                    <c:if test="${not empty review.imgName}">
                                        <td><img src="${review.imgName}" width=150 height=150></td>
                                    </c:if>
                                    <td colspan="2">
                                        <a href="reviewdetail?reviewNo=${review.reviewNo}&itemNo=${review.itemNo}&link=M">${review.reviewTitle}</a>
                                    </td>
                                    <td>${review.userId}</td>
                                </tr>
                                <tr hidden>
                                    <td>${review.itemNo}</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty reviewResult}">
                        <tr>
                            <td colspan="4">작성하신 후기가 없습니다.</td>
                        </tr>
                    </c:if>
                </table>
            </section>

            <c:if test="${not empty reviewResult}">
                <div class="paging">
                    <c:choose>
                        <c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
                            <a href="myReview${pageMaker.searchQuery(1)}&link=M" class="firstBtn">◀◀</a>&nbsp;
                            <a href="myReview${pageMaker.searchQuery(pageMaker.spageNo-1)}&link=M" class="forwardBtn">&lt;</a>
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
                            <a href="myReview${pageMaker.searchQuery(i)}&link=M">${i}</a>
                        </c:if>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${pageMaker.next && pageMaker.epageNo>0}">
                            <a href="myReview${pageMaker.searchQuery(pageMaker.epageNo+1)}&link=M" class="backBtn">&nbsp;&nbsp;&gt;</a>
                            <a href="myReview${pageMaker.searchQuery(pageMaker.lastPageNo)}&link=M" class="lastBtn">▶▶</a>
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
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>

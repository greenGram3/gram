<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewReplyDetail</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
    <script src="resources/ajaxLib/jquery-3.2.1.min.js"></script>
    <script src="resources/ajaxLib/reviewRinsert.js"></script>
</head>
<body>
<main class="main_container">
    <section class="section_container">
        <table>
            <tr>
                <td>제목</td>
                <td>${reviewResult.reviewTitle}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="5" cols="50" readonly>${reviewResult.reviewContent}</textarea></td>
            </tr>
            <tr hidden>
                <td>${reviewResult.reviewNo}</td>
                <td>${reviewResult.reviewRoot}</td>
                <td>${reviewResult.reviewStep}</td>
                <td>${reviewResult.reviewChild}</td>
            </tr>
        </table>
    </section>

    <!-- 수정하기(업데이트) -> Ajax -->
    <c:if test="${not empty userId && userId == 'admin'}">
        <div background-color="Black" text-align="left">
            <span color="Gray" onclick="reviewReplyUpF('admin',${reviewResult.reviewNo})">댓글수정하기</span>
            <a href="reviewdelete?reviewNo=${reviewResult.reviewNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a><br>
        </div>
    </c:if>

    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea2"></div>
    </section>
</main>
</body>
</html>

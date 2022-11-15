<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewReplyDetail</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
    <script>
        $(function (){
            // ** Review 답변 업데이트 팝업 띄우기
            $('#reviewReplyUpF').click(function () {
                window.open("<c:url value='/reviewrupdatef'/>?userId=${userId}&reviewNo=${reviewResult.reviewNo}&reviewTitle=${reviewResult.reviewTitle}&reviewContent=${reviewResult.reviewContent}", "Child","width=920, height=450,left=500, top=500");
            }); //reviewReplyUpF
        }) //ready
    </script>
</head>
<body>
<main class="main_container">
    <div class="reviewReplyDetail">
    <section class="section_container">
        <table>
            <tr>
                <td>제목</td>
                <td>${reviewResult.reviewTitle}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea readonly>${reviewResult.reviewContent}</textarea></td>
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
        <div class="reviewReply">
            <span color="White" id="reviewReplyUpF">댓글 수정하기</span>
            <a href="reviewdelete?reviewNo=${reviewResult.reviewNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a><br>
        </div>
    </c:if>

    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea2"></div>
    </section>
    </div>
</main>
</body>
</html>

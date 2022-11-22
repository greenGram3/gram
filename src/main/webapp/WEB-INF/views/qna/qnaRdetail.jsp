<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaReplyDetail</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
    <script>
        $(function (){
            // ** QnA 답변 업데이트 폼 띄우기(Ajax)
            $('#qnaReplyUpF').click(function () {
                window.open("<c:url value='/qnarupdatef'/>?userId=${userId}&qnaNo=${qnaResult.qnaNo}", "Child","width=900, height=600,left=300, top=300");
            }); //qnaReplyUpF
        }) //ready
    </script>
</head>
<body>
<main class="main_container">
        <div class="qnaRdetail">
    <section class="section_container">
        <table>
            <tr>
                <td>제목</td>
                <td>${qnaResult.qnaTitle}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="5" cols="50" readonly>${qnaResult.qnaContent}</textarea></td>
            </tr>
            <tr hidden>
                <td>${qnaResult.userId}</td>
                <td>${qnaResult.qnaNo}</td>
                <td>${qnaResult.qnaRoot}</td>
                <td>${qnaResult.qnaStep}</td>
                <td>${qnaResult.qnaChild}</td>
                <td>${link}</td>
            </tr>
        </table>
    </section>

    <!-- 수정하기(업데이트) -> Ajax -->
    <c:if test="${not empty userId && userId == 'admin'}">
        <div class="qnaRdetailCheck" >
            <span color="White" id="qnaReplyUpF">답변수정하기</span>
            <a href="qnadelete?qnaNo=${qnaResult.qnaNo}&link=${link}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a><br>
        </div>
    </c:if>

    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
    </section>
        </div>
</main>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>qnaReplyDetail</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
    <script src="resources/ajaxLib/jquery-3.2.1.min.js"></script>
    <script src="resources/ajaxLib/qnaRinsert.js"></script>
    <script>
        $(function (){
            // ** QnA 답변 업데이트 폼 띄우기(Ajax)
            $('#qnaReplyUpF').click(function () {
                window.open("<c:url value='/qnadetail'/>?jCode=U&userId=${qnaResult.userId}&qnaNo=${qnaResult.qnaNo}", "Child","width=900, height=600,left=300, top=300");
            }); //qnaReplyUpF
        }) //ready
    </script>
</head>
<body>
<main class="main_container">
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
            </tr>
        </table>
    </section>

    <!-- 수정하기(업데이트) -> Ajax -->
    <c:if test="${not empty userId && userId == 'admin'}">
        <div background-color="Black" text-align="left">
            <span color="White" id="qnaReplyUpF">답변수정하기</span>
            <a href="qnadelete?qnaNo=${qnaResult.qnaNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a><br>
        </div>
    </c:if>

    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
    </section>
</main>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>qnaDetail</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
    <script src="resources/ajaxLib/jquery-3.2.1.min.js"></script>
    <script src="resources/ajaxLib/qnaRinsert.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>

<main class="main_container">
    <h1>1:1문의</h1>
    <section class="section_container">
        <table>
            <tr>
                <td>아이디</td>
                <td>${qnaResult.userId}</td>
            </tr>
            <tr>
                <td>제목</td>
                <td>${qnaResult.qnaTitle}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="5" cols="50" readonly>${qnaResult.qnaContent}</textarea></td>
            </tr>

            <tr hidden>
                <td>글번호</td>
                <td>${qnaResult.qnaNo}</td>
            </tr>
            <tr hidden>
                <td>${qnaResult.qnaRoot}</td>
                <td>${qnaResult.qnaStep}</td>
                <td>${qnaResult.qnaChild}</td>
            </tr>
        </table>
    </section>

    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="qnalist">목록으로</a>&nbsp;&nbsp;
            <c:if test="${userId == 'admin' && qnaResult.qnaChild < 1}">
        <span class="textLink"
              onclick="qnaReplyF(${qnaResult.qnaRoot},${qnaResult.qnaStep},${qnaResult.qnaChild})">답글달기</span><br>
            </c:if>
            <c:if test="${qnaResult.qnaStep < 1}">
                <span class="textLink"
                      onclick="qnaReplyD(${qnaResult.qnaRoot},${qnaResult.qnaStep},${qnaResult.qnaChild})">답변보기</span><br>
            </c:if>
            <c:if test="${userId == qnaResult.userId || userId == 'admin'}">
                <a href="qnadetail?jCode=U&qnaNo=${qnaResult.qnaNo}">수정하기</a>&nbsp;&nbsp;
                <a href="qnadelete?qnaNo=${qnaResult.qnaNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a><br>
            </c:if>
        </div>
    </div>
    <section class="section_container">
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
        <div id="resultArea3"></div>
    </section>
</main>
</body>
</html>

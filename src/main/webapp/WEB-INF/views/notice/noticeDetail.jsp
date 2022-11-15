<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>NoticeDetail</title>
    <link rel="stylesheet" href="<c:url value='/css/notice.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

        <%@include file="../include/center.jsp"%>

        <div class="noticeDetail">
    <h3>공지사항</h3>
    <section class="section_container">
        <table>
            <tr>
                <td>제목</td>
                <td>${noticeResult.noticeTitle}</td>
            </tr>
            <tr>
                <td>작성일</td>
                <td>${noticeResult.regDate}</td>
            </tr>
            <tr>
                <td>내용</td>
                <td><textarea rows="15" cols="100" readonly>${noticeResult.noticeContent}</textarea></td>
            </tr>

            <tr hidden>
                <td>글번호</td>
                <td>${noticeResult.noticeNo}</td>
            </tr>
        </table>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="noticelist">목록으로</a>
            <c:if test="${userId == 'admin'}">
                <a href="noticedetail?jCode=U&noticeNo=${noticeResult.noticeNo}">수정하기</a>
                <a href="noticedelete?noticeNo=${noticeResult.noticeNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
        </div>
    </div>
    <%@include file="../include/footer.jsp"%>
</main>
</body>
</html>
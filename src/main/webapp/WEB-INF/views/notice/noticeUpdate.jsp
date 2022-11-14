<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>noticeUpdate</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <h1>공지사항</h1>
    <section class="section_container">
        <form action="noticeupdate" method="post">
            <table>
                <tr>
                    <td>분류입력</td>
                    <td>
                        <select name="noticeType" id="noticeType">
                            <option value="이벤트">이벤트</option>
                            <option value="공지">공지</option>
                            <option value="편한밥상">편한밥상</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>작성일</td>
                    <td><input type="text" name="regDate" value="${noticeResult.regDate}" readonly></td>
                </tr>

                <tr>
                    <td>제목</td>
                    <td><input type="text" name="noticeTitle" value="${noticeResult.noticeTitle}" minlength="2" required></td>
                </tr>

                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="noticeContent" minlength="10" required>${noticeResult.noticeContent}</textarea></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="submit" value="등록" onclick="return confirm('수정하시겠습니까? 수정/취소');">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="noticeNo" value="${noticeResult.noticeNo}"></td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            &nbsp;&nbsp;&nbsp;<a href="noticelist">목록으로</a>&nbsp;&nbsp;
            <c:if test="${userId == 'admin'}">
                &nbsp;&nbsp;<a href="noticedelete?noticeNo=${noticeResult.noticeNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>

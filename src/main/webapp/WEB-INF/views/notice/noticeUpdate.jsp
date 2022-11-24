<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>noticeUpdate</title>
    <link rel="stylesheet" href="<c:url value='/css/notice.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

        <div class="noticeUpdate">
    <h3>공지사항 수정</h3>
    <section class="section_container">
        <form action="noticeupdate" method="post">
            <table>
                <tr>
                    <td>분류입력</td>
                    <td>
                        <select name="noticeType" id="noticeType">
                            <option value="FAQ">FAQ</option>
                            <option value="이벤트">이벤트</option>
                            <option value="공지">공지</option>
                            <option value="편한밥상">편한밥상</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td>제목</td>
                    <td><input type="text" class="noticeTitle"  name="noticeTitle" value="${noticeResult.noticeTitle}" minlength="2" required></td>
                </tr>

                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="noticeContent" minlength="10" required>${noticeResult.noticeContent}</textarea></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="submit" value="수정" onclick="return confirm('수정하시겠습니까? 수정/취소');">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="noticeNo" value="${noticeResult.noticeNo}"></td>
                    <td><input  name="${link}" value="${link}"></td>
                </tr>

                <tr hidden>
                    <td><input  name="${link}" value="${link}"></td>
                </tr>
            </table>

        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="noticelist?link=${link}">목록으로</a>
            <c:if test="${userId == 'admin'}">
                <a href="noticedelete?noticeNo=${noticeResult.noticeNo}&link=${link}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>noticeInsert</title>
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


        <div class="noticeInsert">
    <h3>공지사항 작성</h3>
    <section class="section_container">
        <form action="noticeinsert" method="post">
            <table>
                <tr>
                    <th>분류입력</th>
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
                    <th>제목</th>
                    <td><input type="text" class="noticeTitle" name="noticeTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td><textarea  name="noticeContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="reset" value="취소">
                        <input type="submit" value="등록" onclick="return confirm('등록하시겠습니까? 등록/취소');">
                    </td>
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
        </div>
    </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

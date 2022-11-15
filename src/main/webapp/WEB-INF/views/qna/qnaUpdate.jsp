<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaUpdate</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
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
        <jsp:include page="../include/mypage.jsp" flush="false" />
        <div class="qnaUpdate">
    <h3>1:1문의 수정</h3>
    <section class="section_container">
        <form action="qnaupdate" method="post">
            <table>
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="userId" id="userId" value="${qnaResult.userId}" readonly></td>
                </tr>

                <tr>
                    <td>제목</td>
                    <td><input type="text" name="qnaTitle" id="qnaTitle" value="${qnaResult.qnaTitle}" minlength="2" required></td>
                </tr>

                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="qnaContent" id="qnaContent" minlength="10" required>${qnaResult.qnaContent}</textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="수정하기" id="updateBtn">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="qnaNo" id="qnaNo" value="${qnaResult.qnaNo}" readonly></td>
                </tr>
            </table>
       </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            &nbsp;<a href="qnalist">목록으로</a>
            <c:if test="${userId != 'admin'}">
                &nbsp;&nbsp;<a href="qnadelete?qnaNo=${qnaResult.qnaNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

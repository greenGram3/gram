<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaInsert</title>
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

        <c:if test="${link eq 'M'}">
            <jsp:include page="../include/center.jsp" flush="false" />
        </c:if>

        <c:if test="${link ne 'M'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>
        <div class="qnaInsert">
    <h3>1:1문의 작성</h3>
    <section class="section_container">
        <form action="qnainsert" method="post">
            <table>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="userId" value="${userId}" readonly>
                    </td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input class="qnaTitle" type="text" name="qnaTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="qnaContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <div class="qnaCheck">
                        <input type="reset" value="취소">
                        <input type="submit" value="등록" onclick="return confirm('등록하시겠습니까? 등록/취소');">
                    </div>
                    </td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="qnalist${link}">목록으로</a>
        </div>
        </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

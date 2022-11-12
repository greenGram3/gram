<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>qnaInsert</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
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
                    <td><input type="text" name="qnaTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="qnaContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="reset" value="취소">&nbsp;&nbsp;&nbsp;
                        <input type="submit" value="등록" onclick="return confirm('등록하시겠습니까? 등록/취소');">
                    </td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="qnalist">목록으로</a>
        </div>
    </div>
    &nbsp;&nbsp;
</main>
</body>
</html>

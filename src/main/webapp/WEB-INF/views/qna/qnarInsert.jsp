<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>qnaReplyInsert</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <div class="qnaRInsert">
    <h3>1:1문의 답변 작성</h3>
    <section class="section_container">
        <form action="qnaRInsert" method="post">
            <table>
                <tr hidden>
                    <td>관리자</td>
                    <td><input type="text" name="userId" id="userId" value="${userId}" readonly></td>
                </tr>
                <tr>
                    <td>답변 제목</td>
                    <td><input type="text" name="qnaTitle" id="qnaTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>답변 내용</td>
                    <td><textarea rows="10" cols="50" name="qnaContent" id="qnaContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>

                <!-- 답글등록시 필요한 부모글의 root, step, child 전달 -->
                <tr>
                    <td hidden>
                        <input type="text" name="qnaRoot" id="qnaRoot" value="${param.qnaRoot}" readonly>
                        <input type="text" name="qnaStep" id="qnaStep" value="${param.qnaStep}" readonly>
                        <input type="text" name="qnaChild" id="qnaChild" value="${param.qnaChild}" readonly>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span id="qnaRinsert" class="textLink">답변등록</span></td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="qnalist">목록으로</a>
        </div>
    </div>
    </div>
</main>
</body>
</html>

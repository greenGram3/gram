<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewReplyInsert</title>
    <link rel="stylesheet" href="resources/css/boardDetail.css">
    <script src="resources/ajaxLib/jquery-3.2.1.min.js"></script>
    <script src="resources/ajaxLib/reviewRinsert.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <h2>상품후기 답변 작성</h2>
    <section class="section_container">
        <form action="reviewrinsert" method="post">
            <table>
                <tr hidden>
                    <td><input type="text" id="userId" name="userId" value="${userId}" readonly></td>
                </tr>
                <tr>
                    <td>답변 제목</td>
                    <td><input type="text" id="reviewTitle" name="reviewTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>답변 내용</td>
                    <td><textarea rows="10" cols="50" id="reviewContent" name="reviewContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>

                <!-- 답글등록시 필요한 부모글의 orderNo, itemNo, root, step, child 전달 -->
                <tr hidden>
                    <td></td>
                    <td>
                        <input type="text" name="orderNo" id="orderNo" value="${param.orderNo}" readonly>
                        <input type="text" name="itemNo" id="itemNo" value="${param.itemNo}" readonly>
                        <input type="text" name="reviewRoot" id="reviewRoot" value="${param.reviewRoot}" readonly>
                        <input type="text" name="reviewStep" id="reviewStep" value="${param.reviewStep}" readonly>
                        <input type="text" name="reviewChild" id="reviewChild" value="${param.reviewChild}" readonly>
                    </td>
                </tr>
                <tr>
                    <td colspan="2"><span id="reviewRinsert" class="textLink">답변등록</span></td>
                    <%--<td><input type="submit" value="답변등록" id="#reviewReply" class="textLink">&nbsp;</td>--%>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="reviewlist">목록으로</a>
        </div>
    </div>
</main>
</body>
</html>

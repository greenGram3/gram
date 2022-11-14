<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>noticeInsert</title>
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
        <form action="noticeinsert" method="post">
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
                    <td>제목</td>
                    <td><input type="text" name="noticeTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>

                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="noticeContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="reset" value="취소">&nbsp;&nbsp;&nbsp;
                        <input type="submit" value="등록" onclick="return confirm('등록하시겠습니까? 등록/취소');">
                    </td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            &nbsp;<a href="noticelist">목록으로</a>
        </div>
    </div>
</main>
</body>
</html>

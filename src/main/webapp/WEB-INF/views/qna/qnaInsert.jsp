<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaInsert</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
    <script>
        // qnaInsert json으로 변경
        $(function () {
            $('#qnaInsertBtn').click(function () {
                let result = confirm('등록하시겠습니까? (등록/취소)');

                if(result==true) {
                    alert('등록 되었습니다');
                } else {
                    return false;
                }

                $.ajax({
                    type: 'Post',
                    url: 'qnainsert',
                    data: {
                        userId: $('#userId').val(),
                        qnaTitle: $('#qnaTitle').val(),
                        qnaContent: $('#qnaContent').val(),
                        link: $('#link').val()
                    },
                    success: function (resultData) {
                        if (resultData.code == 200) { //json insert 성공 시
                            location.replace("qnalist?link=" + resultData.link);
                        } else { //json insert 실패 시
                            alert(resultData.message);
                            location.reload();
                        }
                    },
                    error: function () {
                        $('#resultArea2').html('QnA Insert error');
                    }
                }) //ajax
            });//qnaInsertBtn
        }) //ready
    </script>
</head>
<body>

<jsp:include page="../include/header.jsp" flush="false"/>


<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <div class="main">

        <c:if test="${link eq 'A'}">
            <jsp:include page="../include/admin.jsp" flush="false"/>
        </c:if>
        <c:if test="${link eq 'C'}">
            <jsp:include page="../include/center.jsp" flush="false"/>
        </c:if>

        <c:if test="${link eq 'M'}">
            <jsp:include page="../include/mypage.jsp" flush="false"/>
        </c:if>

        <div class="qnaInsert">
            <h3>1:1문의 작성</h3>

            <section class="section_container">
                <form action="qnainsert" method="post">
                    <table>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="userId" value="${userId}" id="userId" readonly>
                                <input hidden name="link" value="${link}" id="link">
                            </td>
                        </tr>
                        <tr>
                            <td>제목</td>
                            <td><input class="qnaTitle" type="text" name="qnaTitle" id="qnaTitle" minlength="2"
                                       placeholder="제목을 입력하세요" required></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea rows="10" cols="50" name="qnaContent" id="qnaContent" minlength="10"
                                          placeholder="내용을 입력하세요" required></textarea></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <div class="qnaCheck">
                                    <input type="reset" value="취소">
                                    <input type="button" value="등록" id="qnaInsertBtn">
                                </div>
                            </td>
                        </tr>

                    </table>
                </form>
            </section>
            <div class="linkBtn_container">
                <div class="linkBtn">
                    <a href="qnalist?link=${link}">목록으로</a>
                </div>
            </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>

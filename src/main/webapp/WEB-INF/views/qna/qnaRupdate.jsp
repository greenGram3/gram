<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>QnaReplyUpdate</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script>
        $(function () {
            $('#qrUpdateBtn').click(function () {

                var result = confirm('수정하시겠습니까? (수정/취소)');

                if(result==true) {
                    alert('답변이 수정 되었습니다');
                } else {
                    return false;
                }

                $.ajax({
                    type: 'Post',
                    url: 'qnarupdate',
                    data: {
                        qnaTitle: $('#qnaTitle').val(),
                        qnaContent: $('#qnaContent').val(),
                        qnaNo: $('#qnaNo').val()
                    },
                    success: function (resultData) {
                        if( resultData.code == 200 ) { //json update 성공 시
                            opener.parent.location.reload();
                            window.close();
                        } else { //json update실패 시
                            alert('error:'+resultData);
                        }
                    },
                    error: function () {
                        $('#resultArea2').html('Reply수정 error');
                    }
                }) //ajax
            }); // ReUpdateBtn
        })
    </script>
</head>
<body>
<main class="main_container">
    <div class="main">
        <form action="qnarupdate" method="post">
            <h3>1:1문의 답변 수정</h3>
            <table>
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="userId" id="userId" value="${qnaResult.userId}" disabled></td>
                </tr>

                <tr>
                    <td>제목</td>
                    <td><input type="text" name="qnaTitle" id="qnaTitle" minlength="2" required></td>
                </tr>

                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="qnaContent" id="qnaContent" minlength="10"
                                  required></textarea></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="수정하기" id="qrUpdateBtn">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="qnaNo" id="qnaNo" value="${qnaResult.qnaNo}" readonly></td>
                </tr>
            </table>
        </form>
    </div>
</main>
</body>
</html>

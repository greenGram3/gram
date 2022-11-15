<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>ReviewReplyUpdate</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
    <script>
        $(function () {
            $('#ReUpdateBtn').click(function () {

                var result = confirm('수정하시겠습니까? (수정/취소)');

                if(result==true) {
                    alert('답변이 수정 되었습니다');
                } else {
                    return false;
                }

                $.ajax({
                    type: 'Post',
                    url: 'reviewrupdate',
                    data: {
                        userId: $('#userId').val(),
                        reviewTitle: $('#reviewTitle').val(),
                        reviewContent: $('#reviewContent').val(),
                        reviewNo: $('#reviewNo').val()
                    },
                    success: function (resultData) {
                        if(resultData.code == 200) { //json update 성공 시
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
<form action="reviewrupdate" method="post">
    <table>
        <tr>
            <td>아이디</td>
            <td><input type="text" name="userId" id="userId" value="${reviewResult.userId}" readonly></td>
        </tr>
        <tr>
            <td>제목</td>
            <td><input type="text" name="reviewTitle" id="reviewTitle" minlength="2" required></td>
        </tr>
        <tr>
            <td>내용</td>
            <td><textarea name="reviewContent" id="reviewContent" minlength="10" required></textarea></td>
        </tr>

        <tr class="modBtn">
            <td colspan="2">
                <input type="submit" value="수정" id="ReUpdateBtn">
            </td>
        </tr>

        <tr hidden>
            <td>글번호</td>
            <td><input type="text" name="reviewNo" id="reviewNo" value="${reviewResult.reviewNo}"></td>
        </tr>
    </table>
</form>
</body>
</html>

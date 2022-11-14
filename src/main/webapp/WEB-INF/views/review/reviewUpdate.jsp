<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewUpdate</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
</head>
<body>
<c:if test="${not empty message}">
    <script type="text/javascript">
        let message = "${message}";
        alert(message);
    </script>
</c:if>
<main class="main_container">
    <h1>상품후기</h1>
    <section class="section_container">
        <form action="reviewupdate" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="userId" value="${reviewResult.userId}" readonly></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="reviewTitle" value="${reviewResult.reviewTitle}" minlength="2"
                               required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea rows="10" cols="50" name="reviewContent" id="reviewContent" minlength="10"
                                  required>${reviewResult.reviewContent}</textarea></td>
                </tr>
                <c:if test="${not empty reviewResult.imgName}">
                    <tr>
                        <td>첨부파일</td>
                        <td>
                            <img src="${reviewResult.imgName}" class="select_img">
                            <input type="hidden" name="imgName" id="imgName" value="${reviewResult.imgName}"><br>
                            <input type="file" name="imgNamef" id="imgNamef">
                        </td>
                    </tr>
                    <script>
                        $('#imgNamef').change(function () {
                            if (this.files && this.files[0]) {
                                let reader = new FileReader;
                                reader.readAsDataURL(this.files[0]);
                                reader.onload = function (e) {
                                    $(".select_img").attr("src", e.target.result)
                                        .width(150).height(150);
                                } // onload_function
                            }
                        }); //change
                    </script>
                </c:if>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="수정" onclick="return confirm('수정하시겠습니까? 수정/취소');">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="reviewNo" id="reviewNo" value="${reviewResult.reviewNo}"></td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn">
            <c:if test="${userId == reviewResult.userId || userId == 'admin'}">
                &nbsp;&nbsp;<a href="reviewdelete?reviewNo=${reviewResult.reviewNo}" onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
</main>
</body>
</html>

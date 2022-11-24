<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewUpdate</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
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

<jsp:include page="../include/header.jsp" flush="false" />

<main class="main_container">
    <div class="main">
        <c:if test="${userId == 'admin'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${userId != 'admin'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>
    <div class="reviewUpdate">

    <h3>상품 후기 수정</h3>
    <section class="section_container">
        <form action="reviewupdate" method="post" enctype="multipart/form-data" id="reviewUpForm">
            <table>
                <tr>
                    <td>아이디</td>
                    <td><input type="text" name="userId" id="userId" value="${reviewResult.userId}" readonly></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" name="reviewTitle" id="reviewTitle" value="${reviewResult.reviewTitle}" minlength="2"
                               required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea name="reviewContent" id="reviewContent" minlength="10"
                                  required>${reviewResult.reviewContent}</textarea></td>
                </tr>
                <c:if test="${not empty reviewResult.imgName}">
                    <tr>
                        <td>첨부파일</td>
                        <td class="imgCheck">
                            <li><img src="${reviewResult.imgName}" class="select_img"></li>
                            <input type="hidden" name="imgName" id="imgName" value="${reviewResult.imgName}">
                            <li><input type="file" name="imgNamef" id="imgNamef"></li>
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
                <tr class="modBtn">
                    <td colspan="2">
                        <input type="submit" value="수정">
                    </td>
                </tr>
                <tr hidden>
                    <td>글번호</td>
                    <td><input type="text" name="reviewNo" id="reviewNo" value="${reviewResult.reviewNo}"></td>
                </tr>
                <tr hidden>
                    <td><input name="link" value="${link}"></td>
                </tr>
            </table>
        </form>
    </section>
    </div>
    </div>

</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

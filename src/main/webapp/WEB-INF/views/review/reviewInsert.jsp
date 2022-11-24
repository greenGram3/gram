<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>reviewInsert</title>
    <link rel="stylesheet" href="<c:url value='/css/review.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/reviewAjax.js"></script>
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
        <c:if test="${userId == 'admin'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${userId != 'admin'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>

        <div class="reviewInsert">

    <h3>상품 후기 작성</h3>

    <section class="section_container">
        <form action="reviewinsert" method="post" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>주문번호</td>
                    <td><input type="text" name="orderNo" id="orderNo" value="${param.orderNo}" readonly></td>
                    <td hidden>상품번호</td>
                    <td hidden><input type="text" name="itemNo" id="itemNo" value="${param.itemNo}" readonly></td>
                </tr>

                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="userId" value="${userId}" readonly>
                    </td>
                </tr>
                <tr>
                    <td>상품정보</td>
                    <td>
                        <input type="text" name="itemName" value="${param.itemName}" readonly>
                    </td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input type="text" class="reviewTitle" name="reviewTitle" minlength="2" placeholder="제목을 입력하세요" required></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea rows="5" cols="50" name="reviewContent" minlength="10" placeholder="내용을 입력하세요" required></textarea></td>
                </tr>

                <tr>
                    <td>첨부파일</td>
                    <td>
                       <li><img src="" class="select_img"></li><!-- 선택한 파일 미리보기 -->
                        <li><input type="file" name="imgNamef" id="imgNamef"></li></td>
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
                <tr>
                    <td colspan="2">
                        <div class="reviewCheck">
                        <input type="submit" value="저장" onclick="return confirm('등록하시겠습니까? 등록/취소');">
                        <input type="reset" value="취소">
                     </div>
                    </td>
                </tr>
            </table>
        </form>
    </section>
    <div class="linkBtn_container">
        <div class="linkBtn"><a href="<c:url value="/mypage/order"/>">목록으로</a>
        </div>
    </div>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

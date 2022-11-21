<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>qnaDetail</title>
    <link rel="stylesheet" href="<c:url value='/css/qna.css'/>">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/qnaAjax.js"></script>
    <script>
        $(function () {
            // ** load시 답변 자동으로 보이게
            $('#qnaReply').trigger('click');

            // ** 답변달기 중복체크(Json)
            $('#DupCk').click(function () {
                $.ajax({
                    type: 'Post',
                    url: 'qnaDupCheck',
                    data: {
                        qnaRoot: $('#qnaRoot').val()
                    },
                    success: function (resultData) {
                        if (resultData.code == 200) { // 답글 있을 시
                            $('#qnaReWrite').hide();
                        } else { // 답글 없을 시
                            $('#qnaReWrite').show();
                        }
                    },
                    error: function () {
                        $('#resultArea2').html('답글중복체크 error');
                    }
                }) //ajax
            });
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
        <div class="qnaDetail">
            <h3>1:1문의</h3>
            <section class="section_container">
                <table>
                    <tr>
                        <td>아이디</td>
                        <td>${qnaResult.userId}</td>
                    </tr>
                    <tr>
                        <td>제목</td>
                        <td>${qnaResult.qnaTitle}</td>
                    </tr>
                    <tr>
                        <td>내용</td>
                        <td><textarea rows="5" cols="50" readonly>${qnaResult.qnaContent}</textarea></td>
                    </tr>

                    <tr hidden>
                        <td>글번호</td>
                        <td>${qnaResult.qnaNo}</td>
                    </tr>
                    <tr hidden>
                        <input type="hidden" value="${qnaResult.qnaRoot}" id="qnaRoot" disabled>
                        <td>${qnaResult.qnaRoot}</td>
                        <td>${qnaResult.qnaStep}</td>
                        <td>${qnaResult.qnaChild}</td>
                    </tr>
                </table>
            </section>

            <div class="linkBtn_container">
                <div class="linkBtn">
                    <a href="qnalist?link=${link}">목록으로</a>
                    <c:if test="${userId == 'admin' && qnaResult.qnaChild < 1}">
                        <!-- 답변달기 중복체크 -->
                        <span id="DupCk" hidden>답변중복체크</span>
                        <span class="textLink" id="qnaReWrite"
                              onclick="qnaReplyF(${qnaResult.qnaRoot},${qnaResult.qnaStep},${qnaResult.qnaChild},'${link}')">답글달기</span>
                    </c:if>
                    <c:if test="${qnaResult.qnaStep < 1}">
                <span class="textLink"
                      onclick="qnaReplyD(${qnaResult.qnaRoot},${qnaResult.qnaStep},${qnaResult.qnaChild})" id="qnaReply"
                      hidden>답변보기</span>
                    </c:if>
                    <c:if test="${userId == qnaResult.userId || userId == 'admin'}">
                        <a href="qnadetail?jCode=U&qnaNo=${qnaResult.qnaNo}&link=${link}">수정하기</a>
                        <a href="qnadelete?qnaNo=${qnaResult.qnaNo}&link=${link}"
                           onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
                    </c:if>
                </div>
            </div>
            <section class="section_container">
                <div id="resultArea1"></div>
                <div id="resultArea2"></div>
                <div id="resultArea3"></div>
            </section>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false"/>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
    <title>reviewDetail</title>
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
        <c:if test="${userId=='admin'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${userId!='admin'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>
<%--    <c:if test="${link=='A'}">
            <jsp:include page="../include/admin.jsp" flush="false" />
        </c:if>
        <c:if test="${link=='M'}">
            <jsp:include page="../include/mypage.jsp" flush="false" />
        </c:if>--%>

        <div class="reviewDetail">

        <h3>상품 후기</h3>

    <section class="section_container">
        <table>
            <tr>
                <th colspan="2">${reviewResult.reviewTitle}</th>
            </tr>
            <tr class="reviewDetailBold">
                <td>${reviewResult.userId}</td>
                <td>${reviewResult.regDate}</td>
            </tr>

            <tr>
                <td>
                    <c:if test="${not empty reviewResult.imgName}">
                        <img src="${reviewResult.imgName}">
                    </c:if>
                </td>
                <c:if test="${not empty reviewResult.itemName}">
                    <td><li>${reviewResult.itemName}</li>
                        <li><fmt:formatNumber pattern="###,###,###" value="${reviewResult.itemPrice}"/> 원</li>
                    </td>
                </c:if>
            </tr>

            <tr>
                <td colspan="2"><textarea readonly>${reviewResult.reviewContent}</textarea></td>
            </tr>

            <tr hidden>
                <td>후기번호</td>
                <td>${reviewResult.reviewNo}</td>
            </tr>
            <tr hidden>
                <td>${reviewResult.orderNo}</td>
                <td>${reviewResult.itemNo}</td>
                <td>${reviewResult.reviewRoot}</td>
                <td>${reviewResult.reviewStep}</td>
                <td>${reviewResult.reviewChild}</td>
            </tr>
        </table>
    </section>

    <div class="linkBtn_container">
        <div class="linkBtn">
            <a href="reviewlist?link=${link}">목록으로</a>
            <c:if test="${userId == 'admin' && reviewResult.reviewChild < 1}">
    <span class="textLink"
          onclick="reviewReplyF(${reviewResult.orderNo},${reviewResult.itemNo},${reviewResult.reviewRoot},${reviewResult.reviewStep},${reviewResult.reviewChild})">답글달기</span>
            </c:if>
            <c:if test="${reviewResult.reviewStep < 1}">
            <span class="textLink"
                  onclick="reviewReplyD(${reviewResult.reviewRoot},${reviewResult.reviewStep},${reviewResult.reviewChild})">댓글보기</span>
            </c:if>
            <c:if test="${userId == reviewResult.userId || userId == 'admin'}">
                <a href="reviewdetail?jCode=U&reviewNo=${reviewResult.reviewNo}&link=${link}">수정하기</a>
                <a href="reviewdelete?reviewNo=${reviewResult.reviewNo}&reviewRoot=${reviewResult.reviewRoot}&link=${link}"
                   onclick="return confirm('삭제하시겠습니까? 확인/취소');">삭제하기</a>
            </c:if>
        </div>
    </div>
    <section class="section_container">
        <!-- Ajax 답글 달기, 답글 출력 창 -->
        <div id="resultArea1"></div>
        <div id="resultArea2"></div>
        <div id="resultArea3"></div>
    </section>
        </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>

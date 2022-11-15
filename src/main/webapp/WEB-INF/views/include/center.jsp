<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">
<body>

<aside class="mypage">
  <h3>고객센터</h3>
  <div>
    <ul>
      <li><a href="<c:url value='/mypage/order'/>">　- 공지사항</a></li>
      <li><a href="<c:url value='/mypage/cancel'/>">　- 1:1 문의하기</a></li>
      <li><a href="<c:url value='/qnalist'/>">　- 1:1문의</a></li>
    </ul>
  </div>


</aside>

</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/css/mypage.css'/>">
<body>

<aside class="mypage">
  <h3>마이페이지</h3>
  <div>쇼핑정보
    <ul>
      <li><a href="<c:url value='/mypage/order'/>">　- 주문목록/배송조회</a></li>
      <li><a href="<c:url value='/mypage/cancel'/>">　- 취소/반품 내역</a></li>
    </ul>
  </div>

  <div>고객센터
    <ul>
      <li><a href="<c:url value='/qnalist'/>">　- 1:1문의</a></li>
    </ul>
  </div>

  <div>회원정보
    <ul>
      <li><a href="<c:url value='/update/user'/>">　- 회원정보 변경</a></li>
      <li><a href="<c:url value='/update/userDelete'/>">　- 회원 탈퇴</a></li>
      <li><a href="<c:url value='/delivery/delivery'/>">　- 배송지 관리</a></li>
    </ul>
  </div>

  <div>나의 상품후기
    <ul>
      <li><a href="<c:url value='/reviewlist'/>">　- 나의 상품후기</a></li>
    </ul>
  </div>
</aside>

</body>
</html>

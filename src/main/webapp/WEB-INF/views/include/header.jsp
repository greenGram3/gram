<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="loginId" value="${sessionScope.userId==null ? '' : sessionScope.userId}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="pageName" value="${loginId=='admin' ? '관리자페이지' : '마이페이지'}"/>
<c:set var="MyPageLink" value="${loginId=='' ?  '/mypage/order'  :  ( loginId=='admin' ? '/item/list' : '/mypage/order')}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="<c:url value='/css/basic.css'/>">
<script defer src="<c:url value='/js/basic.js'/>"></script>
<body>
<header>
  <div class="summit_line"></div>
  <section class="gram_container">
    <h1>
      <a class="logo_image" href="<c:url value='/'/>">편한밥상</a>
    </h1>
    <div class="user_input">
      <div class="memberShip">
        <a href="<c:url value='${loginOutLink}'/>">${loginOut}</a>|
        <c:if test="${loginOut == '로그인'}">
          <a href="<c:url value='/register/register'/>">회원가입</a>|
        </c:if>

        <a href="<c:url value='${MyPageLink}'/>" >${pageName}</a>|
        <a href="<c:url value='/noticelist?link=C'/>">고객센터</a>
        <a class="cartImage" href="<c:url value='/cart'/>">　</a>
      </div>

      <form action="<c:url value='/item/search'/>" role="input">
        <fieldset>
          <legend>
            <input type="text" name="keyword">
            <input type="hidden" name="option" value="Na">
            <button type="submit"></button>
          </legend>
        </fieldset>
      </form>
    </div>
  </section>

  <nav>
    <ul class="menu">
      <li><a href="#">편한밥상 소개</a></li>
      <li><a href="<c:url value='/item/allItems'/>">전체보기</a></li>
      <li><a class="meal" href="#">밀키트
        <div class="menus">
          <div class="category01" id="category01">
            <ul>
              <a class="meal" href="#">밀키트</a>
              <li><a href="<c:url value='/item/category1?category1=1001'/>">한식</a></li>
              <li><a href="<c:url value='/item/category1?category1=1002'/>">양식</a></li>
              <li><a href="<c:url value='/item/category1?category1=1003'/>">중식/일식</a></li>
              <li><a href="<c:url value='/item/category1?category1=1004'/>">분식/야식</a></li>
              <li><a href="<c:url value='/item/category1?category1=1005'/>">세트상품</a></li>
            </ul>
          </div>
        </div></a></li>
      <li><a class="them" href="#">테마별
        <div class="menus">
          <div class="thema">
            <ul>
              <a class="them" href="#">테마별</a>
              <li><a href="<c:url value='/item/category2?category2=1001'/>" >비오는날</a></li>
              <li><a href="<c:url value='/item/category2?category2=1002'/>">집들이</a></li>
              <li><a href="<c:url value='/item/category2?category2=1003'/>">캠핑</a></li>
              <li><a href="<c:url value='/item/category2?category2=1004'/>">술안주</a></li>
              <li><a href="<c:url value='/item/category2?category2=1005'/>">혼밥</a></li>
            </ul>
          </div>
        </div></a></li>
      <li><a href="<c:url value='/item/bestMeal'/>">베스트</a></li>
      <li><a href="<c:url value='/item/newMeal'/>">신메뉴</a></li>
      <li><a href="#">커뮤니티</a></li>
    </ul>



  </nav>
</header>
</body>
</html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true" %>
<script>
	if('${msg}'=='register_ok') alert("회원가입 되셨습니다.");
	if('${msg}'=='login_ok') alert("로그인 되셨습니다.");
	if('${msg}'=='logout_ok') alert("로그아웃 되셨습니다.");
</script>
<html>
<head>
	<title>Home</title>
	<link rel="stylesheet" href="<c:url value='/css/home.css'/>">
	<script defer src="<c:url value='/js/home.js'/>"></script>

</head>
<body>

<jsp:include page="include/header.jsp" flush="false" />

<main>
	<section class="event_container">
		<ul class="event_list" >
			<button class="play nonVisible"></button>
			<button class="pause"></button>
		</ul>
	</section>

	<section class="best_container">
		<h1>베스트 상품</h1>
		<div class="best_section01">
			<div class="best_box">
				<ul class="best_list">
					<c:forEach var="itemVO" items="${bestItems}">
						<c:set var="pageLink" value="/itemDetail?itemNo=${itemVO.itemNo}"/>
						<li>
							<a href="<c:url value='${pageLink}'/>"> <img src="<c:url value='${itemVO.imgName}'/>" width="300"></a>
							<h3>${itemVO.itemName}</h3>
							<h4><fmt:formatNumber pattern="###,###,###" value="${itemVO.itemPrice}"/> 원</h4>
						</li>
					</c:forEach>
				</ul>
			</div>
			<button class="btn_back nonVisible"></button>
			<button class="btn_after"></button>
		</div>
		<h1>신메뉴</h1>
		<div class="best_section02">
			<div class="best_box">
				<ul class="best_list">
				<c:forEach var="itemVO" items="${newItems}">
					<c:set var="pageLink" value="/itemDetail?itemNo=${itemVO.itemNo}"/>
					<li>
						<a href="<c:url value='${pageLink}'/>"> <img src="<c:url value='${itemVO.imgName}'/>" width="300"></a>
						<h3>${itemVO.itemName}</h3>
						<h4><fmt:formatNumber pattern="###,###,###" value="${itemVO.itemPrice}"/> 원</h4>
					</li>
				</c:forEach>
				</ul>
			</div>
			<button class="btn_back nonVisible"></button>
			<button class="btn_after"></button>
		</div>
	</section>


	<div class="gram_mission"></div>


</main>

<jsp:include page="include/footer.jsp" flush="false" />

</body>
</html>

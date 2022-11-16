<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
		<h2>베스트 상품</h2>
		<div class="best_section">
			<div class="best_box">
				<ul class="best_list">
				</ul>
				<P> event Zone  ${serverTime}. </P>
			</div>
			<button class="btn_back nonVisible"></button>
			<button class="btn_after"></button>
		</div>
	</section>
	<div class="gram_mission"></div>
	<div class ='gram_motto'></div>

</main>

<jsp:include page="include/footer.jsp" flush="false" />

</body>
</html>

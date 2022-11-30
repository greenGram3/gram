<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/deleteUser.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp" flush="false" />
<script>
    if("${msg}"=="deleteUser_fail") alert("비밀번호가 맞지 않습니다.");
</script>
<main>
    <div class="main">
        <%@include file="../include/mypage.jsp"%>

        <div class="deleteUser">
     <h3>01.회원탈퇴 안내</h3>
            <hr>
     <div>
    <pre>
                             편한밥상 탈퇴안내

회원님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나 봅니다.
불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.

■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.
1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한
고객정보 보호정책에따라 관리 됩니다.
2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다
    </pre>
     </div>

     <h3>02.회원탈퇴 하기</h3>
            <hr>
            <div class="deleteUserForm">
     <form action="<c:url value='/update/userDelete' />" method="post" id="form">
         <span>비밀번호</span><input type="text" name="userPwd" autofocus/>
         <span>탈퇴사유</span><input type="text" autofocus/>
         <input type="button" value="탈퇴하기" id="delBtn">
     </form>

            <form action="<c:url value='/update/userDelete2' />" method="post" id="form2">
                <input type="button" value="네이버회원 탈퇴하기" id="delBtn2">
            </form>
            </div>

<script>
const delBtn = document.querySelector("#delBtn");
const delBtn2 = document.querySelector("#delBtn2");

delBtn.addEventListener('click',function (){
   if(confirm("정말로 탈퇴하시겠습니까?")){
       document.querySelector("#form").submit();
   }
});

delBtn2.addEventListener('click',function (){
    if(confirm("정말로 탈퇴하시겠습니까?")){
        document.querySelector("#form2").submit();
    }
});

//회원별 버튼막기
if("${sessionScope.userId.length()}" > 12) {
    $('#delBtn')[0].disabled = true;
}else $('#delBtn2')[0].disabled = true;
</script>
    </div>
    </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />
</body>
</html>




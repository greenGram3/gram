<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="true"%>

<%--<%@ page import="java.net.URLDecoder"%>--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  <style>
    * { box-sizing:border-box; }
    form {
      width:650px;
      height:700px;
      display : flex;
      flex-direction: column;
      justify-content: center;
      align-items:center;
      position : absolute;
      top:50%;
      left:50%;
      transform: translate(-50%, -50%) ;
      border: 1px solid rgb(89,117,196);
      border-radius: 10px;
    }
    .info-container {
      display: flex;
      justify-content: center;
    }
    .input-field {
      width: 400px;
      height: 40px;
      border : 1px solid rgb(89,117,196);
      border-radius:5px;
      padding: 0 10px;
      margin-bottom: 10px;
    }
    #userAddr {
      height: 80px;
    }
    label {
      width:100px;
      height:30px;
      margin-top :4px;
    }
    button {
      background-color: rgb(89,117,196);
      border-radius: 5px;
      border : none;
      cursor: pointer;
      color : white;
      width:100px;
      height:40px;
      font-size: 15px;
      margin : 30px 0 20px 0;
    }
    .button_container {
      width: 300px;
      display: flex;
      justify-content: space-evenly;
    }
    .title {
      font-size : 20px;
      font-weight: bold;
      margin: 40px 0 30px 0;
    }
  </style>
  <title>회원 상세 정보</title>

</head>

<body>

<script>
  let msg = "${msg}";
  // if(msg=="MOD_ERR") alert("게시물 수정에 실패했습니다. 다시 시도해주세요.");
  // if(msg=="DEL_ERR") alert("게시물 삭제에 실패했습니다. 다시 시도해주세요.");
  // if(msg=="UPL_ERR") alert("게시물 등록에 실패했습니다. 다시 시도해주세요.");
</script>

<%--등록버튼 누르면 테이블에 insert 되도록 컨트롤러 돌려야될거같음--%>
<%--<form:form modelAttribute="user">--%>
<form id="form" action="" method="">
  <div class="title">회원 상세 정보</div>
  <div class="info-container">
    <label for="userId">아이디</label>
    <input class="input-field" type="text" id="userId" name="userId" value="${vo.userId}" readonly>
  </div>
  <div class="info-container">
    <label for="userName">이름</label>
    <input class="input-field" type="text"  class="user_name" id="userName" name="userName" value="${vo.userName}" readonly>
  </div>
  <div class="info-container">
    <label for="userName">이메일</label>
    <input class="input-field" type="text"  class="user_email" id="userEmail" name="userEmail" value="${vo.userEmail}" readonly>
  </div>
  <div class="info-container">
    <label for="userPhone">연락처</label>
    <input class="input-field" type="text" id="userPhone" name="userPhone"  value="${vo.userPhone}" readonly>
  </div>
  <div class="info-container">
    <label for="userAddr">주소</label>
    <input class="input-field" type="content" id="userAddr" name="userAddr" value="${vo.userAddr}" readonly>
  </div>
  <div class="info-container">
    <label for="userBirth">생일</label>
    <input class="input-field" type="number" id="userBirth" name="userBirth" value="${vo.userBirth}" readonly>
  </div>
  <div class="info-container">
    <label for="userGender">성별</label>
    <input class="input-field" type="text" id="userGender" name="userGender" value="${vo.userGender}" readonly>
  </div>
  <div class="info-container">
    <label for="regDate">가입일</label>
    <input class="input-field" type="text" id="regDate" name="regDate" value="${vo.regDate}" readonly>
  </div>
  <div class="button_container">
    <button type="button" id="listBtn" class="btn-cancel">회원목록</button>
    <button type="button" id="removeBtn" class="btn-remove">강제탈퇴</button>
  </div>

</form>

<script>

  $(document).ready(function(){

    $("#listBtn").on("click", function(){
      location.href="<c:url value='/user/list${searchCondition.queryString}'/>";
    });

    $("#removeBtn").on("click", function(){
      if(!confirm("정말로 탈퇴시키겠습니까?")) return;
      let form = $("#form");
      form.attr("action", "<c:url value='/user/remove${searchCondition.queryString}'/>");
      form.attr("method", "post");
      form.submit();
    });

  });

</script>

</body>

</html>


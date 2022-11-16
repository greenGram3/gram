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
  <link rel="stylesheet" href="<c:url value='/css/user.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

  <title>회원 상세 정보</title>

</head>

<body>

<jsp:include page="../include/header.jsp" flush="false" />
<main>

<script>
  let msg = "${msg}";
  // if(msg=="MOD_ERR") alert("게시물 수정에 실패했습니다. 다시 시도해주세요.");
  // if(msg=="DEL_ERR") alert("게시물 삭제에 실패했습니다. 다시 시도해주세요.");
  // if(msg=="UPL_ERR") alert("게시물 등록에 실패했습니다. 다시 시도해주세요.");
</script>

  <div class="main">
    <jsp:include page="../include/admin.jsp" flush="false" />

    <div class="userDetail">

<%--등록버튼 누르면 테이블에 insert 되도록 컨트롤러 돌려야될거같음--%>
<%--<form:form modelAttribute="user">--%>
  <h3>회원 상세 정보</h3>
  <hr>
<form id="form" action="" method="">
  <table>
  <tr>
    <th><label for="userId">아이디</label></th>
    <td><input class="input-field" type="text" id="userId" name="userId" value="${vo.userId}" readonly></td>
  </tr>
  <tr >
    <th><label for="userName">이름</label></th>
    <td><input class="input-field" type="text"  class="user_name" id="userName" name="userName" value="${vo.userName}" readonly>
    </td>
  </tr>
  <tr>
    <th><label for="userName">이메일</label></th>
    <td><input class="input-field" type="text"  class="user_email" id="userEmail" name="userEmail" value="${vo.userEmail}" readonly>
    </td>
   </tr>
  <tr>
    <th><label for="userPhone">연락처</label></th>
    <td><input class="input-field" type="text" id="userPhone" name="userPhone"  value="${vo.userPhone}" readonly>
    </td>
  </tr>
  <tr>
    <th><label for="userAddr">주소</label></th>
    <td><input class="input-field" type="content" id="userAddr" name="userAddr" value="${vo.userAddr}" readonly></td>
   </tr>
  <tr>
    <th><label for="userBirth">생일</label></th>
    <td><input class="input-field" type="number" id="userBirth" name="userBirth" value="${vo.userBirth}" readonly>
    </td>
  </tr>
  <tr>
    <th><label for="userGender">성별</label></th>
    <td><input class="input-field" type="text" id="userGender" name="userGender" value="${vo.userGender}" readonly>
    </td>
   </tr>
  <tr>
    <th><label for="regDate">가입일</label></th>
    <td><input class="input-field" type="text" id="regDate" name="regDate" value="${vo.regDate}" readonly></td>
  </tr>
  </table>

  <div class="button_container">
    <button type="button" id="listBtn" class="btn-cancel">목록으로</button>
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
    </div>
  </div>
</main>
<jsp:include page="../include/footer.jsp" flush="false" />

</body>

</html>


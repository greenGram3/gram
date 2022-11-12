<%@ page pageEncoding="UTF-8" %>
<script>
    if("${msg}"=="deleteUser_fail") alert("비밀번호가 맞지 않습니다.");
</script>


<main>

 <section>
     <h3>01.회원탈퇴 안내</h3>
     <div>
    <pre>
                             담짜몰 탈퇴안내

회원님께서 회원 탈퇴를 원하신다니 저희 쇼핑몰의 서비스가 많이 부족하고 미흡했나 봅니다.
불편하셨던 점이나 불만사항을 알려주시면 적극 반영해서 고객님의 불편함을 해결해 드리도록 노력하겠습니다.

■ 아울러 회원 탈퇴시의 아래 사항을 숙지하시기 바랍니다.
1. 회원 탈퇴 시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한
고객정보 보호정책에따라 관리 됩니다.
2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제 됩니다
    </pre>
     </div>

     <h3>02.회원탈퇴 하기</h3>
     <form action="<c:url value='/update/userDelete' />" method="post" id="form">
         <span>비밀번호</span><input type="text" name="userPwd"/>
         <span>탈퇴사유</span><input type="text"/>
         <input type="button" value="탈퇴하기" id="delBtn">
     </form>
 </section>
</main>
</body>
</html>

<script>
const delBtn = document.querySelector("#delBtn");

delBtn.addEventListener('click',function (){
   if(confirm("정말로 탈퇴하시겠습니까?")){
       document.querySelector("#form").submit();
   }else return;

});
</script>




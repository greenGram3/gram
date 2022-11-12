<%@ page pageEncoding="UTF-8" %>

<main>

 <section>
     <table border="1">
         <th>수령인</th>
         <th>배송지</th>
         <th>기본배송지</th>
         <th>주소</th>
         <th>연락처</th>
         <th>buttons</th>

         <c:forEach var="item" items="${list}" varStatus="status">
                 <tr>
                     <td>${item.receiver}</td>
                     <td>${item.delyPlace}</td>
                     <td>
                         <c:if  test="${item.delyNo eq 1}">
                             <span style="color: dodgerblue;">기본 배송지</span>
                         </c:if>
                     </td>
                     <th>${item.delyAddr}</th>
                     <th>${item.delyPhone}</th>
                     <th><input type="button" value="수정" id="updateBtn${status.index}">
                          <input type="button" value="삭제" id="deleteBtn${status.index}"></th>
                 </tr>
             <script>
                 document.querySelector("#updateBtn${status.index}").addEventListener('click', function(){
                     window.open("<c:url value='/delivery/update'/>?receiver=${item.receiver}&delyPlace=${item.delyPlace}&delyAddr=${item.delyAddr}&delyPhone=${item.delyPhone}","Child","left=400,top=200,width=500,height=500")
                 })

                 document.querySelector("#deleteBtn${status.index}").addEventListener('click', function(){
                     $.ajax({
                         type: 'Post',
                         url: 'delete',
                         data: {
                             receiver :  '${item.receiver}',
                             delyPlace :  '${item.delyPlace}',
                             delyNo : '${item.delyNo}',
                             delyAddr : '${item.delyAddr}',
                             delyPhone :  '${item.delyPhone}'
                         },
                         success: function (result) {
                             location.reload();
                             alert(result.code);
                         },
                         error: function (result) {
                             alert('error : '+result+" "+result.code);
                         }
                     })
                 })
             </script>
         </c:forEach>


     </table>

     <button type="button" id="regBtn">배송지등록</a>></button>
 </section>
</main>
</body>
</html>

<script>
    document.querySelector("#regBtn").addEventListener('click',function (){
        window.open("<c:url value="/delivery/register"/>","Child","left=400,top=200,width=500,height=500")
    })
</script>





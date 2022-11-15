<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>orderList</title>
    <link rel="stylesheet" href="<c:url value='/css/userOrderList.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<jsp:include page="include/header.jsp" flush="false" />
<script>
    let msg = "${msg}";
    if(msg=="null")alert("날짜를 다시 입력해주세요");
</script>
<main>
    <div class="main">

        <jsp:include page="include/mypage.jsp" flush="false" />

        <div class="orderList">
            <h3>주문목록 / 조회</h3>
            <div class="search-container">
                <form action="<c:url value="/user/order/list"/>" id = "form" class="search-form" method="post">
                    　조회기간　<input type="date" name="startDate"  value="${orderSearch.startDate}">  ~

                    <input type="date" name="endDate" value="${orderSearch.endDate}">

                    <input type="submit" class="searchBtn" value="조회">
                </form>
            </div>

            <figure>
                <table>
                    <thead>
                    <tr>
                        <th class="orderDate">주문번호</th>
                        <th>주문 상품</th>
                        <th>주문 금액</th>
                        <th>주문 상태</th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="orderListVO" items="${orderList}">
                        <tr>
                            <td class="orderDate"><a href="<c:url value="/user/order/list?order=${orderListVO.order}"/>" >${orderListVO.order}</a></td>
                            <td>${orderListVO.totalItem}</td>
                            <td><fmt:formatNumber pattern="###,###,###" value="${orderListVO.totalPay}"/> 원</td>
                            <td>${orderListVO.orderState}</td>
                            <c:if test="${orderListVO.orderState eq 'n'}">
                                <td>
                                    <li name="${orderListVO.orderNo}">
                                        <button  class="fixBtn" >구매확정</button></li>
                                    <li name="${orderListVO.orderNo}">
                                        <button  class="backBtn" >반품신청</button></li>
                                </td>
                            </c:if>
                        </tr>

                    </c:forEach>
                    </tbody>
                </table>
            </figure>

            <script>
                let getList = function (){
                    location.reload();
                }

                $(document).ready(function(){

                    let dateCheck = function (){
                        let form = document.getElementById("form");
                        if(form.startDate.value==''){
                            alert("시작 날짜를 입력해주세요");
                            form.startDate.focus();
                            return false;
                        }
                        if(form.endDate.value==''){
                            alert("마지막 날짜를 입력헤주세요");
                            form.endDate.focus();
                            return false;
                        }
                        if(form.startDate.value > form.endDate.value){
                            alert("시작날짜가 마지막날짜보다 과거여야 합니다")
                            form.startDate.focus()
                            return false;
                        }
                        return true;
                    }
                    let searchBtn = $('.searchBtn');
                    searchBtn.on('click', function () {
                        if (!dateCheck())
                            return false;

                    });

                    $(".fixBtn").click(function(){
                        if(!confirm("구매확정을 하시겠습니까?")) return;
                        let orderNo=$(this).parent().attr("name");
                        let orderState='구매확정';
                        $.ajax({
                            type:'patch',
                            url: '/meal/user/order/'+orderNo,
                            headers : { "content-type": "application/json"},
                            dataType : 'text',
                            data : JSON.stringify({orderNo:orderNo,orderState:orderState}),
                            success : function(result){
                                alert("구매 확정을 완료하였습니다");
                                getList();
                            },
                            error   : function(){ alert("구매 확정이 실패하였습니다") }
                        });
                        alert("구매 확정 중")
                    });

                    $(".backBtn").click(function(){
                        if(!confirm("정말로 반품요청을 하시겠습니까?")) return;
                        let orderNo=$(this).parent().attr("name");
                        let orderState='반품요청';
                        $.ajax({
                            type:'patch',
                            url: '/meal/user/order/'+orderNo,
                            headers : { "content-type": "application/json"},
                            dataType : 'text',
                            data : JSON.stringify({orderNo:orderNo,orderState:orderState}),
                            success : function(result){
                                alert("반품 신청이 완료되었습니다");
                                getList();
                            },
                            error   : function(){ alert("반품 신청을 실패하였습니다") }
                        });
                        alert("반품 신청 중")
                    });

                });
            </script>
        </div>
    </div>
</main>
<%@include file="include/footer.jsp"%>
</body>
</html>



<%@ page contentType="text/html;charset=UTF-8"  language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <title>cart</title>
    <link rel="stylesheet" href="<c:url value='/css/cart.css'/>">
    <script defer src="<c:url value='/js/cart.js'/>"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>

<body>
<%@include file="include/header.jsp"%>

<main>
    <div class="cart_container">

        <h2>장 바 구 니</h2>
        <hr>
        <figure>
            <table >
                <thead>
                <tr>
                    <th><input type="checkbox" class="itemCheck" name="${list}" ></th>
                    <th class="itemName">상품 </th>
                    <th class="cartAmount">수량 </th>
                    <th><li class="itemPrice">(개별금액)</li>
                        <li class="itemsPrice">합계금액</li></th>
                    <th class="mod">변경/삭제</th>
                </tr>
                </thead>
                <tbody>
                <c:set var="sum" value="0"/>
                <c:forEach var="cartVO" items="${list}" varStatus="status">
                    <tr>
                        <td>
                            <input type="checkbox" class="itemNo" name="${cartVO.itemNo}" value="${cartVO.itemNo}" >
                        </td>
                        <td>
                            <li><img src="${cartVO.path}"></li>
                            <li>${cartVO.itemName}</li>
                        </td>
                        <td class="cartAmount" name="cartAmount" >
                            <input type="text"  class="cartAmount${status.index}" name="${cartVO.cartAmount}" value="<c:out value='${cartVO.cartAmount}'/>">
                        </td>
                        <td>
                            <li class="itemPrice">(<fmt:formatNumber pattern="###,###,###" value="${cartVO.itemPrice}"/> 원)</li>
                            <li class="itemsPrice"><fmt:formatNumber pattern="###,###,###" value="${cartVO.cartAmount*cartVO.itemPrice}"/> 원</li>
                        </td>
                        <td>
                            <li class = "modBtn" name="${cartVO.itemNo}">
                                <button class="modBtn${status.index}" >수량 변경</button>
                            </li>
                            <li class="delBtn">
                                <button class="delBtn${status.index}">상품 삭제</button>
                            </li>
                        </td>
                    </tr >
                    <script>

                        $(".modBtn${status.index}").click(function(){
                            let itemNo= $(this).parent().attr("name");
                            let cartAmount=$(".cartAmount${status.index}").val();

                            if(cartAmount<=0){
                                alert("상품의 수량은 1보다 커야 합니다");
                                return false;
                            }
                            if(!confirm("수량을 변경하시겠습니까?")) return;
                            $.ajax({
                                type:'patch',
                                url: '/meal/cart/'+itemNo,
                                headers : { "content-type": "application/json"},
                                dataType : 'text',
                                data : JSON.stringify({itemNo:itemNo, cartAmount:cartAmount}),
                                success : function(result){
                                    alert("수량 변경이 완료되었습니다");
                                    getList();
                                },
                                error   : function(){ alert("수량 변경을 실패하였습니다") }
                            });
                        });

                        $(".delBtn${status.index}").click(function(){
                            if(!confirm("이 상품을 장바구니에서 삭제하시겠습니까?")) return;
                            let itemNo=$(this).parent().attr("name");
                            $.ajax({
                                type:'delete',
                                url: '/meal/cart/'+itemNo,
                                headers : { "content-type": "application/json"},
                                dataType : 'text',
                                data : JSON.stringify({itemNo:itemNo}),
                                success : function(result){
                                    alert("삭제가 완료되었습니다");
                                    getList();
                                },
                                error   : function(){ alert("삭제를 실패하였습니다") }
                            });
                        });

                    </script>
                    <c:set var="sum" value="${sum+(cartVO.cartAmount * cartVO.itemPrice)}"/>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr>
                    <th></th>
                    <th scope="row">총계</th>
                    <th></th>
                    <th class="totalPrice"><fmt:formatNumber pattern="###,###,###" value="${sum}"/> 원</th>
                    <th></th>
                </tr>
                </tfoot>
            </table>
        </figure>

        <button class="delAllBtn"> 전체 상품 삭제</button>
        <button class="payBtn"> 선택 상품 주문</button>
        <button class="shopBtn"> 계속 쇼핑 하기</button>
        <button class="payAllBtn"> 전체 상품 주문</button>
    </div>
    <script>

        let getList = function (){
            location.reload();
        }

        $(document).ready(function(){

            $("input[class=itemNo]").click(function () {
                $(".itemCheck").prop("checked", false);
            });

            $(".itemCheck").click(function() {
                // 2. itemCheck 체크되었을 때,
                //input태그를 찾아 checked를 true로 정의
                if ($(".itemCheck").prop("checked")) {
                    $("input[class=itemNo]").prop("checked", true)
                    // 3. itemCheck 체크되지 않았을 때,
                    // itemNo class input태그를 찾아 checked를 false로 정의
                } else {
                    $("input[class=itemNo]").prop("checked", false)
                }
            })

            $(".delAllBtn").on("click",function(){
                if(!confirm("정말로 모두 삭제하시겠습니까?")) return;
                $.ajax({
                    type:'delete',
                    url: '/meal/cart/cart',
                    headers : { "content-type": "application/json"},
                    dataType : 'text',
                    data : JSON.stringify({}),
                    success : function(result){
                        alert("삭제가 완료되었습니다");
                        getList();
                    },
                    error   : function(){ alert("삭제를 실패하였습니다") }
                });
            });

        });

    </script>

</main>

<%@include file="include/footer.jsp"%>

</body>
</html>
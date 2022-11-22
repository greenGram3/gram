$(function(){
    // ** Json
    $('#reviewRinsert').click(function () {

            var result = confirm('등록하시겠습니까? (등록/취소)');

            if(result==true) {
                alert('답변이 등록 되었습니다');
            } else {
                return false;
            }

        $.ajax({
            type: 'Post',
            url: 'reviewrinsert',
            data: {
                userId: $('#userId').val(),
                orderNo: $('#orderNo').val(),
                itemNo: $('#itemNo').val(),
                reviewTitle: $('#reviewTitle').val(),
                reviewContent: $('#reviewContent').val(),
                reviewRoot: $('#reviewRoot').val(),
                reviewStep: $('#reviewStep').val(),
                reviewChild: $('#reviewChild').val()
            },
            success: function (resultData) {
                if(resultData.code == 200) { //json insert 성공 시
                    location.replace('reviewlist');
                } else { //json insert 실패 시
                    $('#resultArea2').html(resultData.message);
                }
            },
            error: function () {
                $('#resultArea2').html('Reply등록 error');
            }
        }); //ajax
    });
}); //ready

// ** 답글 달기 클릭 시 function 작동
function reviewReplyF(orderNo, itemNo, reviewRoot, reviewStep, reviewChild) {
    $.ajax({
        type: 'Get',
        url: 'reviewrinsertf',
        data: {
            orderNo: orderNo,
            itemNo: itemNo,
            reviewRoot: reviewRoot,
            reviewStep: reviewStep,
            reviewChild: reviewChild
        },
        success: function (resultPage) {
            $('#resultArea1').html(resultPage);
        },
        error: function () {
            $('#resultArea1').html('ReplyForm 요청 error');
        }
    }); //ajax
} //reviewReplyF
//-----------------------------------------------------------------------//
// ** Detail에서 댓글보기
function reviewReplyD(reviewRoot,reviewStep,reviewChild) {
    $.ajax({
        type: 'Get',
        url: 'reviewrDetail',
        data: {
            reviewRoot: reviewRoot,
            reviewStep: reviewStep,
            reviewChild: reviewChild
        },
        success: function (resultPage) {
            $('#resultArea1').html(resultPage);
            $('#reviewReWrite').hide();
        },
        error: function () {
            $('#resultArea1').html('댓글이 달리지 않았습니다.');
        }
    }); //ajax
} //qnaReplyD


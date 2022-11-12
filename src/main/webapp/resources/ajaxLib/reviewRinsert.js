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
//-------------------------------------------------------------------------------------------------//

}); //ready

//-------------------------------------------------------------------------------------------------//

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
        },
        error: function () {
            alert('답글이 없습니다.');
        }
    }); //ajax
} //qnaReplyD
//-----------------------------------------------------------------------//
// ** Review 답변 업데이트 폼 띄우기(Ajax)
function reviewReplyUpF(userId, reviewNo) {
    $.ajax({
        type: 'Get',
        url: 'reviewrupdatef',
        data: {
            userId: userId,
            reviewNo: reviewNo
        },
        success: function (resultPage) {
            $('#resultArea2').html(resultPage);
        },
        error: function () {
            $('#resultArea2').html('ReplyForm 요청 error');
        }
    }); //ajax
} //reviewReplyUpF
//-----------------------------------------------------------------------//
// ** 상세페이지 reviewList
function reviewListD(itemNo) {
    $.ajax({
        type: 'Get',
        url: 'reviewlistD',
        data: {
            itemNo:itemNo
        },
        success: function (resultPage) {
            $('#resultArea1').html(resultPage);
        },
        error: function () {
            $('#resultArea1').html('ReplyForm 요청 error');
        }
    }); //ajax
} //qnaReplyD
//-----------------------------------------------------------------------//
// ** 상세페이지 Detail 바로 밑 출력 Json
function reviewDetailD(e, reviewNo, itemNo, count) {

    console.log('*** e.type =>'+e.type);
    console.log('*** e.target =>'+e.target);

    $('#resultArea2').html(''); //클릭 시 resultArea2 클리어

    if( $('#'+count).html()=='' ) {
        $.ajax({
            type: 'Get',
            url: 'reviewDetailD?reviewNo='+reviewNo+"&itemNo="+itemNo,
            success: function(resultData){

                $('.reviewD').html('');
                $('#'+count).html(resultData.reviewContent);
            },
            error: function(){
                $('#resultArea2').html('서버 오류. 다시 시도하시기 바랍니다.');
            }
        });
    } else {
        $('#'+count).html('');
    }
} //reviewDetailD


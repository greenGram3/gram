// ** 답글 달기 클릭 시 function 작동
function qnaReplyF(qnaRoot,qnaStep,qnaChild) {
    $.ajax({
        type: 'Get',
        url: 'qnarinsertf',
        data: {
            qnaRoot: qnaRoot,
            qnaStep: qnaStep,
            qnaChild: qnaChild
        },
        success: function (resultPage) {
            $('#resultArea1').html(resultPage);
        },
        error: function () {
            $('#resultArea1').html('ReplyForm 요청 error');
        }
    }); //ajax
} //qnaReplyF

//-----------------------------------------------------------------------//
// **답변 등록 Json
$(function(){
    // ** Json(답변 insert)
    $('#qnaRinsert').click(function () {
        var result = confirm('등록하시겠습니까? (등록/취소)');

        if(result==true) {
            alert('답변이 등록 되었습니다');
        } else {
            return false;
        }

        $.ajax({
            type: 'Post',
            url: 'qnarinsert',
            data: {
                userId: $('#userId').val(),
                qnaTitle: $('#qnaTitle').val(),
                qnaContent: $('#qnaContent').val(),
                qnaRoot: $('#qnaRoot').val(),
                qnaStep: $('#qnaStep').val(),
                qnaChild: $('#qnaChild').val()
            },
            success: function (resultData) {
                if(resultData.code == 200) { //json insert 성공 시
                    location.replace('qnalist');
                } else { //json insert 실패 시
                    $('#resultArea2').html(resultData.message);
                }
            },
            error: function () {
                $('#resultArea2').html('Reply등록 error');
            }
        }) //ajax
    }) //qnaRinsert
    //----------------------------------------------------------------------------------//
    // ** Json(디테일, 답변 update)
    $('#updateBtn').click(function () {
        var result = confirm('수정하시겠습니까? (수정/취소)');

        if(result==true) {
            alert('수정 되었습니다');
        } else {
            return false;
        }

        $.ajax({
            type: 'Post',
            url: 'qnaupdate',
            data: {
                userId: $('#userId').val(),
                qnaTitle: $('#qnaTitle').val(),
                qnaContent: $('#qnaContent').val(),
                qnaNo: $('#qnaNo').val()
            },
            success: function (resultData) {
                if(resultData.code == 200) { //json update 성공 시
                    if(opener != null) { //부모창 있으면 => 팝업임.
                        opener.parent.location.reload();
                        window.close();
                    }  else { // 부모창 없으면 => detail에서 수정한 거
                        location.replace('qnalist');
                    }
                } else { //json insert 실패 시
                    alert('error:'+resultData);
                }
            },
            error: function () {
                $('#resultArea2').html('Reply등록 error');
            }
        }) //ajax
    }) // updateBtn

}) //ready
//-----------------------------------------------------------------------//
// ** Detail에서 댓글보기
function qnaReplyD(qnaRoot,qnaStep,qnaChild) {
    $.ajax({
        type: 'Get',
        url: 'qnarDetail',
        data: {
            qnaRoot: qnaRoot,
            qnaStep: qnaStep,
            qnaChild: qnaChild
        },
        success: function (resultPage) {
            $('#resultArea1').html(resultPage);
        },
        error: function () {
            alert('아직 답글이 달리지 않았습니다.');
        }
    }); //ajax
} //qnaReplyD

//-----------------------------------------------------------------------//
//-----------------------------------------------------------------------//



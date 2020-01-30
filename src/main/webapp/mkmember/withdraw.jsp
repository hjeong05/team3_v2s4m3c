<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title></title>
<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
function send() {  
  if ($('input:checkbox[id="agree"]').is(":checked")) {
    frm.submit(); // submit 진행
  } else {
    msg = '안내사항 확인 후 동의 해주세요.<br>';
    
    $('#modal_content').attr('class', 'alert-danger'); // CSS 변경
    $('#modal_title').html('동의 여부 확인'); // 제목
    $('#modal_content').html(msg); // 내용
    $('#modal_panel').modal(); // 다이얼로그 출력
    return false;
  }
}
</script> 

</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <!-- Modal -->
  <div class="modal fade" id="modal_panel" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title" id='modal_title'></h4>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div> <!-- Modal END -->

  <ASIDE style='float: left;'>
      <A href='./mkmember/list.do'>회원 탈퇴</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
  </ASIDE> 
 
  <div class='menu_line'></div>
    
  <DIV class='title_line'>회원 탈퇴</DIV> 
 
<FORM name='frm' id='frm' method='POST' action='./withdraw.do' class="form-horizontal"> 
<input type="hidden" name="memberno" value="${param.memberno }">
<input type="hidden" name="memcateno" value="${param.memcateno }">
  <DIV class='message'>
    <fieldset class='fieldset_basic'>
      <UL>
        <LI class='li_none'>
          <span class='span_fail'>탈퇴시 내정보 및 이용기록이 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br><br>탈퇴하시겠습니까?<br><br></span>
          <input type="checkbox" name="agree" id="agree" onclick="" > 동의
        </LI>
        <LI class='li_none'>
          <button type='button' 
                      onclick="location.href='${pageContext.request.contextPath}'" 
                      class="btn btn-info">탈퇴 취소</button> 
          <button type="button" onclick="send();" class="btn btn-info">다음 단계</button>                        
        </LI>
       </UL>
    </fieldset>
  </DIV>
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
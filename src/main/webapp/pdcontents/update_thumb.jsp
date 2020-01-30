<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>
 
</head> 
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <ASIDE style='float: left;'>
    <A href='../productcate/list.do'>카테고리 그룹</A> > 
    <A href='./list.do?productcateno=${productcateVO.productcateno }'>${productcateVO.name }</A> >
    썸네일 수정
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href='./list.do?productcateno=${param.productcateno }'>목록</A>
    <!-- <span class='menu_divide' >│</span> -->
  </ASIDE> 
 
  <div class='menu_line'></div>
  <DIV style='width: 100%;'>
    <FORM name='frm' method='POST' action='./update_thumb.do' class="form-horizontal">
        <input type='hidden' name='productcateno' value='${productcateVO.productcateno }'>
        <input type='hidden' name='pdcontentsno' value='${pdcontentsVO.pdcontentsno }'>
        <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <div class="form-group">   
        <div class="col-md-12">
          <input type='file' class="form-control input-lg" name='fnameMF'  
              value='' placeholder="파일 선택">
        </div>
      </div>
 
      <DIV class='content_bottom_menu'>
        <button type="submit" class="btn btn-info">변경된 썸네일 저장</button>
        <button type="button" onclick="location.href='./list.do?productcateno=${productcateVO.productcateno}'" class="btn btn-info">취소[목록]</button>
      </DIV>
    </FORM>
  </DIV>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html> 
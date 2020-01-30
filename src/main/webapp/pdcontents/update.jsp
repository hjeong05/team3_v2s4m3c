<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head> 
 
 <script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  };
</script>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
 
  <ASIDE style='float: left;'>
    <A href='../productcate/list.do'>카테고리 그룹</A> > 
    <A href='./list.do?productcateno=${productcateno }'>${productcateVO.name }</A> >
    수정
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href='./list.do?productcateno=${param.productcateno }'>목록</A>
    <!-- <span class='menu_divide' >│</span> --> 
  </ASIDE> 
 
  <div class='menu_line'></div>
  <FORM name='frm' method='POST' action='./update.do' class="form-horizontal">
      <input type='hidden' name='productcateno' value='${productcateVO.productcateno }'>
      <input type='hidden' name='pdcontentsno' value='${pdcontentsVO.pdcontentsno }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <div class="form-group">   
        <label class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='title' value='${pdcontentsVO.title}' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='content' id='content' rows='10'>${pdcontentsVO.content}</textarea>
        </div>
      </div>
      
      <div class="form-group">   
        <label class="col-md-1 control-label"><span style='font-size: 0.99em;'>검색어</span></label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' value='${pdcontentsVO.word }' placeholder="검색어">
        </div>
      </div>
      
      <DIV style='text-align: right;'>
        <button type="submit" class="btn btn-info">변경된 내용 저장</button>
        <button type="button" onclick="location.href='./list.do?productcateno=${productcateVO.productcateno}'" class="btn btn-info">취소[목록]</button>
      </DIV>
  </FORM>
 
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
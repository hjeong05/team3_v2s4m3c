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



</head>
<body>
<jsp:include page="/menu/top.jsp" flush='false' />

  <ASIDE style='float: left;'>
      <A href='./mkmember/list.do'>회원 목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
 
  <div class='menu_line'></div>
    
  <DIV class='title_line'>회원등급 변경</DIV> 
 
  <FORM name='frm' id='frm' method='POST' action='./grade_update.do' class="form-horizontal">
    <input type="hidden" name="memberno" value="${param.memberno }">
    <input type="hidden" name="memcateno" value="${param.memcateno }">
    <div class="form-group">
      <label class="col-md-6 control-label">현재 등급 : </label>    
      <div class="col-md-6">
        ${param.name }
      </div>
    </div>   
                    
    <div class="form-group">
      <label class="col-md-6 control-label">이동할 등급</label>    
      <div class="col-md-6">
        <select name="new_memcateno" id="new_memcateno">
          <option value="1">우수회원</option>
          <option value="2">일반회원</option>
          <option value="3">정지회원</option>
      </select>
      </div>
    </div>    
    
    <div class="form-group">
      <div class="col-md-offset-6 col-md-6">
        <button type="submit" class="btn btn-primary btn-md">변경</button>
        <button type="button" onclick="location.href='./list_all.do'" class="btn btn-primary btn-md">취소</button>
 
      </div>
    </div>   
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
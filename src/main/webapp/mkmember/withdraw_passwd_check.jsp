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
      <A href='./mkmember/list.do'>회원 탈퇴</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
  </ASIDE> 
 
  <div class='menu_line'></div>
    
  <DIV class='title_line'>회원 탈퇴</DIV> 
 
  <FORM name='frm' id='frm' method='POST' action='./withdraw_passwd_check.do' class="form-horizontal">
    <input type="hidden" name="memberno" value="${param.memberno }">
    <input type="hidden" name="memcateno" value="${param.memcateno }">
    <div class="form-group">
      탈퇴를 위해 비밀번호를 입력해주세요.
    </div>   
    <div class="col-md-6">
        <input type='password' class="form-control input-md" name='passwd' id='passwd' value='' required="required" style='width: 30%;' placeholder="패스워드">
    </div>
    
    <div class="form-group">
      <div class="col-md-offset-6 col-md-6">
        <button type="submit" class="btn btn-primary btn-md">탈퇴</button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}'"  class="btn btn-primary btn-md">취소</button>
 
      </div>
    </div>   
</FORM>

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
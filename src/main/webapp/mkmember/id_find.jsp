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
      <A href='./mkmember/list.do'>아이디 찾기</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
  </ASIDE> 
 
  <div class='menu_line'></div>
    
  <DIV class='title_line'>아이디 찾기</DIV> 
 
  <FORM name='frm' id='frm' method='POST' action='./id_find.do' class="form-horizontal">
    <div class="message">
      가입시 입력한 이름과 전화번호를 입력해주세요.<br><br>   
      <div class="form-group">
        <label class="col-md-4 control-label">아이디</label>
        <div class="col-md-8">
        <input type="text" class="form-control input-md" name='mname' id='mname' value='' required="required" style='width: 30%; margin: 0px auto;' placeholder="아이디">
        </div>
      </div>
      <div class="form-group">
        <label class="col-md-4 control-label">전화번호</label>
        <div class="col-md-8">
        <input type="text" class="form-control input-md" name='tel' id='tel' value='' required="required" style='width: 30%; margin: 0px auto;' placeholder="전화번호">
        </div>
      </div>
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
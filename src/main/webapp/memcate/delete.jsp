<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  // FK 값에 따른 contents 삭제
  function delete_by_memcateno() {
    frm_delete_by_memcateno.submit();
  }
</script>
 
</head> 
 
<body>

<div style="display: table; width: 100%; height: 300px">
<div style="display: table-cell; vertical-align: middle;">

<FORM name="frm_delete_by_memcateno" method="POST"
            action="../mkmember/delete_by_memcateno.do">
  <input type="hidden" name='memcateno' value='${memcateVO.memcateno }'>
</FORM>

<FORM name='frm' method='POST' action='./delete.do'>
  <input type='hidden' name='memcateno' value='${memcateVO.memcateno }'>
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none' style="font-weight: bold;">
        삭제될 카테고리 그룹 이름: ${memcateVO.name }
      </li>
      
    <c:if test="${count_by_memcateno > 0 }">
      <li class='li_none' style="text-decoration: underline;">
        해당 등급 회원 ${count_by_memcateno } 명이 발견되었습니다.<br>
      </li>
      <li class='li_none'>
        해당 등급 회원을 삭제해야 카테고리 그룹을 삭제할 수 있습니다.<br>
        <span style="color: #FF0000">회원이 삭제되면 복구 할 수 없습니다.</span><br>
        해당 등급 회원을 삭제하시겠습니까?
        <button type="button" onclick="delete_by_memcateno();" class="btn btn-info">예(삭제 진행)</button>
      </li>
    </c:if>
      
      <li class='li_none'>
        삭제하면 복구 할 수 없습니다.<br>
        삭제를 진행 하시겠습니까?
      </li>
      <li class='li_right'>
      <c:if test="${count_by_memcateno == 0 }">
        <button type="submit" class="btn btn-info">삭제 진행</button>
      </c:if>
        <button type="button" onclick="window.close();" class="btn btn-info">닫기</button>
      </li>         
    </ul>
  </fieldset>
</FORM>
 
</div>
</div>
</body>
 
</html> 
  
   
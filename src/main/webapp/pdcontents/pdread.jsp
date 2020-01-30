<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

  <!-- jQuery -->
  <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

  <!-- Fotorama -->
  <link href="fotorama.css" rel="stylesheet">
  <script src="fotorama.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
  $(".nav-tabs a").click(function(){
    $(this).tab('show');
  });
});
</script>

<script type="text/javascript">
 

</script>
</head>

<body>
<c:set var="productcateno" value="${productcateVO.productcateno}" />
<c:set var="pdcontentsno" value="${pdcontentsVO.pdcontentsno }" />

<jsp:include page="/menu/top.jsp" flush='false' />
  
  <div class='menu_line'></div>

  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="pdcontentsno" value="${pdcontentsno}">
      <fieldset class="fieldset">
          <DIV style='padding-top: 8px; '>
         
        <!-- 상세 하단 -->
        <DIV style='position: relative; margin-top: 400px; min-width: 1180px; padding-top: 64px;'>
        
            <li class="li_none" style='font-weight: bold; font-size: 20px; border-bottom: solid 1px #AAAAAA;'>상세설명</li>
            <DIV>${pdcontentsVO.content }</DIV>
            <DIV style='text-decoration: none;'>
              <span class="glyphicon glyphicon-search"></span>
              검색어(키워드): ${pdcontentsVO.word }
            </DIV>
          <li class="li_none" style='border-bottom: solid 1px #AAAAAA;'>${productcateVO.name } 목록
           </li>
           <DIV style='position: relative;' >
              <c:forEach var="pdcontentsVO" items="${pdcontents_list }">
              <c:set var="pdcontentsno" value="${pdcontentsVO.pdcontentsno }" />
                <a href="./read.do?pdcontentsno=${pdcontentsno}" >${pdcontentsVO.title}</a><br>
              </c:forEach>
           </DIV>
        </DIV>
        </DIV>
  
      </fieldset>
  </FORM>
        
  <!-- 댓글 영역 시작 -->
  <DIV style='width: 80%;'>
    <HR>
    <FORM name='frm_reply' id='frm_reply'>
      <input type='hidden' name='pdcontentsno' id='pdcontentsno' value='${pdcontentsno}'>
      <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
      
      <textarea name='content' id='content' style='width: 100%; height: 60px;' placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
      <input type='password' name='passwd' id='passwd' placeholder="비밀번호">
      <button type='button' id='btn_create' onclick="create_pdreply();">등록</button>
    </FORM>
    <HR>
    <DIV id='panel_reply'>
    
    </DIV>
    
  </DIV>
  
  <!-- 댓글 영역 종료 -->      
        
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>

</html>
  
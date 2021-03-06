<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>delete_by_pdcontentsno_msg.jsp</title>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
</head> 
<body>

<jsp:include page="/menu/top.jsp" flush='false' />
<DIV  style='display: table; width: 100%; height: 300px;'>
<DIV style='display: table-cell; vertical-align: middle;'>
 
<DIV class='title_line'>알림</DIV>
 
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count > 0 }">
          <LI class='li_none'>
            <span class='span_success'>첨부 파일을 삭제했습니다.</span>
          </LI>
          <LI class='li_none'>
            <button type='button' 
                        onclick="location.href='../pdcontents/delete.do?pdcontentsno=${param.pdcontentsno}&productcateno=${param.productcateno}'"
                        class="btn btn-info">계속 삭제 진행</button>
            <button type='button' 
                        onclick="location.href='../pdcontents/read.do?productcateno=${param.productcateno}&cpdcontentsno=${param.pdcontentsno }'"
                        class="btn btn-info">삭제 중지</button>                                                
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>
            <span class='span_fail'>첨부 파일 삭제에 실패했습니다.</span>
          </LI>
          <LI class='li_none'>
            <button type='button' 
                        onclick="history.back();"
                        class="btn btn-info">재시도</button>
            <button type='button' 
                        onclick="location.href='../pdcontents/read.do?productcateno=${param.productcateno}&pdcontentsno=${param.pdcontentsno }'"
                        class="btn btn-info">삭제 중지</button>                        
          </LI>
        </c:otherwise>
      </c:choose>
     </UL>
  </fieldset>
 
</DIV>

</DIV>
</DIV> 

<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
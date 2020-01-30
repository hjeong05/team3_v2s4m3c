<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
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

<script type="text/javascript">
</script>
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <ASIDE style='float: left;'>
    전체 보기 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <!--  <span class='menu_divide' >│</span> -->
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 15%;"></col>
        <col style="width: 20%"></col>
        <col style="width: 40%"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>상품명</th>
          <th style='text-align: center;'>이미지</th>          
          <th style='text-align: center;'>추천</th>
          <th style='text-align: center;'>기타</th>
        </tr>
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="pdcontentsVO" items="${list }">
          <c:set var="pdcontentsno" value="${pdcontentsVO.pdcontentsno }"/>
          <c:set var="fname" value="${pdcontentsVO.fname.toLowerCase() }" />
          <tr> 
            <td style='text-align: center;'>${pdcontentsVO.rdate.substring(0, 10)}</td>
            <td>
              <a href="./read.do?pdcontentsno=${pdcontentsno}">${pdcontentsVO.title}</a>
            </td>
            
            <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${fname.endsWith('jpg') || fname.endsWith('png') || fname.endsWith('gif')}">
                  <a href="./read.do?pdcontentsno=${pdcontentsno}"><IMG src="./storage/${pdcontentsVO.thumb }"></a>
                </c:when>
                <c:otherwise>
                  ${pdcontentsVO.fname}
                </c:otherwise>
              </c:choose>
            </td> 
            
            <td style='text-align: center;'>${pdcontentsVO.recom}</td>
            <td style='text-align: center;'>
              <a href="./update.do?pdcontentsno=${pdcontentsno}"><img src="./images/update2.png" title="수정" border='0'/></a>
              <a href="./delete.do?pdcontentsno=${pdcontentsno}"><img src="./images/delete2.png" title="삭제"  border='0'/></a>
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
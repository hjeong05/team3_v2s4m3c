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
<!--  <script type="text/javascript">
  function price_txt(price  
    DecimalFormat df = new DecimalFormat("#,###,###"); // 생성자
    var tag ="";
    tag += df.format(price);
    
    $('#price_panel').html(tag);
}
</script> -->
</head>
 
<body>
<jsp:include page="/menu/top.jsp" flush='false' />
  <form name='frm' id='frm' method='get' action='./list.do'>
    <input type='hidden' name='productcateno' value='${productcateVO.productcateno }'>
    
    <ASIDE style='float: left;'>
      <A href='../categrp/list.do'>카테고리 그룹</A> > 
      <A href='./list.do?categrpno=${productcateVO.productcateno}'>${productcateVO.name }</A>
      <c:if test="${param.word.length() > 0 }">
        > [${param.word }] 검색 목록 (${search_count } 건)
      </c:if>
    </ASIDE>
    <ASIDE style='float: right;'>
      <A href="javascript:location.reload();">새로고침</A>
      <%-- <c:if test="${sessionScope.id_admin != null}"> --%>
        <span class='menu_divide' > | </span>
        <A href='./create.do?productcateno=${productcateVO.productcateno }'>등록</A>
    <%--   </c:if> --%>
      
      <c:choose>
        <c:when test="${param.word != '' }">
          <input type='text' name='word' id='word' value='${param.word }' 
                     style='width: 35%;'>
        </c:when>
        <c:otherwise>
          <input type='text' name='word' id='word' value='' style='width: 35%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list.do?productcateno=${productcateVO.productcateno}'">검색 취소</button>  
      </c:if>
    </ASIDE> 
  </form>
  <DIV class='menu_line' style='clear: both;'></DIV>
  <DIV>
  
  <DIV class="content_body">
    <c:forEach var="pdcontentsVO" items="${list }">
      <c:set var="pdcontentsno" value="${pdcontentsVO.pdcontentsno }" />
      <c:set var="fname" value="${pdcontentsVO.fname.toLowerCase() }" />

      <DIV style="width: 23%; float: left; margin: 0.5%; padding: 0.5; background-color: #EEEFFF;">
        <c:choose>
          <c:when test="${fname.endsWith('jpg') || fname.endsWith('png') || fname.endsWith('gif')}">
            <DIV style='text-align: center;'><a href="./read.do?pdcontentsno=${pdcontentsno}&nowPage=${param.nowPage}" ><IMG src="./storage/${pdcontentsVO.thumb }"></a></DIV>
          </c:when>
          <c:otherwise>
             ${pdcontentsVO.fname}
          </c:otherwise>
        </c:choose> <br>
        <a href="./read.do?pdcontentsno=${pdcontentsno}&nowPage=${param.nowPage}" style='font-weight: bold; font-size: 1.2em;'>${pdcontentsVO.title}</a> 
        <br>
        ${pdcontentsVO.rdate.substring(0, 10)}<br> 
        <span style='font-weight: bold;'>${pdcontentsVO.price} 원</span><br>
        추천 수 ${pdcontentsVO.recom}<br> 
        <%-- <c:if test="${sessionScope.id_admin != null}"> --%>
        <a  href="./update.do?pdcontentsno=${pdcontentsno}&productcateno=${productcateVO.productcateno}">
          <img src="./images/update2.png" title="수정" border='0' /></a> 
        <a href="./delete.do?pdcontentsno=${pdcontentsno}&productcateno=${productcateVO.productcateno}">
          <img src="./images/delete2.png" title="삭제" border='0' /></a> 
        <a href="../pdatfile/create.do?pdcontentsno=${pdcontentsno }&productcateno=${productcateVO.productcateno }">
          <img src="./images/upload2.png" title="파일 업로드" border='0' /></a>
         <%-- </c:if>  --%>
         
          <br>
      </DIV>
    </c:forEach>
  </DIV>
  
  </DIV>
      <DIV class='bottom_menu' style='clear: both;'>${paging }</DIV><!-- 페이징 표시 -->
     
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
 
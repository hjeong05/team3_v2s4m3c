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
  <form name='frm' id='frm' method='get' action='./list.do'>
    <input type='hidden' name='productcateno' value='${productcateVO.productcateno }'>
    <ASIDE style='float: left;'>
      <A href='../productcate/list.do'>카테고리 그룹</A> > 
      <A href='./list.do?productcateno=${productcateVO.productcateno }'>${productcateVO.name }</A>
      <c:if test ="${param.word.length() > 0 }">
        > [${param.word }] 검색 목록 (${search_count } 건)
       </c:if>
    </ASIDE>
    <ASIDE style='float: right;'>
      <A href="javascript:location.reload();">새로고침</A>
      <c:if test = "${sessionScope.id !=null}">
        <span class='menu_divide' >│</span>
        <A href='./create.do?productcateno=${productcateVO.productcateno }'>등록</A>
      </c:if>
      <c:choose>
        <c:when test="${param.word != '' }">
          <input type='text' name='word' id='word' value='${param.word }' style='width:35%;'>
        </c:when>
        <c:otherwise>
          <input type='text' name='word' id='word' value='' style='width:35%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit'>검색</button>
      <c:if test ="${param.word.length() > 0 }">
      <button type='button' 
                 onclick="location.href='./list.do?productcateno=${productcateVO.productcateno}'">검색 취소</button>
      </c:if>
    </ASIDE> 
  </form>
  <DIV class='menu_line' style='clear: both;'></DIV>
  
  <div style='width: 100%;'>
    <table class="table table-striped" style='width: 100%;'>
      <colgroup>
      <c:choose>
        <c:when test="${sessionScope.id !=null}">
          <col style="width: 15%;"></col>
          <col style="width: 60%;"></col>
          <col style="width: 10%;"></col>
          <col style="width: 15%;"></col>
        </c:when>
        <c:otherwise>
          <col style="width: 15%;"></col>
          <col style="width: 75%;"></col>
          <col style="width: 10%;"></col>
        </c:otherwise>
      </c:choose>
      </colgroup>
      
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th style='text-align: center;'>등록일</th>
          <th style='text-align: center;'>제목</th>
          <th style='text-align: center;'>추천</th>
          <th style='text-align: center;'>
          <c:if test = "${sessionScope.id !=null}">기타</c:if>
          </th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="contentsVO" items="${list }">
          <c:set var="pdcontentsno" value="${pdcontentsVO.pdcontentsno }"/>
          <tr> 
            <td style='text-align: center;'>${pdcontentsVO.rdate.substring(0, 10)}</td>
            <td>
              <a href="./read.do?pdcontentsno=${pdcontentsno}&word=${param.word}">${pdcontentsVO.title}</a> 
              ${pdcontentsVO.memberno }
            </td> 
            <td style='text-align: center;'>${pdcontentsVO.recom}</td>
            <c:if test = "${sessionScope.id !=null}">
            <td style='text-align: center;'>
              <a href="./update.do?pdcontentsno=${pdcontentsno}&productcateno=${productcateVO.productcateno}"><img src="./images/update2.png" title="수정" border='0'/></a>
              <a href="./delete.do?pdcontentsno=${pdcontentsno}&productcateno=${productcateVO.productcateno}"><img src="./images/delete2.png" title="삭제"  border='0'/></a>
              <a href="../pdatfile/create.do?pdcontentsno=${pdcontentsno }&productcateno=${productcateVO.productcateno }"><img src="./images/upload2.png" title="파일 업로드"  border='0'/></a>
            </td>
            </c:if>
          </tr>
        </c:forEach>
        
      </tbody>
    </table>
    <br><br>
  </div>
 
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
 
</html>
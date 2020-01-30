<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
        ▷ <A href="../pdcontents/list_all.do">전체글(${total_count })</A>

        <UL style='padding-left: 30px;'>
          <c:forEach var="productcateVO" items="${list }">
            <c:set var="productcateno" value="${productcateVO.productcateno }" />
           <li>
           <A href='../pdcontents/list.do?productcateno=${productcateno }'>${productcateVO.name }</A>(${productcateVO.cnt })
           </li>
          </c:forEach>
        </UL>

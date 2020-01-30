<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="root" value="${pageContext.request.contextPath}" />

<DIV class='container' style='width: 100%;'> 
  <!-- 화면 상단 메뉴 -->
  <DIV class='top_menu'>
    <DIV class='top_menu_label'>1인 가구 요리키트 판매사이트</DIV>
    <NAV class='top_menu_list'>
      <span style='padding-left: 0.5%;'></span>
      <A class='menu_link'  href='${root}' >HOME</A> <span class='top_menu1'> | </span>
      
      <c:choose>
        <c:when test="${sessionScope.id == null}">
          <A class='menu_link'  href='${root}/mkmember/login.do' >Login</A> <span class='top_menu1'> | </span>
        </c:when>
        <c:otherwise>
          ${sessionScope.id } <A class='menu_link'  href='${root}/mkmember/logout.do' >Logout</A> <span class='top_menu1'> | </span>
        </c:otherwise>
      </c:choose>

      <A class='menu_link'  href='${root}/productcate/list.do'>카테고리 그룹</A> <span class='top_menu1'> | </span>    
      <A class='menu_link'  href='${root}/pdcontents/list_all.do'>전체글</A> <span class='top_menu1'> | </span>    
      <A class='menu_link'  href='${root}/mkmember/list.do'>회원목록</A> <span class='top_menu1'> | </span>  
      <!-- 관리자 로그인 -->
      [
      <c:choose>
        <c:when test="${sessionScope.id_admin == null}">
          <A class='menu_link'  href='${root}/admin/login.do' >관리자 Login</A>
        </c:when>
        <c:otherwise>
          ${sessionScope.id_admin } <A class='menu_link'  href='${root}/admin/logout.do' >관리자 Logout</A>
          <span class='top_menu1'> | </span>    
          <A class='menu_link'  href='${root}/reply/list.do'>전체 댓글</A>
        </c:otherwise>
      </c:choose>
      ]          
    </NAV>
  </DIV>
  
  <!-- 화면을 2개로 분할하여 좌측은 메뉴, 우측은 내용으로 구성 -->  
  <DIV class="row" style='margin-top: 2px;'>
    <DIV class="col-md-2"> <!-- 메뉴 출력 컬럼 -->
      <img src='${root}/menu/images/mealkit01.jpg' style='width: 100%;'>
      <div style='margin-top: 5px;'>
        <img src='${root}/menu/images/cat.png' style='width:40%;'><span style='font-weight: bold; color: purple;'> MealKit</span>
      </div>
       <!-- Spring 출력 카테고리 그룹 / 카테고리 -->
       <c:import url="/productcate/list_for_user.do" />
    </div>
      
    <DIV class="col-md-10 cont">  <!-- 내용 출력 컬럼 -->  
   
<DIV class='content' style='width: 90%;'>
 
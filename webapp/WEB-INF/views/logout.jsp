<!--  ********************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<!--  ********************************************************* -->
	<!--  현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다, 라고 설정한다. -->
	<!--  현재 이 JSP페이지는 UTF-8방식으로 인코딩한다. -->
	<!--  UTF-8 인코딩 방식은 한글을 포함한 전세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>   
<%@include file="common_login_user_info.jsp" %>

<%
//---------------------------------------------
//HttpSession 객체에 저장된 로그인 아이디 삭제하기
//--------------------------------------------- 
  session.removeAttribute("admin_id");
%>
<script>
      location.replace("${requestScope.croot}/loginForm.do" )
</script>
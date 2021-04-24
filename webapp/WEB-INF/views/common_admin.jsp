
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    태그 칼라
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm -->    
    
<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "bodyBgcolor" 로 문자 "E3E6F0"  를 저장하기
----------------------------------------------------------------------------------------------------- -->
<c:set var="bodyBgcolor" value="#E3E6F0"  scope="request"/>
<!--         키값                 저장          HttpServletRequest객체에 저장했다 -->

<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "thBgcolor" 로 문자 "E3E6F0"  를 저장하기
----------------------------------------------------------------------------------------------------- -->
<c:set var="thBgcolor" value="#F297B3" scope="request"/>

<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "tdBgColor" 로 문자 "E3E6F0"  를 저장하기
----------------------------------------------------------------------------------------------------- -->
<c:set var="tdBgcolor" value="#EBEBF1" scope="request"/>


<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "croot" 로 문자 "/z_spring"  를 저장하기
/z_spring 프로젝트명을 컨텍스트 루트라 부른다.
----------------------------------------------------------------------------------------------------- -->
<c:set var="croot" value="<%=request.getContextPath()%>" scope="request"/>

<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "croot" 로 문자 "<%=Math.random()%>"  를 저장하기
/z_spring 프로젝트명을 컨텍스트 루트라 부른다.
----------------------------------------------------------------------------------------------------- -->
<c:set var="randomNum" value="<%=Math.random()%>" scope="request"/>



<!-- ========================================================= -->
<!--           관리자 용 css                  -->
<!-- ========================================================= -->

<!--  JQUERY 수입  -->
<script src="${requestScope.croot}/resources/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="${requestScope.croot}/resources/jQuery.validity.js" type="text/javascript"></script>

<!-- CSS 수입  -->
<link href="${requestScope.croot}/resources/common.css?ver=<%=Math.random()%>" rel="stylesheet" type="text/css">
<%-- <link href="${requestScope.croot}/resources/common2.css?ver=<%=Math.random()%>" rel="stylesheet" type="text/css">--%>
<script src="${requestScope.croot}/resources/common.js?ver=<%=Math.random()%>" type="text/javascript"></script>

<!--  날짜 관련 공용함수  수입 -->
<script src="${requestScope.croot}/resources/common_jquery_func.js?ver=<%=Math.random()%>" type="text/javascript"></script>
<script src="${requestScope.croot}/resources/dateForm.js?ver=<%=Math.random()%>" type="text/javascript"></script>

<!--  Bootstrap v3.3.7 버전 수입  -->
<link href="${requestScope.croot}/resources/css/bootstrap.css?ver=<%=Math.random()%>" rel ="stylesheet" type="text/css">
<script src="${requestScope.croot}/resources/js/bootstrap.js?ver=<%=Math.random()%>" type="text/javascript"></script>

<!--  CSS  수입 -->
<link href="${requestScope.croot}/resources/css/style.css" rel ="stylesheet" type="text/css">
<link href="${requestScope.croot}/resources/css/Signln.css" rel ="stylesheet" type="text/css">


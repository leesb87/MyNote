<!--  ********************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<!--  ********************************************************* -->
	<!--  현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다, 라고 설정한다. -->
	<!--  현재 이 JSP페이지는 UTF-8방식으로 인코딩한다. -->
	<!--  UTF-8 인코딩 방식은 한글을 포함한 전세계 모든 문자열을 부호화할 수 있는 방법이다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->


<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언-->
<!-- 아래 코딩이 들어가야 JSTL의 C 코어 태그를 사용할 수 있다. -->
<!-- http://java.sun.com      /jsp/jstl/core/a.do         서울시 종로구 혜화동 90-1 / 1번째/책상   -->
<!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~   -->
<!--                       URL                                                  URL                -->
<!--                         ~~~~~~~~~~~~~~~~~~~~                                     ~~~~~~~~~~~~~-->
<!--                                   URI                                                  URI    -->
<!-- 
    --------------------------------
    JSTL 이란? 
    --------------------------------
           자카르타라는 단체에서 만든 사용자 정의 태그를 말한다.
           즉 자바 문법을 HTML 과 같은 태그 형대로 표현한다
           HTML 과 같은 태그 형태로 표현하면 뒤에서 자바 문법으로 바뀌어 실행된다.
           JSTL 사용 장점
               -태그 형태이므로 디자이너 퍼블리셔,초급 개발자가 접근이 쉽다.
               -왠만하면 큰 에러가 아닌 이상 화면에 멈추지 않는다.
               -NULL 처리에서 관대하다. 즉 NULL에 대해 민감한 반응을 보이지 않는다. 
           JSTL 은 EL 과 같이 쓰인다.               
       ------------------------------------
       EL(=Expression Language=표현 언어) 이란?
       ------------------------------------
        => 자바영역의 데이터를 JSP 페이지에 표현하는 언어이다.
        => EL 문법 형식
        ------------------
         달러{EL문법}
        ------------------        
        => EL  JSP 기술중에 하나이다.
        =><예>HttpServletRequest 객체에 저장된 데이터를 아주 쉽게 표현해서 JSP애 삽입한다. 
                   -------------------------------------------------------                  
                   자바로 JSP 페이지에서 HttpServletRequest 객체에 "keyword" 란 키값으로 
                   저장된 놈을 꺼내서 div 태그안에 삽입하는 경우 아래처럼 하면된다.
                   -------------------------------------------------------
                       <자바표기   String keyword = (String)request.getAttribute("keyword");      
                          
                           <div> =keyword  </div> 
                       자바표기>    
                   -------------------------------------------------------
                   EL 문법ㅇ로 JSP 페이지에서 HttpServletRequest 객체에 "keyword" 란 키값으로 
                   저장된 놈을 꺼내서 div 태그안에 삽입하는 경우 아래처럼 하면된다.
                   심지어 아래 코딩에서 requestScope. 을 생략해도 된다.
                   -------------------------------------------------------
                   <div> ${requestScope.keyword} </div>
                   <div> ${keyword} </div>
                    
 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 <%--
 ----------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 데이터를 저장하기
-----------------------------------------------------------------------------------------------------
  <c:set var="키값" value="데이터" scope="request"/>
        ----------------------------------------------------
	    위 [JSTL 커스텀 태그]를 JSP 페이지에서 자바 법으로 표현하면 아래와 같다.
	    request.setAttribute("키값", "데이터" ); 
        ----------------------------------------------------
 
 ----------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 데이터를 꺼내기
-----------------------------------------------------------------------------------------------------
  ${request.scope.키값}              

 ----------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpSession 객체에 키값 데이터를 저장하기
-----------------------------------------------------------------------------------------------------
  <c:set var="키값" value="데이터" scope="session"/>
        ----------------------------------------------------
	    위 [JSTL 커스텀 태그]를 JSP 페이지에서 자바 법으로 표현하면 아래와 같다.
	    session.setAttribute("키값", "데이터" ); 
        ----------------------------------------------------
 
 ----------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpSession 객체에 키값 데이터를 꺼내기
-----------------------------------------------------------------------------------------------------
  ${request.scope.키값}   

--%> 
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
<c:set var="thBgcolor" value="white" scope="request"/>

<!------------------------------------------------------------------------------------------------------- 
[JSTL 커스텀 태그]를 사용하여 HttpServletRequest 객체에 키값 "tdBgColor" 로 문자 "E3E6F0"  를 저장하기
----------------------------------------------------------------------------------------------------- -->
<c:set var="tdBgcolor" value="#EBEBF1" scope="request"/>


<!--#FFFFFF  #A0A3C0

http://localhost:8088/z_spring/loginForm.do
----------------
 대외적인주소
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
URL 주소 => 호출하는 자원의 위치
--------------------------------------
                   포트번호        서버내부의 주소
                     ----          ------------
http://www.naver.com:8088/z_spring/loginForm.do
--------------------      --------    
 유일한 대외적인 주소    프로젝트명   
                         ----------------------
                           URL 주소
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
    http://www.naver.com   => 도메인. 전 세계의 유일한 서버 주소
    :8088                  => 서버가 설치된 운영체제로 부터 부여 받은 포트번호
    /z_spring/loginForm.do => 서버내부의 자원주소
-->

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

<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<!--JSP 페이이에서 사용할 [자바스크립트 파일], [CSS 파일] 수입하기 -->
<!--JSP 페이이에서 사용할 [Jquery API] 수입 -->
<!--JSP 페이이에서 사용할 [공용 함수 내장된 common.js 파일] 수입  -->
<!--/z_spring 프로젝트명을 컨텍스트 루트라 부른다. -->
<!--mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm-->
<script src="${requestScope.croot}/resources/jquery-1.11.0.min.js" type="text/javascript"></script>

<script src="${requestScope.croot}/resources/jQuery.validity.js" type="text/javascript"></script> 

<link href="${requestScope.croot}/resources/common.css?ver=<%=Math.random()%>" rel="stylesheet" type="text/css">
<script src="${requestScope.croot}/resources/common.js?ver=<%=Math.random()%>" type="text/javascript"></script>
<script src="${requestScope.croot}/resources/common_jquery_func.js?ver=<%=Math.random()%>" type="text/javascript"></script>

<link href="${requestScope.croot}/resources/css/style.css" rel ="stylesheet" type="text/css">
<link href="${requestScope.croot}/resources/css/Signln.css" rel ="stylesheet" type="text/css">





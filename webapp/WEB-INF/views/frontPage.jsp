<!--  ******************************************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 현재 JSP페이지에서 사용할 java클래스 수입하기 -->
<%@ page import="java.util.*" %>
		
<!DOCTYPE html>
<html>

<!-- ******************************************************* -->
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여      -->
<!-- 					  common.jsp파일 내의 소스를 삽입하기 -->
<!-- ******************************************************* -->

<!-- jsp파일이 같은 폴더 안에 없을 경우 include file="/WEB-INF/views/common.jsp"로 경로를 설정하며,
	 해당 파일을 찾을 수 있다.
 --> 
<%@include file="common.jsp" %>

<%-- <%@include file="common.jsp" %> --%>


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" >


<head>

<title>Front Page</title>
	
	<script>
		$(document).ready(function(){
			
			// enterkey 누르면 search() 함수 작동
			$(".keyword").keypress(function(event){
				if ( event.which == 13 ) {
					$('.keywordSearch').click();
					return false;
				}
			});
			
		});

		function search( ){
			
			 if( isEmpty($("[name=keyword]")) ){
				alert("검색 조건이 비어있어 검색할 수 없습니다.");
				$("[name=keyword]").val("");
				return;
			}
			
			//-----------------------------------
			// 키워드의 앞뒤 공백을 제거하기
			//-----------------------------------
			var keyword = $("[name=keyword]").val();
			keyword = keyword.trim();
			
			//alert( "front 페이지에서 들어온 키워드=> "+ keyword );
			
			$("[name=keyword]").val(keyword);
			
			//-----------------------------------
			// name=dictListForm 을 가진  form 태그의 action 값의 URL로 웹서버에 접속하기
			// 이동 시 form 태그안의 모든 입력 양식이 파라미터값으로 전송된다.
			//-----------------------------------
			document.dictListForm.submit();
	
		}
		 //==================================
	    // [ 홈 ] 이동하는 함수 선언
	    //==================================
		function goFrontPage(){
			document.frontPage.submit();
		}
		//==================================
	    // [ 검색 목록 ] 이동하는 함수 선언
	    //==================================	
	      function goDictList(){
	    		document.dictListForm.submit();
		}
	    //==================================
	    // [ 로그인 ] 이동하는 함수 선언
	    //==================================	
	    function goLoginForm(){
			document.loginForm.submit();
		}
	    //==================================
	    // [ 로그아웃 ] 이동하는 함수 선언
	    //==================================	
	    function goLogout(){
			document.logout.submit();
		}
	    //==================================
	    // [ 회원가입 ]  이동하는 함수 선언
	    //==================================
		function goUserRegForm(){
			document.userRegForm.submit();
		}
		//==================================
	    // [ 새글쓰기 ]  이동하는 함수 선언
	    //==================================
		function goDictRegForm(){
			document.dictRegForm.submit();
		}
		//==================================
	    // [ 관리자페이지 ]  이동하는 함수 선언
	    //==================================
		function goAdminForm(){
			document.adminForm.submit();
		}
		//==================================
	    // [ 나의노트 ]  이동하는 함수 선언
	    //==================================
		function goMyNote(){
			document.myNoteForm.submit();
		}
		//==================================
	    // [ 회원정보수정 ]  이동하는 함수 선언
	    //==================================
		function goUserModify(){
			document.userModifyForm.submit();
		}
		

		
	</script>
<style>

.bg {
	  /* width: 500px;
	  height: 500px; */
	  background-image: url("${pageContext.request.contextPath}/resources/img/background_01.png");
	  background-size: cover;
	  background-position: center;
	  background-repeat: no-repeat;
 }

/* .nav-link{
	text-align: right;
 } */

</style>
</head>
<body><center>
	   		<!-- 관리자 모드 안내 방법2 -->
			 <div class="alert alert-light alert-dismissible fade show" role="alert">
				  <%--   <h3 style="text-align: left;"  class="txt01"> ${sessionScope.admin_id} 님 '관리자모드'로 접속하셨습니다! </h3> --%>
				  <!-- 관리자로 접속 하였을 때 보여주는 멘트 -->
				  <c:if test="${!empty sessionScope.admin_id}">          
				   <h5 style="text-align: left;"  class="txt01">${sessionScope.admin_id} 님 관리자모드로 접속하셨습니다! </h5>
				  </c:if>
				 <!-- 유저로 접속 하였을 때 보여주는 멘트 -->
				  <c:if test="${!empty sessionScope.user_id}">          
				   <h5 style="text-align: left;"  class="txt01">${sessionScope.user_name}님 환영합니다! </h5>
				  </c:if>
				  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
				    <span aria-hidden="true">&times;</span>
				  </button>
			</div> 
			<!--================================================================================================-->
			<!-- 관리자로 접속 하였을 때 관리자 게시판으로 이동 -->
			   <%-- <c:if test="${!empty sessionScope.admin_id}">
			     <li><a href="javascript:goAdminForm();">[회원 멤버 목록]</a></li>
			   </c:if> --%>
			<!-- ---------------------------------------------------------------------------------------------- -->
			<!--  누구로 접속 했는지 확인 하는  히든 태그 선언 -->
			<input type="hidden" name="admin_id" class="admin_id"  value="${sessionScope.admin_id}"/>
			<input type="hidden" name="user_id" class="user_id" value="${sessionScope.user_id}"/>
			<input type="hidden" name="user_name" class="user_name" value="${sessionScope.user_name}"/>
			<input type="hidden" name="acc_read" class="acc_read" value="${sessionScope.acc_read}"/>
			<input type="hidden" name="acc_upDel" class="acc_upDel" value="${sessionScope.acc_upDel}"/>
			<input type="hidden" name="acc_write" class="acc_write" value="${sessionScope.acc_write}"/>   
			<!--================================================================================================-->
			
			
	<!-- 이미지 삽입 -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom">
			<b><a class="navbar-brand" href="javascript:goFrontPage();">MY NOTE</a></b>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
	            <li class="nav-item active">
	             <b><a class="nav-link" href="javascript:goFrontPage();">HOME<span class="sr-only">(current)</span></a></b>
	            </li>
	            <li class="nav-item">
	              <b><a class="nav-link" href="javascript:goLogout();">LogOut</a></b>
	            </li>
	            <li class="nav-item dropdown">
	              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                이동하기
	              </a>
	              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
	              <c:if test="${sessionScope.acc_write eq '0' && not empty sessionScope.user_id && sessionScope.admin_id==null}">
			   		   
			    </c:if>
			    <c:if test="${sessionScope.acc_write eq '1' && not empty sessionScope.user_id && sessionScope.admin_id==null}">	
			            <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
			    </c:if>			
				  <c:if test="${sessionScope.admin_id!=null}">	
			            <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
			    </c:if>	    
	              
	              
	              
	             
				      <a class="dropdown-item" href="javascript:goMyNote();">나의 노트</a>
	               <div class="dropdown-divider"></div>
	               	  <a class="dropdown-item" href="javascript:goUserModify();">회원정보수정</a>	
					  <!-- <a class="dropdown-item" href="javascript:goLogout();">로그아웃</a> -->			
	              </div>
	            </li>
	          </ul>
	        </div>
      </nav>
     
	<div class="jumbotron bg" style="height: 280px; background-color: rgb(35, 67, 105);">
		  <h3 class="text-white display-5"><strong>MY NOTE</strong> 에 오신 것을 환영합니다.</h3>
		  <hr class="my-4">
		  <div style="height: 10px;"></div>
		  <p class="text-white"> 21세기 인터넷 문화의 지식 공유 트렌드 </p>
	</div>
	    <div style="height: 20px;">
		</div>
	<div class="container">
		<!-- 검색기능 -->
		<div class="row">
		    <div class="col">
		    </div>
				<div class="col-6">
					<form name="dictListForm" method="post" action="${requestScope.croot}/dictList.do">
			   			  <div class="input-group is-invalid">
							<input type="text" name="keyword" class="keyword form-control" placeholder="검색어를 입력해주세요" size="50">
							<button type="button" class="keywordSearch btn btn-dark" onClick="search( );">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
	 						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
							</svg>통합검색</button>
							<input type="hidden" name="lang_code" value="0">
							<input type="hidden" class="search_keyword" name="search_keyword" value="단어" checked>
							<!-- <input type="text" name="lang_code" value="0"> -->
						  </div>
					</form>
				</div>
			<div class="col">
		    </div>
		</div>
	</div>
	
	<div class="jumbotron" style="height: 140px; background-color: rgb(255, 255, 255);">
	</div>
	
 	<%-- <div class="container">
		<div class="card-deck">
			  <div class="card border-secondary mb-6">
			  <div class="card-header text-wrap font-weight-bold">나만의 게시물 작성하기</div>
			      <div class="card-body">
				    <p class="card-text">내가 보관하고 싶은 글들과 또는 다른 사람들과 공유하고 싶은 정보를 저장할 수 있습니다.</p>
				    <a href="${requestScope.croot}/dictRegForm.do" class="btn btn-outline-dark">새 게시물 작성</a>
				  </div>
			  </div>
			  <div class="card border-secondary mb-6" >
			  <div class="card-header text-wrap font-weight-bold">게시물 수정/삭제 하기</div>
			      <div class="card-body">
				    <!-- <h5 class="card-title"></h5> -->
				    <p class="card-text">이전에 등록한 게시물을 수정하거나 삭제할 수 있습니다.</p>
				    <a href="${requestScope.croot}/dictUpDelForm.do" class="btn btn-outline-dark">게시물 수정/삭제</a>
				  </div>
			  </div>
			  <div class="card border-secondary mb-3">
			      <div class="card-body">
				    <h5 class="card-title">회원가입하기</h5>
				    <p class="card-text">처음 방문하셨다구요? 회원가입하시면 이용의 혜택이 더 늘어납니다!</p>
				    <a href="${requestScope.croot}/userRegForm.do" class="btn btn-outline-dark btn-sm">회원가입</a>
				  </div>
			  </div> 
		</div>
	</div>  --%>
	<!-- <div class="jumbotron" style="height: 100px; background-color: rgb(255, 255, 255);">
	</div> -->
	<div class="jumbotron text-center mt-5 mb-0 fixed-bottom" style="height:180px; padding-bottom: 0px;"> 
		<h4 class="text-secondary">My Note</h4> 
		<p>My Note's Homepage is powered by <span class="text-primary">NoteHouseMembers</span></p> 
	</div>

		<!-- ============================== -->
		<!-- post 방식으로 이동할 form 태그 --> 
		<!-- ============================== -->	
		<!-- [ 로그인 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="loginForm" method="post" action="${requestScope.croot}/loginForm.do"></form>

		<!-- [ 로그아웃 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="logout" method="post" action="${requestScope.croot}/logout.do"></form>

		<!-- [ 홈 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="frontPage" method="post" action="${requestScope.croot}/frontPage.do"></form>
	
		<!-- [ 회원가입 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="userRegForm" method="post" action="${requestScope.croot}/userRegForm.do"></form>
		
		<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do"></form>
		
		<!-- [ 노트 수정/삭제 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"></form>
		
		<!-- [ 관리자페이지 ] 화면 이동하는 form 태그 선언하기 -->
	    <form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do"></form>   

		<!-- [ 나의 노트 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="myNoteForm" method="post" action="${requestScope.croot}/mynote.do"></form>
		
		<!-- [ 회원정보수정 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="userModifyForm" method="post" action="${requestScope.croot}/user_modify.do"></form>  
	
	
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
		

</body>

</html>
	<!-- <nav class="navbar navbar-default">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">제타위키</a>
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">홈</a></li>
        <li><a href="#">메뉴1</a></li>
        <li><a href="#">메뉴2</a></li> 
        <li><a href="#">메뉴3</a></li> 
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">회원가입</a></li>
        <li><a href="#">로그인</a></li>
      </ul>
    </div>
  </div>
</nav> -->
			<!-- <hr class="my-5"> -->
			<!-- <ul id="nav3" class="nav justify-content-end bg-dark"> 
			<li class="nav-item"> 
			
			<a class="nav-link active" href="#">Home</a></li> 
			<li class="nav-item"> <a class="nav-link" href="#">Link1</a> </li> 
			<li class="nav-item"> <a class="nav-link" href="#">Link2</a> </li> 
			<li class="nav-item"> <a class="nav-link" href="#">Link3</a> </li> 
			<li class="nav-item"> <a class="nav-link" href="#">Link4</a> </li> 
			<li class="nav-item"> <a class="nav-link disabled" href="#">Disabled</a> </li> 
			</ul>
			<div class="dropdown">
			  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			    Dropdown link
			  </a>
			
			  <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
			    <a class="dropdown-item" href="#">Action</a>
			    <a class="dropdown-item" href="#">Another action</a>
			    <a class="dropdown-item" href="#">Something else here</a>
			  </div>
			</div> -->

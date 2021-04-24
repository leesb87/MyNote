<!--  ********************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<!--  ********************************************************* -->
	<!--  현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다, 라고 설정한다. -->
	<!--  현재 이 JSP페이지는 UTF-8방식으로 인코딩한다. -->
	<!--  UTF-8 인코딩 방식은 한글을 포함한 전세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<!-- ******************************************************* -->
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여      -->
<!-- 					  common.jsp파일 내의 소스를 삽입하기 -->
<!-- ******************************************************* -->
<%@include file="common.jsp" %>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" >
<head>

<title>로그인</title>	
<script>
	var errorCnt = 0;		
	   $(document).ready(function(){
		   
       //-------------- 관리자 버튼-----------------------
	   /* $("[name=loginForm] .admin_login").click(function(){	
		   $('[name=id]').val('abc');
		     $('[name=pwd]').val('123');	
		});		
       */
		//--------------------------------------------------
		// name=loginForm 가진 태그 안의 class=login 가진 태그에
		// click 이벤트 발생시 실행할 코드 설정하기
		//--------------------------------------------------
		$("[name=loginForm] .btn_login").click(function(){	
			checkLoginForm();			
		});		
        //---------------------------
        // 클라이언트가 /loginForm.do 로 접속하면서 들고온 쿠키중에 
        // "admin_id" 라는 쿠키명의 쿠키값이 있다면 name=admin_id 를 가진 입려양식에 
        // 쿠키값 넣어주기   EL문으로 클라이언트로 온 쿠키값을 꺼낼 수 있다
        //--------------------------- 
        $("[name=id]").val( "${cookie.user_id.value}" );
        //---------------------------
        // 클라이언트가 /loginForm.do 로 접속하면서 들고온 쿠키중에 
        // "pwd" 라는 쿠키명의 쿠키값이 있다면 name=pwd 를 가진 입려양식에 
        // 쿠키값 넣어주기   EL문으로 클라이언트로 온 쿠키값을 꺼낼 수 있다
        //--------------------------- 
        $("[name=pwd]").val( "${cookie.pwd.value}" );
        //---------------------------
        // 클라이언트가 /loginForm.do 로 접속하면서 들고온 쿠키중에 
        // "admin_id" 라는 쿠키명의 쿠키값이 있다면 name=is_login 가진 태그를 체크하기
        //--------------------------
        $('[name=is_login]').prop(
               "checked"       
               ,${!empty cookie.user_id.value}
        );                      
    });	


       //**********************************************
       //[회원 가입]화면으로 이동하는 함수 선언       
       //**********************************************
       function goUserRegForm(){
   		//--------------------------------------
   		// 웹서버에 memberForm.do URL로 접속하기
   		//--------------------------------------
   		location.replace("${requestScope.croot}/userRegForm.do")
   		}
        //**********************************************
       //[로그인 ]화면으로 이동하는 함수 선언
       //**********************************************
       function goRogingRegForm(){
   		//--------------------------------------
   		// 웹서버에 memberForm.do URL로 접속하기
   		//--------------------------------------
   		location.replace("${requestScope.croot}/loginForms.do")
   		}
    //--------------------------------------------------
	// 로그인 정보 유효성을 체크하고 비동기방식으로 서버와 통신하여
	// 로그인 정보와 암호의 존재여부에 따른 자스코드 실행하기
	//loginForm.do 로  접속 서버쪽에서 실행
	//단순하게 입력 했나 안 했나만 유효성 체크한거기때문에 굳이 서버쪽에서 할 필요없다.
	//--------------------------------------------------

	function checkLoginForm(){
			//입력된 [아이디]를 가져와 변수에 저장
			var admin_id = $('[name=id]').val();
			if(admin_id.split(" ").join("")==""){
				//아이디를 입력 안했거나 공백이 있으면
				//아이디 입력란을 비우고 경고한 후 함수 중단
				alert("아이디를 입력해주세요");
				$('.id').val("");				
				return;
				}	
			
			//입력된 [비밀번호]를 가져와 변수에 저장
			var pwd = $('[name=pwd]').val();
			if(pwd.split(" ").join("")==""){
				//암호를 입력 안했거나 공백이 있으면
				//암호 입력란을 비우고 경고한 후 함수 중단
				alert("비밀번호를 입력해주세요");
				$('.pwd').val("");	
				return;
			}	
		//---------------------------------------------------
		// 현재 화면에서 페이지 이동없이(비동기방식)
		// 서버쪽 loginProc.do 로 접속하여 아이디, 암호의 존재개수를 얻기
		//---------------------------------------------------		
		//alert( $("[name=loginForm]").serialize())
		//return;
		$.ajax({
			//서버 쪽 호출 URL주소 지정
			url : "${requestScope.croot}/loginProc.do"
			// form태그 안의 입력양식 데이터, 즉 파라미터값을 보내는 방법 지정
			,type : "post"
			// 서버로 보낼 파라미터명과 파라미터값을 설정, 즉 입력한 아이디와 암호, 아이디/암호 기억 체크여부를 지정
			,data : $("[name=loginForm]").serialize()
			//,data : {'admin_id':admin_id,'pwd':pwd }
			//-----------------------------------------------------
			//서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
			//익명함수의 매개변수 data에는 서버가 응답한 데이터가 들어온다.			
			//-----------------------------------------------------
			,success : function(admi_user_Cnt){
				//--------------------------------------------------
				// 웹서버가 보낸 데이터가 1이면, 즉 로그인 아이디와 암호가 웹서버의 테이블에 존재하면 
				//--------------------------------------------------
				if(admi_user_Cnt==2){
                   // alert(admi_user_Cnt)
					alert(" 관리자모드  로그인 성공! 접속을 환영합니다." );
					document.adminForm.submit();
				}
				//--------------------------------------------------
				// 웹서버가 보낸 데이터가 1이면, 즉 로그인 아이디와 암호가 웹서버의 테이블에 존재하지 않으면
				//--------------------------------------------------
				else if(admi_user_Cnt==1){
					 // alert(admi_user_Cnt)
					alert("회원모드 로그인 성공! 접속을 환영합니다." );
					location.replace("${requestScope.croot}/frontPage.do")
				
				}
				else{
					alert("입력하신 아이디 또는 암호가 틀립니다.");	
					
				}
			}
			//서버의 응답을 못 받았을 경우에 실행할 익명함수 설정
			,error : function(){
				alert("서버접속 실패");
				}		
			});			
		}
	</script>  

 <style>
/* body{background-image:url('https://jypestorage.blob.core.windows.net/mainbanner/TWICE-banner-980x440(14).jpg');
      background-repeat: no-repeat;
      background-size : cover ;
     
} */
.img{
    width: auto; height: auto;
    max-width: 100px;
    max-height: 100px;
}
.background {
  /* width: 500px;
  height: 500px; */
  background-image: url("${pageContext.request.contextPath}/resources/img/background_01.png");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
}

</style> 

</head>

<body>	
			
		<div class="jumbotron" style="height: 280px; background-color: rgb(35, 67, 105);">
			  <h1 class="text-white display-4"><b>WELCOME!</b></h1>
			  <p class="text-white lead"><b>MyNote</b> 에 오신 것을 환영합니다.</p>
			  <hr class="my-4">
			  <p class="text-white"> "21세기 인터넷 문화의 지식 공유 트렌드" </p>
		</div>
		<div class="jumbotron" style="height:5px;">
		</div>
		
		<div class="jumbotron background">
		<!--  [로그인 정보 입력양식] 내포한 form태그 선언 -->
		<form  name="loginForm" method="post" action="${requestScope.croot}/loginProc.do">
			<div class="container">
			<%-- <img src="${pageContext.request.contextPath}/resources/img/background.png"/> --%>
			  <div class="row">
			    <div class="col-sm-9">
			            <h4><b>SIGN IN</b></h4>
			            <p><b>가입하신 아이디와 비밀번호를 입력해주세요.</b></p>
			      <div class="row">
			        <div class="col-8 col-sm-6">
			         		<input id="authorization_type" name="authorization_type" type="hidden" value="" />
				             <div>             
				                   <p><input class="form-control inp04 id" id="id" name="id" placeholder="아이디" type="text" ></p>
				                   <p><input class="form-control inp04 pwd" id="pwd" name="pwd" placeholder="비밀번호" type="password"></p>
				             </div>
				             <div class="row justify-content-md-center">
				             	   <button type="button" class="btn_login btn btn-dark  btn-sm"><span>SIGN IN</span></button>
				          	 </div>
				          	 <div class="save_id">          
					            <p class="checkbox_01">
					                  <label>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					                       <input type="checkbox" id="isPersistent" name="is_login" value="y" />              
					                       <span class="login_txt">아이디,비밀번호 기억하기</span>
					                  </label>
					            </p>
				          	 </div>   
			          		 <div class="login_txt">
		        			 	<p><span>처음 접속한거 아니신가요?</span><a href="javascript:goUserRegForm();">회원가입 하기</a> </p>
		     		 		 </div>
	             	    	 <!--  <input type="button" class="admin_login" value="관리자 테스트">-->
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
    	</form>
    </div>
    
    
    
    <form name="admi_user_Cnt" >
       <input type="hidden" name="adminCnt" class="adminCnt"  value="${sessionScope.id}" readonly>
    </form> 
    <form name="memberRegForm" method="post" action="${requestScope.croot}/memberRegForm.do">
    </form>
    <form name="loginForms" method="post" action="${requestScope.croot}/loginForm.do">
	</form>
    <form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do">
	</form>
		    
		    
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
		

</body>

</html>

	
<!--  ********************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<!--  ********************************************************* -->
	<!--  현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다, 라고 설정한다. -->
	<!--  현재 이 JSP페이지는 UTF-8방식으로 인코딩한다. -->
	<!--  UTF-8 인코딩 방식은 한글을 포함한 전세계 모든 문자열을 부호화할 수 있는 방법이다. -->

<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>   
<!-- ******************************************************* -->
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여      -->
<!-- 					 common.jsp파일 내의 소스를 삽입하기 -->
<!-- ******************************************************* -->
<%-- <%@include file="common_login_user_info.jsp" %> --%>


<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" >

<head>
<title>회원가입</title>	
	
	
	<script>
	//------------------------------------------------------------------------
	//체크대상이 되는 jQuery객체의 유효성을 판단하여	
	//표시대상이 되는 jQuery객체에 메시지를 변경해주는 메소드 선언 (default메시지가 있는 타입)
	//------------------------------------------------------------------------
		function divChange (
		checkObj			// 체크대상이 되는 jQuery객체 
		, targetObj			// 메시지를 표시할 대상 jQuery객체
		, regExpPattern		// 유효성체크 표현식 ( /^[a-z][a-z0-9]{4,9}$/ 등)
		, normalHtml		// ★입력값이 없을 때 표시할 html구문 (default)
		, passHtml			// 유효성체크에 걸리지 않을 때 표시할 html구문
		, errorHtml			// 유효성체크에 걸릴 때의 에러를 표시할 html구문

		){
			
		try{
				var checkStr = checkObj.val();

				if( checkStr == "" || checkStr == null || checkStr == undefined ){
					targetObj.html(normalHtml); return; }

				var regExp = new RegExp(regExpPattern);

				if( regExp.test( checkStr )==true ){targetObj.html(passHtml); 	}
				else{ targetObj.html(errorHtml); }
			
			}catch(e){
				alert("관리자에게 문의하십시오.")
				//alert("divChange 함수호출 시 에러발생! 체크대상, 표현대상 jQeury객체와 표현식, 비오류/오류html구문을 확인해 주십시오."+ e.message);
			}
		}


	//------------새 비밀번호 유효성 검사 --------------------------------------------------
		function divChange1 (
				checkObj1           // 현재 비밀번호
				, obj				// 현재 비밀번호와 일치하는 매개 변수
				, checkObj2			// 새 비밀번호
				, targetObj			// 새 비밀번호 아래 기본 문구가 표시되는 class
				, regExpPattern		// 패턴식
				, normalHtml		// <p class="+"detxt mt10>영문 대소문, 숫자 포함(6~13자리)</p>
				, passHtml			// 유효성체크에 걸리지 않을 때 표시할 ※사용에 적합한 비밀번호 문구
				, errorHtml1		// 현재 비밀번호와 일치 하지 않을 때 에러를 표시할 html구문
				, errorHtml2		// 새 비밀번호 유효성체크에 걸릴 때의 에러를 표시할 html구문

		){
			try{
					var checkStr1 = checkObj1.val();
					var checkStr2 = checkObj2.val();
					
					if( checkStr1 == "" || checkStr1 == null || checkStr1 == undefined  || checkStr1 != obj ){
						targetObj.html(errorHtml1); return; }
					
					else if( checkStr2 == "" || checkStr2 == null || checkStr2 == undefined ){
						targetObj.html(normalHtml); return; }
					
					var regExp = new RegExp(regExpPattern);

					if( regExp.test( checkStr2 )==true ){targetObj.html(passHtml); 	}
					else{ targetObj.html(errorHtml2); }
				
			}catch(e){
					alert("관리자에게 문의하십시오.")
					//alert("divChange 함수호출 시 에러발생! 체크대상, 표현대상 jQeury객체와 표현식, 비오류/오류html구문을 확인해 주십시오."+ e.message);
			}
		}

	//----------------------------------------비밀번호 재확인 문구-------------------------------------------- 
		function divChange2 (
				checkObj			// 체크대상이 되는 jQuery객체 
				,checkObj1           // 체크대상가 비교할 jQuery객체
				, targetObj			// 메시지를 표시할 대상 jQuery객체
				, regExpPattern		// 유효성체크 표현식 ( /^[a-z][a-z0-9]{4,9}$/ 등)			
				, normalHtml		// ★입력값이 없을 때 표시할 html구문 (default)
				, passHtml			// 비밀번호 일치할 경우 뜨는 html구문
				, errorHtml			// 비밀번호가 일치하지 않을 경우 에러를 표시할 html구문
		
				){
				try{
						var checkStr = checkObj.val();

						var checkStr1 = checkObj1.val();

						if( checkStr == "" || checkStr == null || checkStr == undefined ){

							targetObj.html(normalHtml); return; }	

						var regExp = new RegExp(regExpPattern);
						 
						    if( checkStr == checkStr1){					
							        targetObj.html(passHtml); 
							}
							else if(checkStr != checkStr1){
								
								    targetObj.html(errorHtml); 	
						    }
										
					}catch(e){
						alert("관리자에게 문의하십시오.")
						//alert("divChange1 함수호출 시 에러발생! 체크대상, 표현대상 jQeury객체와 표현식, 비오류/오류html구문을 확인해 주십시오."+ e.message);
					}
	         }	
	</script>
	<script>
	$(document).ready(function(){

		// alert("시작");
		//==================================DB 연동 결과물 EL로 출력하기 =========================================
		//------------------------------------------------------------------------------------
		//----------유저명 DB 연동 결과물을 변수 user_name에 저장하기 
		//------------------------------------------------------------------------------------
		var old_user_name = "${requestScope.user_info.user_name}";
		//------------------------------------------------------------------------------------
		//----------현재 비밀번호 DB 연동 결과물을 변수 old_pwd_confirm에 저장하기 
		//------------------------------------------------------------------------------------
	    var old_password = "${requestScope.user_info.pwd}";
		 $(".oldpwd_pass").val(old_password); 
		//------------------------------------------------------------------------------------
		//----------전화번호 DB 연동 결과물을 변수 tel_num에 저장하기 
		//------------------------------------------------------------------------------------
		var tel_num1 = "${requestScope.user_info.tel_num1}";
		var tel_num2 = "${requestScope.user_info.tel_num2}";
		var tel_num3 = "${requestScope.user_info.tel_num3}";
		//alert("전화번호 :  " + tel_num1 + tel_num2 + tel_num3);
	    $(".tel_num1").val(tel_num1);
	    $(".tel_num2").val(tel_num2);
	    $(".tel_num3").val(tel_num3); 
		//------------------------------------------------------------------------------------
		//----------이메일 DB 연동 결과물을 변수 email에 저장하기 
		//------------------------------------------------------------------------------------
		var email = "${requestScope.user_info.email}";
		var emailArray  = email.split('@');  
	    var email1 = emailArray[0];
	    var email2 = emailArray[1];
	   	$(".email1").val(email1);
	   	$(".email2").val(email2);
	    var oldEmail = ( email1 + "@" +  email2  ); 
	    //alert(oldEmail);
		//------------------------------------------------------------------------------------
		//---------- 주소 DB 연동 결과물을 변수 email에 저장하기 
		//------------------------------------------------------------------------------------
		var addr = "${requestScope.user_info.addr}";
	    $(".addr").val(addr); 
		//------------------------------------------------------------------------------------
		//----------수정하기 버튼 누르면 유효성 체크하는 함수로 이동
		//------------------------------------------------------------------------------------
		$("[name=user_modify] .btn_Ctype_p2").click(function(){	
			 checkUser_modify();
	    });  

		//------------------------------------------------------------------------------------
		//----------다시작성 버튼 누르면 초기 html 문구로 세팅하기
		//------------------------------------------------------------------------------------
		$("[name=user_modify] .btn_reset").click(function(){	
			$(".pwd2").html("<p class=detxt>영문 대소문, 숫자, 특수문자 포함(6~13자리)</p>");
			$(".pwd_confirm2").html("<p class=detxt>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>");
	    })
		 
	//====================================== 이벤트 발생 ====================================================================
	//------------------------------현재 비밀번호  확인 경고 문구 -------------------------
		  $(".old_password").keyup(function(){	
			    
				if( $(".old_password").val() == "" && $(".pwd").val() != "" && $(".pwd_confirm").val()!=""){
					$(".pwd2").html("<p><font color='#BE2C54'>현재비밀번호를 먼저 입력해주세요</font></p>")  
					return;
				}
				else if(  $(".old_password").val() != ""  &&  $(".old_password").val() != old_password ){
					   $(".old_password2").html("<p><font color='#BE2C54'>현재 비밀번호와 일치하지 않습니다.</font></p>")
						return;
				}	
				else if(  $(".old_password").val() != ""  &&  $(".old_password").val() == old_password ){
					   $(".old_password2").html("<p><font color='#528316'>현재 비밀번호와 일치합니니다.</font></p>")
						return;
				}	
		  });
	//---------------------------------------새 비밀번호  경고 문구 -------------------------
	   $(".pwd").keyup(function(){
			if( $(".pwd").val() != "" &&  $(".old_password").val()=="" && $(".old_password").val() != $(".oldpwd_pass").val() ){
				   $(".pwd2").html("<p><font color='#BE2C54'>현재비밀번호를 먼저 입력해주세요</font></p>")  
			}
			  divChange1( 
					    $(".old_password") 
					    , old_password
						,$(".pwd")  
						,$(".pwd2")  
						,/^[a-zA-Z0-9]{6,13}$/ 	
						,"<p class="+"detxt mt10>영문 대소문, 숫자 포함(6~13자리)</p>"
						,"<p><font color='#528316 '>※사용에 적합한 비밀번호입니다!</font></p>"
						,"<p><font color='#BE2C54'>현재비밀번호를 먼저 확인 해주세요</font></p>"
						,"<p><font color='#BE2C54'>영문 대소문, 숫자 포함(6~13자리)</font></p>"
			 );
			
	   });
	 //-----------------새 비밀번호 재 확인 경고 문구 -------------------------
	  $(".pwd_confirm").keyup(function(){	
		  if( $(".pwd").val() != "" && $(".pwd_confirm").val()==""){
			   $(".pwd_confirm2").html("<p class="+"detxt mt10>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>")
		  }
		    	divChange2( 
				    $(".pwd1") 
					,$(".pwd_confirm1")  
					,$(".pwd_confirm2")
					,/^[a-zA-Z0-9]{6,13}$/	
					,"<p class="+"detxt mt10>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>"
					,"<p><font color='#528316 '>※비밀번호와 일치합니다!</font></p>"
					,"<p><font color='#BE2C54'>비밀번호와 일치하지 않습니다.</font></p>"
					,"<p class="+"detxt mt10>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>"		
				);
		});
	//-----------------유저명  경고 문구 ---------------------------------------------------------------------------------------------
			$(".user_name1").keyup(function(){		
			    divChange( 
					    $(".user_name1") 
						,$(".user_name2")			
						, /^[가-힣a-zA-Z0-9]{2,10}$/				
						,"<p class="+"detxt mt10>영문 대소문자,한글, 숫자를 포함(1~10자리)</p>"
						,"<p><font color='#528316 '>※사용에 적합한 유저명 입니다!</font></p>"				
						,"<p><font color='#BE2C54'>영문 대소문자,한글, 숫자를 포함(1~10자리)</font></p>"				
				);
			}); 

	//==================================이메일 아이디를 입력하면 패턴검사하기=====================================
			$(".email1").keyup(function(){	
			  	if( checkPattern( "[name=email1]", /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/, "영문, 숫자로 시작하는 이메일 아이디를 입력해주세요.")  ){ return; }

			}); 				    
	//==================================이메일 주소 직접 입력하면 이메일 주소 셀렉트 비우기==============================================
			$("[name=email2]").change(function(){
			    var email2         = $("[name=email2]").val();
			    var email_select   = $("[name=email_select]").val();
			
				  if(email2!=email_select){
				    $("[name=email_select]").val('');
				  }	
			});
			
	//================================    이메일 주소 선택할 경우 email2 태그안에 선택된 value 값 넣기  ================================
		     $(".email_select").change(function(){  
			    if( $("[name=email1]").val()==""){
					alert("이메일 아이디를 먼저 입력해 주세요");
			     	$("[name=email_select]").val('');
					$(".email1").focus();
					
				 }
		        var email_select=$("[name=email_select]").val();       
			        if(isEmpty1(email_select)==false){
			             if(email_select!=""){        
			                var  email2 = email_select;
			                $("[name=email2]").val(email2); 
			             }  
			        }
		     });
			
	//=================================전화번호 change 이벤트============================================================================	
			$(".tel_num1, .tel_num2, .tel_num3").change(function(){

				//선택한 연,월,일을 얻어서 각각 변수에 저장하기	
				var tel_num1 = $(".tel_num1").val();
				var tel_num2 = $(".tel_num2").val();
				var tel_num3 = $(".tel_num3").val();
				//alert("birth_year : " + birth_year + " birth_month : " + birth_month + " birth_date : " + birth_date);
		
				// 연도의 데이터가 비어있는데 월 데이터가 들어갈 경우
				if( (tel_num1=="") && (tel_num2!="") ){
					alert("통신사 부터 선택해 주십시오.");
					//경고하고 class=birth_motnh, class=birth_date를 가진 태그가 selet태그이므로
					//""를 가진 option태그가 선택됨
					$(".tel_num2").val("");
					$(".tel_num3").val("");
					$(".tel_num1").focus();
					return;
				}
				//월 데이터가 비었는데 일 데이터가 들어갈 경우
				else if( (tel_num2=="" ) && (tel_num3!="") ){
					//경고하고 calss=birth_date의 value값의 데이터를 초기화하기
					alert("앞에 전화번호부터  먼저 입력해 주십시오.");
					$(".tel_num3").val("");
					$(".tel_num2").focus();
					return;
				}		
			});

	});   // ready 끝!!!

	//===================중복체크====================================================================================================
	  
		 	function checkVerify( idJumin ){
		 		//--------------- 유저명 중복 체크 -----------------
				if(idJumin=='name_verify'){
					if( checkEmpty_user_name( "[name=user_name]" ,"[name=user_id]", "유저명을 입력해주세요.") ){  return; }
					if( checkPattern( "[name=user_name]",/^[가-힣a-zA-Z0-9]{1,10}$/, "유저명은 영문 대소문자,한글, 숫자를 포함(1~10자리)")  ){ return; } 
					$(".idJuminVal").val( $("[name=user_name]").val() ); 
				}
				//--------------- 이메일 중복 체크 -----------------
				else if(idJumin=='email_verify'){
					 if(checkEmpty(  "[name=email1]" ,"이메일 아이디를 입력해주세요.")){return;}				 		      									 
					 if( checkEmpty_email( "[name=email_select]","[name=email2]", "[name=email]",'[name=email1]'  ,"이메일 주소를 선택해주세요." ) ){ return; }	
					 $(".idJuminVal").val( 
						 $("[name=email1]").val()+ "@" +$("[name=email2]").val() );  
			    }
		 		//--------------- 전화번호 중복 체크 -----------------
		 		else if(idJumin=='tel_verify'){
		 			 if(checkEmpty(  "[name=tel_num1]" ,"전화번호를 입력해주세요.")){return;}				 		      	
					 //if( checkPattern( "[name=tel_num1]",/^[0-9]{3}$/, "첫번째 전화번호 숫자(3자리)를 입력해주세요.")  ){ return; }
					 //--------------------------------------------------------------------------
					 if(checkEmpty(  "[name=tel_num2]" ,"전화번호를 입력해주세요.")){return;}				 		      	
					 if( checkPattern( "[name=tel_num2]", /^[0-9]{4}$/, "두번째 전화번호 숫자(4자리)를 입력해주세요.")  ){ return; }
					 //--------------------------------------------------------------------------
					 if(checkEmpty(  "[name=tel_num3]" ,"전화번호를 입력해주세요.")){return;}				 		      	
					 if( checkPattern( "[name=tel_num3]", /^[0-9]{4}$/, "세번째 전화번호 숫자(4자리)를 입력해주세요.")  ){ return; } 
					 $(".idJuminVal").val( 
							 $("[name=tel_num1]").val() + "-" +  $("[name=tel_num2]").val()  + "-" +  $("[name=tel_num3]").val() );  
			 	} 
			 	
	//=================================================================================================================================

				$(".check_for").val(idJumin);
				  
				$.ajax({
					//----------------------------
					// 호출할 서버쪽 URL 주소 설정
					//----------------------------
					url : "${requestScope.croot}/user_ModifyVerify.do"
					//----------------------------
					// 전송 방법 설정
					//----------------------------
					, type : "post"
					//----------------------------
					// 서버로 보낼 파라미터명과 파라미터값을 설정
					//----------------------------
					, data : $('[name=form_verify]').serialize()
					//----------------------------
					// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
					// 매개변수 boardRegCnt 에는 입력 행의 개수가 들어온다.
					//----------------------------		 
					, success : function(verifyCnt){	
						// [조회된 행이]가 존재하면 (1개이면)
						if(verifyCnt>=1){
							//------------------------------------------------
							// 중복 검색여부 확인결과가 0보다 큰 수이면(중복결과가 있으면)
							// 해당 입력양식의 값을 초기화하고 리턴하기
							//------------------------------------------------
							if(idJumin=='name_verify' ){
								alert("중복된 유저명이 존재합니다!");
								$("[name=user_name]").val(old_user_name);							
								$(".user_name3").html("<p>영문 대소문자,한글, 숫자를 포함(2~10자리)</p>");														
							}	
							else if(idJumin=='email_verify' ){
								alert("중복된 이메일이 존재합니다!");
								$("[name=email1]").val(email1);
								$("[name=email_select]").val("");
								$("[name=email2]").val(email2);
							}
							else if(idJumin=='tel_verify' ){
								alert("중복된 전화번호가 존재합니다!");
								$("[name=tel_num1]").val(tel_num1);
								$("[name=tel_num2]").val(tel_num2);
								$("[name=tel_num3]").val(tel_num3);  
							}	 
						
						}
						// [회원 등록 성공 개수]가 1개가 아니면
						else{
							  if(idJumin=='name_verify'){
								   $(".name_pass").val(	$("[name=idJuminVal]").val()   );
								   alert("사용가능한 유저명 입니다!");
							  }
							  else if(idJumin=='email_verify'){
								  $(".email_pass").val(	$("[name=idJuminVal]").val()   );
								   alert("사용가능한 이메일 입니다!");
							  }
							  else if(idJumin=='tel_verify'){
								  $(".tel_pass").val(	$("[name=idJuminVal]").val()   );
								   alert("사용가능한 전화번호 입니다!");	   
					          }
						}

					}
					//----------------------------
					// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
					//----------------------------
					, error : function(){
						alert("서버 접속 실패");
					}

				});
			}        
		 	  
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	//유효성 체크하는 함수 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	   function checkUser_modify(){ 
		//alert("수정버튼");
		//------------------------------------------------------------------------------------
		//----------현재 비밀번호 DB 연동 결과물을 변수 user_name에 저장하기 
		//------------------------------------------------------------------------------------
		var old_password = "${requestScope.user_info.pwd}";
		$(".oldpwd_pass").val(old_password);
		//==================================DB 연동 결과물 EL로 출력하기 =========================================
		//------------------------------------------------------------------------------------
		//----------유저명 DB 연동 결과물을 변수 user_name에 저장하기 
		//------------------------------------------------------------------------------------
		var old_user_name = "${requestScope.user_info.user_name}";
	    $(".old_user_name").val(old_user_name); 
		//------------------------------------------------------------------------------------
		//----------전화번호 DB 연동 결과물을 변수 tel_num에 저장하기 
		//------------------------------------------------------------------------------------
		var tel_num1 = "${requestScope.user_info.tel_num1}";
		var tel_num2 = "${requestScope.user_info.tel_num2}";
		var tel_num3 = "${requestScope.user_info.tel_num3}"; 
	    var oldTel_num = ( tel_num1 + "-" +  tel_num2 + "-" +  tel_num3  ); 
		//------------------------------------------------------------------------------------
		//----------이메일 DB 연동 결과물을 변수 email에 저장하기 
		//------------------------------------------------------------------------------------
		var email = "${requestScope.user_info.email}";
		var emailArray  = email.split('@');  
	    var email1 = emailArray[0];
	    var email2 = emailArray[1];
	    var oldEmail = ( email1 + "@" +  email2  ); 
	    //============= 현재 비밀번호가 비었거나 일치 하지 않으면 경고하고 초점맞추기=============================================	
		if(  $("[name=old_password]").val() == ""   ){
			 alert("본인확인을 위해 현재비밀번호를 입력해주세요.");
		  	 $("[name=old_password]").focus(); 
			 return; 
		}	
		else if( $("[name=old_password]").val() != ""  &&   $("[name=old_password]").val() != $("[name=oldpwd_pass]").val()    ){
			 alert("본인확인을 위해 현재비밀번호를 입력해주세요.");
			 $("[name=old_password]").val("");
		  	 $("[name=old_password]").focus(); 
			 return; 
		}	
	   //=============새 비밀번호와 새 비밀번호확인 값이 다르면 경고창 띄워주고 name=pwd_confirm 값을 비우고 초점맞추기=================
	   var pwd = $("[name=pwd]").val();
	   var pwd_confirm = $("[name=pwd_confirm]").val();
	   var regExp = new RegExp(/^[a-zA-Z0-9]{6,13}$/);

	   if(pwd !=""){
			if( regExp.test( pwd )==false ){
				 alert("비밀번호는 영문 대소문, 숫자 포함(6~13자리)로 입력하세요"); 
				 $("[name=pwd]").val("");
			  	 $("[name=pwd]").focus(); 
				 return;
			}
			if( pwd!=pwd_confirm ){
				 alert("입력하신 비밀번호와 확인번호가 일치하지 않습니다."); 
				 $("[name=pwd_confirm]").val("");
			  	 $("[name=pwd_confirm]").focus(); 
				 return;
			}
	   }
	   //=============유저명 유효성 체크======================================================================================
	   //-----------------------------
	   // user_nameCnt 변수안에 0 저장하기
	   //-----------------------------
	 	var user_nameCnt = 0;
	       //-------------------------------------------------
	       // 만약에 name=user_name 이 비어있지 않으면 cnt 변수에 +1 해라.
	       //--------------------------------------------------
			if(isEmpty($("[name=user_name]")) == false){user_nameCnt++}
	       //--------------------------------------------------------------------------------------------------------
	       // 만약에 user_nameCnt가 0이면 confirm으로 확인하여 false 경우 'name=user_name' 을 비우고 함수 중단하라.
	       // true 면 'name=user_name' 태그 value 안에 'name=user_id' 태그의 value 값을 저장하고 중복체크여부를 묻지 않게
	       // name_pass 태그 value 안에 'name=user_name' 의 value 값을 저장하기
	       //--------------------------------------------------------------------------------------------------------
		    if( user_nameCnt == 0){
			    if(confirm('미입력시 현재 유저명으로 사용됩니다. 이대로 진행하시겠습니까?')==false){
			 	    alert("유저명을 입력해주세요.")
			     	$("[name=user_name]").val('');
			     	return;
			   	}else{
					  $("[name=user_name]").val( $("[name=old_user_name]").val());
					  $(".name_pass").val(	$("[name=user_name]").val()   );
				} 
				 return;    
		    }
		   		    
	   var userName= $("[name=user_name]").val();
	   var oldName= $("[name=old_user_name]").val();
	   var regExp = new RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);
	   
	   if(userName !=""){
			if( regExp.test( userName )==false ){
				 alert("유저명은 영문 대소문자,한글, 숫자를 포함(1~10자리))로 입력하세요"); 
				 $("[name=userName]").val("");
			  	 $("[name=userName]").focus(); 
				 return;
			}
	   }
	   if(userName!=null && userName.split(" ").join("")!="" && userName != oldName   ){
		   if( $("[name=user_name]").val() != $("[name=name_pass]").val() ){
				alert("유저명 중복체크 해주세요."); 
				return;
	   	   }	
			  
	   }
	  
	//=============이메일 유효성 체크==============================================================================================
	/*
	   var jumin_num = $("[name=jumin_num]").val();	      

	   if(jumin_num!="" ){   			
					 //--------------------------------------------------------------------------
					 if(checkEmpty(  "[name=email1]" ,"이메일 아이디를 입력해주세요.")){return;}				 		      	
					 if( checkPattern( "[name=email1]", /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/, "이메일 아이디를 입력해주세요.")  ){ return; }
					 //--------------------------------------------------------------------------	
					 //if(checkEmpty(  "[name=email_select]" ,"이메일 주소를 선택해주세요.")){return;}	
					 //--------------------------------------------------------------------------
					 if( checkEmpty_email( "[name=email_select]","[name=email2]", "[name=email]" ,'[name=email1]' ,"이메일 주소를 선택해주세요." ) ){ return; }	  
					 // if(checkEmpty(  "[name=email2]" ,"이메일 주소를 입력해주세요.")){return;}	
					 if( checkPattern( "[name=email2]", /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/ , "이메일 주소를  올바르게 입력해주세요.")  ){ return; }
					 //--------------------------------------------------------------------------
					 $("[name=email]").val($("[name=email1]").val() + "@" +  $("[name=email2]").val()  ); 
					//--------------------------------------------------------------------------
					// 이메일 중복 체크
					//--------------------------------------------------------------------------
					 if( $("[name=email]").val() != $("[name=email_pass]").val() ){
							alert("이메일주소 중복체크 해주세요."); return;
						}
	    }
	 */           
	   var emailCnt = 0;
	   if(  isEmpty( $("[name=email1]") && $("[name=email2]") )== false ){emailCnt++}
	   if( emailCnt == 0){
		    if(confirm('이메일이 전부 입력되지 않았습니다. 현재 이메일로 사용하시겠습니까?')==false){
		 	   // alert("이메일을 입력해주세요.")
		     	$("[name=email1]").val('');
		     	$("[name=email2]").val('');
		     	return;
	  		}
		  	else{
				  $("[name=email1]").val( email1 );
				  $("[name=email2]").val( email2 );
				  $(".email_pass").val(	$("[name=email]").val()   );
			}   
		    return;    
	  }    
	  var email = $("[name=email1]").val() + "@" +  $("[name=email2]").val();
	  //--------------------------------------------------------------------------
	  if( $("[name=email1]").val()!="" && $("[name=email2]").val()=="" ){ 
	  	if(checkEmpty(  "[name=email1]" ,"이메일 아이디를 입력해주세요.")){return;}				 		      	
	  	if( checkPattern( "[name=email1]", /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/, "영문, 숫자로 시작하는 아이디를 입력해주세요.")  ){ return; }
	  }
	  
	  if( $("[name=email1]").val()=="" && $("[name=email2]").val()!="" ){ 
		  alert("이메일 아이디를 먼저 입력해주세요."); 
		  return;
	  }

	  if( $("[name=email2]").val()!=""){
	  	if( checkEmpty_email( "[name=email_select]","[name=email2]", "[name=email]" ,'[name=email1]' ,"이메일 주소를 선택해주세요." ) ){ return; }	  
	  
	  	if( checkPattern( "[name=email2]", /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/ , "이메일 주소가 형식에 맞지 않습니다.")  ){ return; }
	  }
	  //--------------------------------------------------------------------------
	  $("[name=email]").val($("[name=email1]").val() + "@" +  $("[name=email2]").val()  ); 
	 
	  if( $("[name=email]").val() != $("[name=email_pass]").val() && email != oldEmail  ){
		 alert("이메일 중복체크 해주세요."); return;
	  } 

	 
	   //=============전화번호 유효성 체크=============================================================   			
	   var telCnt = 0;
	   if(isEmpty($("[name=tel_num1]") && $("[name=tel_num2]") && $("[name=tel_num3]") ) == false){telCnt++}
	   if( telCnt == 0){
		    if(confirm('전화번호가 전부 입력되지 않았습니다. 현재 전화번호로 사용하시겠습니까?')==false){
		 	    alert("전화번호를 입력해주세요.")
		     	$("[name=tel_num1]").val('');
		     	$("[name=tel_num2]").val('');
		     	$("[name=tel_num3]").val('');
		     	return;
	  		}
		  	else{
				  $("[name=tel_num1]").val( tel_num1 );
				  $("[name=tel_num2]").val( tel_num2 );
				  $("[name=tel_num3]").val( tel_num3 );
				  $(".tel_pass").val(	$("[name=tel_num]").val()   );
			}   
		    return;    
	  }    
	  var tel_num = $("[name=tel_num1]").val() + "-" +  $("[name=tel_num2]").val()  + "-" +  $("[name=tel_num3]").val();
	  //--------------------------------------------------------------------------
	  if(checkEmpty(  "[name=tel_num1]" ,"전화번호를 선택해주세요.")){return;}				 		      	
	  //--------------------------------------------------------------------------												 
	  if(checkEmpty(  "[name=tel_num2]" ,"전화번호를 입력해주세요.")){return;}				 		      	
	  if( checkPattern( "[name=tel_num2]", /^[0-9]{4}$/, "두번째 전화번호 숫자(4자리)를 입력해주세요.")  ){$("name=tel_num2]").val(""); return; }
	  //--------------------------------------------------------------------------
	  if(checkEmpty(  "[name=tel_num3]" ,"전화번호를 입력해주세요.")){return;}				 		      	
	  if( checkPattern( "[name=tel_num3]", /^[0-9]{4}$/, "세번째 전화번호 숫자(4자리)를 입력해주세요.")  ){$("name=tel_num3]").val(""); return; }
	  //--------------------------------------------------------------------------
	  // name=tel_num 라는  hidden 태그에 저장하기					 
	  //--------------------------------------------------------------------------
	  $("[name=tel_num]").val(
	  	 $("[name=tel_num1]").val() + "-" +  $("[name=tel_num2]").val()  + "-" +  $("[name=tel_num3]").val()  );  

	  if( $("[name=tel_num]").val() != $("[name=tel_pass]").val() && tel_num != oldTel_num  ){
		 alert("전화번호 중복체크 해주세요."); return;
	  } 
		    

	 	//=============거주지 유효성 체크============================================================= 
	    
			  var tel_num = $("[name=tel_num]").val();	      
			  if(tel_num!="" ){ 			    			  	        
		            $("[name=addr]").val();	
		  	        if(isEmpty ( $("[name=addr]")  )==true  ){
			  	        alert ("주소지 입력을 확인해주세요")
			  	      return; 
		  	        }     
		      }

		      var addr = $("[name=addr]").val();
		      if( addr!="" ){
			      	if(confirm("정말 수정 하시겠습니까?")==false){  
				      	document.user_modify.reset();   
				      	return;
				    }
		      }

		      $.ajax({
			     
				//----------------------------
				// 호출할 서버쪽 URL 주소 설정
				//----------------------------
				url : "${requestScope.croot}/user_modifyProc.do"
				//----------------------------
				// 전송 방법 설정
				//----------------------------
				, type : "post"
				//----------------------------
				// 서버로 보낼 파라미터명과 파라미터값을 설정
				//----------------------------
				, data : $('[name=user_modify]').serialize()
		 
				, success : function(user_modifyCnt){	
					
					//----------------------------------------
					// 웹서버가 보낸 입력 성공 행의 개수가 2이 아니면
					// 경고 문구 보이고 익명함수 중단하기
		            //----------------------------------------
			
					if(user_modifyCnt==1){
						alert("회원수정 성공!");
						document.loginForm.submit();
						return;	
				    }
					else {
						alert("서버쪽 DB 연동 예외 발생!");
					}
				    
				}								
				//----------------------------
				// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
				//----------------------------
				, error : function(){
					alert("서버 접속 실패");
					document.user_modify.reset();
				}
				
			});//$.ajax 끝!!
				
		 }//checkUser_modify 함수 끝!!

		 
		//**********************************************
		//[로그인]화면으로 이동하는 함수 선언
		//**********************************************
		function goLoginRegForm(){
			//--------------------------------------
			// 웹서버에 loginForm.do URL로 접속하기
			//--------------------------------------
			 location.replace("${requestScope.croot}/loginForm.do" )
		}

		
		//**********************************************
		//[로그인]화면으로 이동하는 함수 선언
		//**********************************************
		function goLoginRegForm(){
			//--------------------------------------
			// 웹서버에 loginForm.do URL로 접속하기
			//--------------------------------------
			 location.replace("${requestScope.croot}/loginForm.do" )
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
		
	</script>
	
	<style>
    .clear {
        color: #da688c;
        padding-top: 5px;
        display: block;
        font-size: 12px;
    }
    .dupl {
        color: #f00;
        padding-top: 5px;
        display: block;
        font-size: 12px;
    }
    #fregister_processing {
        display: none;
    }
    .agree_title{
        display: block;
        color: #525252;
        font-size: 13px;
        font-weight: 700;
        vertical-align: middle;
    }
    .ly_con_both {
        padding: 15px 20px;
    }
    th {
		width:150;
		background-color:lightgray;
	}
	
	.tr td {
				  padding:10;
	}
				
	.bg {
		  /* width: 500px;
		  height: 500px; */
		  background-image: url("${pageContext.request.contextPath}/resources/img/background_02.png");
		  background-size: cover;
		  /* background-position: center; */
		  background-repeat: no-repeat;
	 }
 
</style>
	
</head>
<body>
	  <!-- navigation -->
	  <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom">
			<b><a class="navbar-brand" href="javascript:goFrontPage();">MY NOTE</a></b>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
	            <li class="nav-item active">
	             <b><a class="nav-link" href="javascript:goFrontPage();">HOME<span class="sr-only">(current)</span></a></b>
	            </li>
	            <li class="nav-item">
	              <b><a class="nav-link" href="javascript:goLoginForm();">LogIn</a></b>
	            </li>
	            <c:if test="${!empty sessionScope.admin_id}">  
		            <li class="nav-item dropdown">
		              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		                이동하기
		              </a>
		              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
		                <!-- <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a> -->
		                     <a class="dropdown-item" href="javascript:goAdminForm();">관리자페이지</a>
					  </div>
			    	</li>
				</c:if>
	          </ul>
	        </div>
      </nav>	
      
	  <div class="jumbotron bg" style="height: 200px; background-color: rgb(35, 67, 105);"> 
	  </div>
	
		<!-- 관리자 모드 안내 방법2 -->
		 <div class="alert alert-light alert-dismissible fade show" role="alert">
			  <!-- 관리자로 접속 하였을 때 보여주는 멘트 -->
			  <c:if test="${!empty sessionScope.admin_id}">          
			   <h4 style="text-align: left;"  class="txt01">${sessionScope.admin_id} 님 관리자모드로 접속하셨습니다! </h4>
			  </c:if>
			 <!-- 유저로 접속 하였을 때 보여주는 멘트 -->
			  <c:if test="${!empty sessionScope.user_id}">          
			   <h4 style="text-align: left;"  class="txt01">${sessionScope.user_name}님 환영합니다! </h4>
			  </c:if>
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
		 </div> 

 <!-- ============================================================메인 창 ========================================================================== --> 
<div class="container">	
		<div class="content_inner">
		    <div class="top_des">
		        <h4 class="txt01">회원 정보 수정</h4>
		    </div> 
		
		      
		<form name="user_modify" method="post" action="${requestScope.croot}/user_modifyProc.do">	
 
   <div class="join">
            <div class="form_style01">                   
 <!-- ==============================================================================  아이디  ============================================================================== -->             
           <div class="ly_cont">
              <div class="ly_tit"><span><label ><p class="user_id"></p>아이디</label></span></div>
              <div class="ly_con">
                  <div>
                      <div class="pdStyle01">
                            <input class="inp05 user_id user_id1"  name="user_id"  type="text"  value="${requestScope.user_info.user_id}" readonly/>
                     </div>
             	  </div>
              </div>
           </div>
<!-- ============================================================================== 현재 비밀번호 ============================================================================== -->               
     	  <div class="ly_cont">
                <div class="ly_tit"><span><label >현재 비밀번호</label></span></div>
                <div class="ly_con">
                    <div>                                                       
                        <input class="inp05 old_password old_password1"  name="old_password" placeholder="비밀번호를 입력하세요."  type="password" value=""  />
                        <input type="hidden" name="oldpwd_pass" class="oldpwd_pass" readonly>
                         <p class="detxt mt10 old_password2">본인확인을 위해 현재비밀번호를 입력해주세요.</p>
     
                    </div>                                                             
                </div>
           </div>     
<!-- ==============================================================================새 비밀번호 ============================================================================== -->               
           <div class="ly_cont">
                <div class="ly_tit"><span><label >새 비밀번호</label></span></div>
                <div class="ly_con">
                    <div>                                                       
                        <input class="inp05 pwd pwd1"  name="pwd" placeholder="비밀번호를 입력하세요."  type="password" value="" maxlength="13" />
                        <br><br>
                        <p>이전에 사용한 적 없는 비밀번호가 안전합니다. </p>  
                        <p class="detxt mt10 pwd2"> 영문 대소문, 숫자 포함(6~13자리)</p>  
                    </div>                                                             
                </div>
           </div> 
<!-- ============================================================================ 비밀번호 확인 ================================================================================ -->                           
           <div class="ly_cont">
                <div class="ly_tit"><span><label >새 비밀번호 확인</label></span></div>
                <div class="ly_con">
                    <div>
                        <input class="inp05 pwd_confirm pwd_confirm1"  name="pwd_confirm" placeholder="비밀번호를 재입력해주세요."  type="password" value="" maxlength="13"/>
                        
                         <p class="detxt mt10 pwd_confirm2">비밀번호 확인을 위해 다시 한번 입력해주세요.</p>
                    </div>
                </div>
           </div>   

<!-- ============================================================================현재 유저명 ================================================================================ -->                         
            <div class="ly_cont">
                <div class="ly_tit"><span><label >현재 유저명</label></span></div>
                <div class="ly_con">
                    <div>
                        <input class="inp05 old_user_name"  name="old_user_name"  value="${requestScope.user_info.user_name}" type="text" maxlength="13" readonly/>                                           
                    
                    </div>
                </div>
            </div>

<!-- ============================================================================새로운 유저명 ================================================================================ -->                         
            <div class="ly_cont">
                <div class="ly_tit"><span><label >새로운 유저명</label></span></div>
                <div class="ly_con">
                    <div>
                        <input class="inp05 user_name1"  name="user_name" placeholder="미입력시 현재 유저명 자동입력"   type="text"  maxlength="13" />                       
                     	<a  style="cursor:pointer"  class="btn_Ttype btn_Ttype1" onclick="checkVerify('name_verify');"><span>중복확인</span></a>
                        <input type="hidden" name="name_pass" class="name_pass" readonly>
                         <br><br>  
                    	<p class="detxt mt10 user_name2 user_name3">영문 대소문자,한글, 숫자를 포함(1~10자리)</p>
                    	<p>※ 미 입력시 현재 유저명으로 등록됩니다. </p>
                    
                    </div>
                    
                </div>
            </div>
  <!-- ============================================================================  주민등록번호 ================================================================================ -->            
            <div class="ly_cont">
                <div class="ly_tit"><span><label >주민등록번호</label><em class="register_optional">(필수사항)</em></span></div>
                <div class="ly_con">
                    <div>
                         <input  class="inp06 jumin_num1"   type="text" name="jumin_num1" value="${requestScope.user_info.jumin_num1}" maxlength=6 readonly>
			              -
					 	 <input     type="text" name="jumin_num2" class="jumin_num2" value="${requestScope.user_info.jumin_num2}" maxlength=1 size="1">
						 ******
						 <input type="hidden" name="jumin_num" class="jumin_num" readonly>
                         <input type="hidden" name="jumin_pass" class="jumin_pass" readonly>
                    </div>
                </div>
            </div>    
  <!-- ============================================================================  이메일 ================================================================================ -->                                                       
            <div class="ly_cont">
                <div class="ly_tit"><span><label >이메일</label><em class="register_optional"></em></span></div>
                <div class="ly_con">
                    <div>
                         <span class="ver_m">
                         <input class="inp11 email1" type="text" name="email1" placeholder="아이디 입력"  size="12" >   
                           @
                         <input class="inp12 email2" type="text" name="email2" placeholder="이메일주소 입력" size="15">    
                         
                         <select class="set01 email_select"   name="email_select"><option>직접입력</option>
								<option value="naver.com">naver.com</option>
								<option value="gmail.com">gmail.com</option>
								<option value="daum.com">daum.com</option>
				         </select>
				
	             <!----------------------  이메일 중복 체크  ------------------------------>
		        &nbsp;<a  style="cursor:pointer"  class="btn_Ttype" onclick="checkVerify('email_verify');" ><span>중복확인</span></a>
				
				        <input type="hidden" name="email" class="email">
				        <input type="hidden" name="email_pass" class="email_pass" readonly>
                        <br><br>     
                        <p>※ 미 입력시 현재 이메일로 등록됩니다. </p>
                        </span>                      
                    </div>
                </div>
           </div>   
  <!-- ============================================================================  전화번호 ================================================================================ -->            
            <div class="ly_cont">
                <div class="ly_tit"><span><label >전화번호</label><em class="register_optional"></em></span></div>
                <div class="ly_con">
                    <div>
                          <select class="set01 tel_num1"   name="tel_num1">
								<option value=""></option>
								<option value="010">010</option>
								<option value="010">011</option>
								<option value="010">016</option>
								<option value="010">017</option>
				          </select>
                         <!-- <input  class="inp10 tel_num1"   type="text" name="tel_num1" maxlength=3 size="3">-->
			              -
					 	 <input  class="inp10 tel_num2"   type="text" name="tel_num2"  maxlength=4 size="4">
						  -
						 <input  class="inp10 tel_num3"   type="text" name="tel_num3"  maxlength=4 size="4">
						 
						 <input type="hidden" name="tel_num" class="tel_num">
						 
						 &nbsp;<a  style="cursor:pointer"  class="btn_Ttype" onclick="checkVerify('tel_verify');" ><span>중복확인</span></a> 
                        <br><br>  
                        <p>※ 미 입력시 현재 전화번호로 등록됩니다. </p>
						 <input type="hidden" name="tel_pass" class="tel_pass" readonly>
		                 	                      	                      
	                              
                    </div>
                </div>
            </div>
<!-- ============================================================================  거주지역 ================================================================================ -->              
            <div class="ly_cont">
                <div class="ly_tit"><span><label>거주지역</label><em class="register_optional"></em></span></div>
                <div class="ly_con">
                    <div>
                        <span class="ver_m">
			                <input type="text" class=" addr"  name="addr" placeholder="주소를 입력해주세요" size="50" maxlength="50">
							
			              	<span class="detxt"> </span>
                        </span>
                        
                    </div>
                </div>
            </div>              
<!-- ======================================================================================================================================================== -->            
                               
       </div> 
  </div> 
	
			<div class="btn_area_c"> 
			         <input type="button"  style='cursor:pointer' class="btn btn-dark btn_Ctype_p btn_Ctype_p2 btn-sm"  value="회원정보수정   "  >
			         <input type="reset"   style='cursor:pointer' class="btn btn-dark btn_Ctype_p btn_reset btn-sm"  onclick="btn_reset"   value="다시작성   "  > 
			         <!-- <a type="reset" class="btn_Atype b_gray"><span>다시작성</span></a>-->
			         <button type="button" class="btn btn-secondary btn-sm" onclick="goLoginForm();">취소</button>     
			         <%-- <a href="${requestScope.croot}/loginForm.do" id="btnCancel" class="btn_Atype b_gray"><span>취소</span></a> --%>
			</div> 
			<br><br>
	 		<div class="container">
				 <div class="jumbotron" style="height:0px; padding-bottom: 50px;">
				 </div>
	 		</div>   
		</form>
   </div>
</div> 
<!-- =========================================================================================================================================================== -->
		
<!-- ======================================================================================================================= -->
			<!-- ============================== -->
			<!-- post 방식으로 이동할 form 태그 --> 
			<!-- ============================== -->
			<form name="form_verify" method="post" action="${requestScope.croot}/userRegVerify.do">
				
				  <input type="hidden" name="check_for" class="check_for" readonly>
				  
				  <input type="hidden" name="idJuminVal" class="idJuminVal" readonly>
			</form>
			
			<!-- [ 로그인 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="loginForm" method="post" action="${requestScope.croot}/loginForm.do"></form>
			
			<!-- [ 로그아웃 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="logout" method="post" action="${requestScope.croot}/logout.do"></form>
			
			<!-- [ 홈 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="frontPage" method="post" action="${requestScope.croot}/frontPage.do"></form>
			
			<!-- [  검색 목록  ] 화면 이동하는 form 태그 선언하기 -->
			<form name="dictListForm" method="post" action="${requestScope.croot}/dictList.do">
				<input type="hidden" name="lang_code" value="0">
				<input type="hidden" class="search_keyword" name="search_keyword" value="전체선택" checked>
				<input type="hidden" class="search_keyword" name="search_keyword" value="단어" checked>	
				<input type="hidden" class="search_keyword" name="search_keyword" value="작성자" checked>
				<input type="hidden" class="search_keyword" name="search_keyword" value="내용" checked>	
			</form>
			
			<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do"></form>
	
			<!-- [ 노트 수정/삭제 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"></form>
			
			<!-- [ 관리자페이지 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do"></form> 
       
<!-- ======================================================================================================================= -->


	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
		
</body>
</html>
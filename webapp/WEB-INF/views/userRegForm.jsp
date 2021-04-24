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
<!-- 					 common.jsp파일 내의 소스를 삽입하기 -->
<!-- ******************************************************* -->
<%@include file="common.jsp" %>

<%-- <%@include file="common.jsp" %> --%>

<!-- Required meta tags -->
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> 


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

//비밀번호 재확인 문구 
	function divChange1 (
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

	// $("[name=user_id]").val("fjier23");
	 //$("[name=pwd]").val("kill613!");         
	//$("[name=pwd_confirm]").val("kill613!");
	// $("[name=user_name]").val("이성배");
	//$("[name=addr1]").val("인천");
	// $("[name=addr2]").val("남동구"); 
	
	// 텍스트 컬리지정
	//$(".txt01").css({'color':'#b4361f'});


	
	  $("[name=userRegForm] .btn_Ctype_p2").click(function(){	
      checkMemberRegForm();
  }); 

	 $("[name=userRegForm] .btn_reset").click(function(){	
		$(".user_id3").html("<p class=detxt>영문 대소문으로 시작, 숫자 포함(5~10자리)</p>");
		$(".pwd2").html("<p class=detxt>영문 대소문, 숫자, 특수문자 포함(6~13자리)</p>");
		$(".pwd_confirm2").html("<p class=detxt>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>");
  })



	 
//====================================== 이벤트 발생 =========================================
//-----------------아이디  경고 문구 -------------------------rerwrerwe
	$(".user_id1").keyup(function(){		
	    divChange( 
			    $(".user_id1") 
				,$(".user_id2")			
				, /^[a-zA-Z]{1}[a-zA-Z0-9]{4,9}$/				
				,"<p class="+"detxt mt10>영문 대소문으로 시작, 숫자 포함(5~10자리)</p>"
				,"<p><font color='#528316 '>※사용에 적합한 ID입니다!</font></p>"				
				,"<p><font color='#BE2C54'>영문 대소문으로 시작, 숫자 포함(5~10자리)</font></p>"				
			);
	});

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
		
	
//-----------------비밀번호  경고 문구 -------------------------
$(".pwd").keyup(function(){	
		if( $(".pwd").val() == "" && $(".pwd_confirm").val()!=""){
		   $(".pwd_confirm2").html("<p><font class="+"detxt mt10>비밀번호를 먼저 입력해주세요</font></p>")
		}else if(  $(".pwd").val() != "" && $(".pwd_confirm").val()!=""   &&       $(".pwd").val() != $(".pwd_confirm") ){
		   $(".pwd_confirm2").html("<p><font color='#BE2C54'>비밀번호와 일치하지 않습니다.</font></p>")
		}		
	    divChange( 
			    $(".pwd1") 
				,$(".pwd2")  
				,/^[a-zA-Z0-9]{6,13}$/ 	
				,"<p class="+"detxt mt10>영문 대소문, 숫자 포함(6~13자리)</p>"
				,"<p><font color='#528316 '>※사용에 적합한 비밀번호입니다!</font></p>"
				,"<p><font color='#BE2C54'>영문 대소문, 숫자 포함(6~13자리)</font></p>"
									
			);
		
	});
//-----------------비밀번호 재 확인 경고 문구 -------------------------
$(".pwd_confirm").keyup(function(){	
	  if( $(".pwd").val() != "" && $(".pwd_confirm").val()==""){
		   $(".pwd_confirm2").html("<p class="+"detxt mt10>비밀번호 확인을 위해 다시 한번 입력해주세요.</p>")
	  }
	    divChange1( 
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
 
//==================================이메일 주소 직접 입력하면 이메일 주소 셀렉트 비우기==============================================
$("[name=email2]").change(function(){
    var email2         = $("[name=email2]").val();
    var email_select   = $("[name=email_select]").val();

	  if(email2!=email_select){
	    $("[name=email_select]").val('');
	  }	
});
	
	
	
	
			 

	 $("[name=jumin_num1]").change(function(){
		juminCheck1();
  });
	 $("[name=jumin_num2]").change(function(){
		juminCheck2();
	 });


	 insertYMD_to_select3(
			$(".birth_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
			, $(".birth_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
			, $(".birth_date")            // 일 관련 select 태그를 관리하는 JQuery 객체
			, 1950                        // 최소년도
			, new Date().getFullYear()    // 최대년도
			, 1                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
		);
	
	    //------------------------------------------------------------------
		// 전화번호 change 이벤트
		//------------------------------------------------------------------	
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
		    //------------------------------------------------------------------
	// class=birth_year, class=birth_monnth, class=birth_date를 가진 3개의 태그에
	// change 이벤트가 발생하면 실행할 자스코딩 설정하기
	//------------------------------------------------------------------	
	$(".birth_year, .birth_month, .birth_date").change(function(){

	//선택한 연,월,일을 얻어서 각각 변수에 저장하기	
	var birth_year = $(".birth_year").val();
	var birth_month = $(".birth_month").val();
	var birth_date = $(".birth_date").val();
	//alert("birth_year : " + birth_year + " birth_month : " + birth_month + " birth_date : " + birth_date);

	// 연도의 데이터가 비어있는데 월 데이터가 들어갈 경우
	if( (birth_year=="") && (birth_month!="") ){
		alert("연도를 먼저 입력해 주십시오.");
		//경고하고 class=birth_motnh, class=birth_date를 가진 태그가 selet태그이므로
		//""를 가진 option태그가 선택됨
		$(".birth_month").val("");
		$(".birth_date").val("");
		$(".birth_year").focus();
		$("[name=jumin_num1]").val("");
		return;
	}
	//월 데이터가 비었는데 일 데이터가 들어갈 경우
	else if( (birth_month=="" ) && (birth_date!="") ){
		//경고하고 calss=birth_date의 value값의 데이터를 초기화하기
		alert("월을 먼저 입력해 주십시오.");
		$(".birth_date").val("");
		$("[name=jumin_num1]").val("");
		$(".birth_month").focus();
		return;
	}	

	insertValidDate( $(".birth_year"),  $(".birth_month"), $(".birth_date") );	

	if( birth_year!="" && birth_month!="" && birth_date!="" ){
			var jumin_num1 = birth_year.substr(2,2) + birth_month + birth_date;
			$("[name=jumin_num1]").val(jumin_num1);
		}
		
	});
//================================    이메일 주소 선택할 경우 email2 태그안에 선택된 value 값 넣기  ==================================================
     $(".email_select").change(function(){  
        var email_select=$("[name=email_select]").val();       
	        if(isEmpty1(email_select)==false){
	             if(email_select!=""){        
	                var  email2 = email_select;
	                $("[name=email2]").val(email2); 
	             }  
	        }
     });
//=============================================================================================================================================

});   // ready 끝!!!


	 	function checkVerify( idJumin ){
	 		//--------------- 아이디 중복 체크 ---------------
	 		if(idJumin=='id_verify'){
				if( checkEmpty( "[name=user_id]", "ID를 입력해주세요.") ){ return; }
				if( checkPattern( "[name=user_id]", /^[a-zA-Z]{1}[a-zA-Z0-9]{4,9}$/, "아이디가 올바르지 않습니다.")  ){ return; }
				$(".idJuminVal").val( $("[name=user_id]").val() );
			}
	 		//--------------- 유저명 중복 체크 -----------------
			else if(idJumin=='name_verify'){
				if( checkEmpty_user_name( "[name=user_name]" ,"[name=user_id]", "유저명을 입력해주세요.") ){  return; }
				if( checkPattern( "[name=user_name]",/^[가-힣a-zA-Z0-9]{1,10}$/, "유저명은 영문 대소문자,한글, 숫자를 포함(1~10자리)")  ){ return; } 
				$(".idJuminVal").val( $("[name=user_name]").val() ); 
			}
	 		//--------------- 주민 중복 체크 -----------------
			else if(idJumin=='jumin_verify'){
				if( checkEmpty( "[name=jumin_num1]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num1]").val(""); return; }
				if( checkEmpty( "[name=jumin_num2]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num2]").val(""); return; }
				$(".idJuminVal").val(
					$("[name=jumin_num1]").val() + "-" +  $("[name=jumin_num2]").val()	);
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


			$(".check_for").val(idJumin);
			//alert( $('[name=form_verify]').serialize() );
		
			///memberRegVerify.do		  
			$.ajax({
				//----------------------------
				// 호출할 서버쪽 URL 주소 설정
				//----------------------------
				url : "${requestScope.croot}/userRegVerify.do"
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

						if(idJumin=='id_verify'){
							alert("중복된 ID가 존재합니다!");
							$("[name=user_id]").val("");							
							$(".user_id3").html("<p>영문 대소문으로 시작, 숫자 포함(5~10자리)</p>");
																		
						}
						else if(idJumin=='name_verify'){
							alert("중복된 유저명이 존재합니다!");
							$("[name=user_name]").val("");							
							$(".user_name3").html("<p>영문 대소문자,한글, 숫자를 포함(2~10자리)</p>");														
						}
						else if(idJumin=='jumin_verify'){							 
							 if(confirm('이 주민번호로 사용하는 아이디가 '+ verifyCnt  + '개 존재합니다! 이 주민번호 가입을 진행하시겠습니까?')==false){
								    $("[name=jumin_num1]").val("");
									$("[name=jumin_num2]").val("");
									$("[name=birth_year]").val("");
									$("[name=birth_month]").val("");
									$("[name=birth_date]").val(""); 
					
							}else{
								  $(".jumin_pass").val(	$("[name=idJuminVal]").val()   ); 	 
								  
							     }
							}	
						else if(idJumin=='email_verify'){
							alert("중복된 이메일이 존재합니다!");
							$("[name=email1]").val("");
							$("[name=email_select]").val("");
							$("[name=email2]").val("");
						}
						else if(idJumin=='tel_verify'){
							alert("중복된 전화번호가 존재합니다!");
							$("[name=tel_num1]").val("");
							$("[name=tel_num2]").val("");
							$("[name=tel_num3]").val("");  
						}	 
					
					}
					// [회원 등록 성공 개수]가 1개가 아니면
					else{
						  if(idJumin=='id_verify'){
							   $(".id_pass").val(	$("[name=idJuminVal]").val()   );
							   alert("사용가능한 ID 입니다!");
						  }else if(idJumin=='name_verify'){
							   $(".name_pass").val(	$("[name=idJuminVal]").val()   );
							   alert("사용가능한 유저명 입니다!");
						  }else if(idJumin=='jumin_verify'){
							   $(".jumin_pass").val(	$("[name=idJuminVal]").val()   );
							   alert("사용가능한 주민등록번호 입니다!");
						  }else if(idJumin=='email_verify'){
							  $(".email_pass").val(	$("[name=idJuminVal]").val()   );
							   alert("사용가능한 이메일 입니다!");
						  }else if(idJumin=='tel_verify'){
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



	//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		// 주민번호 앞 6글자와 뒷 1글자가 유효성에 맞게 입력되었는지 확인하는 함수 선언
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

		function juminCheck1(){
			var jumin1 = $("[name=jumin_num1]").val();
			var regExp = new RegExp(/^[0-9]+$/);
			if(regExp.test(jumin1)==false){
				$("[name=jumin_num1]").val("");
				return;
					}
			//앞에 주민 6글자가 합당하면 name=jumin_num2 를 가진 태그로 초점을 맞춘다.
			if(regExp.test(jumin1.charAt(5))==true){
				$("[name=jumin_num2]").focus();
				return;}
				}

		function juminCheck2(){
			var jumin2 = $("[name=jumin_num2]").val();
			var regExp = new RegExp(/^[1-4]{1}$/);
			if(regExp.test(jumin2)==false){
				$("[name=jumin_num2]").val("");
				return;
				}	
			}
     
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	//유효성 체크하는 함수 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
   function checkMemberRegForm(){
 	  var user_id = $("[name=user_id]").val();
 	  if(user_id!=""){
   	  if( $("[name=user_id]").val() != $("[name=id_pass]").val() ){
			  alert("아이디 중복체크 해주세요."); return;
	  	 } 
 	  }
	  
 	 //-------------------------------------------------------
       // 암호와 암호확인 값이 다르면 경고창 띄워주고 name=pwd_confirm 값을 비우고 초점맞추기
       //-------------------------------------------------------

	       if(checkEmpty_pwd_confirm( "[name=pwd]" , "[name=pwd_confirm]"  ,"비밀번호 재확인 입력해주세요.")){return;}	
		    if( $("[name=pwd]").val() != $("[name=pwd_confirm]").val() ){
				alert("입력하신 비밀번호와 확인번호가 일치하지 않습니다."); 
				 $("[name=pwd_confirm]").val("");
			  	 $("[name=pwd_confirm]").focus(); 
				return;
		    }
			
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
			  var pwd_confirm = $("[name=pwd_confirm]").val();
			      
			      if(pwd_confirm!=""&& user_nameCnt == 0){
					     if(confirm('유저명 미입력시 입력한 아이디로 사용됩니다. 이대로 진행하시겠습니까?')==false){
							    alert("유저명을 입력해주세요.")
						    	$("[name=user_name]").val('');
						    	return;
				    	 }else{
							  $("[name=user_name]").val( $("[name=user_id]").val());
							  $(".name_pass").val(	$("[name=user_name]").val()   );
						 }   
					     return;    
			      }
		      //---------------------------------------------
		      // userName 지역변수에 name=user_name 라는 태그를 저장한다.
		      //---------------------------------------------			    
		        var userName= $("[name=user_name]").val();
		      //---------------------------------------------
		      // 만약에 userName 이 NULL 이 아니고 공백이 없고 비어있지 않으면 
		      //---------------------------------------------
		        if(userName!=null && userName.split(" ").join("")!=""){
		      //----------------------------------------------------
		      // 만약에 name=user_name 의 value 값 과 중복학인한 후 통과한 name=name_pass 의 value 값이 다르면
		      // 경고창 띄우기
		      //----------------------------------------------------
		    	 if( $("[name=user_name]").val() != $("[name=name_pass]").val()){
						alert("유저명 중복체크 해주세요."); return;
				    }			    
			     }
		      
		       
		   //**********************************
		   // 생일 유효성 체크하기 
	       //**********************************
				      //--------------------------------- 
					  // 선택한 생일의 년, 월, 일을 변수 birth_year, birth_month, birth_date 에 저장.
					  //---------------------------------	
			 var user_name = $("[name=user_name]").val();	      

			    if(user_name!="" ){   
			    	   //**********************************
					   // 생일 유효성 체크하기 
				       //**********************************
					      //--------------------------------- 
						  // 선택한 생일의 년, 월, 일을 변수 birth_year, birth_month, birth_date 에 저장.
						  //---------------------------------	
					      if(checkEmpty(  "[name=birth_year]"   ,"생일 [년도] 를 입력해주세요.")){return;}
					      if(checkEmpty(  "[name=birth_month]"  ,"생일 [월] 을 입력해주세요.")){return;}
					      if(checkEmpty(  "[name=birth_date]"   ,"생일 [일] 을 입력해주세요.")){return;}

				       //**********************************
				  	   // 주민번호(7자리)  유효성 체크하기 
				       //**********************************			   
					      if( checkEmpty( "[name=jumin_num1]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num1]").val(""); return; }
						  if( checkEmpty( "[name=jumin_num2]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num2]").val(""); return; }
						  $("[name=jumin_num]").val( $("[name=jumin_num1]").val() + "-" +  $("[name=jumin_num2]").val() );


					         // is_valid_jumin_num1( $("[name=jumin_num]"), $("[name=jumin_num2]") 
                              
						//--------------------------------------------------------------------------
						// 주민벝호 중복 체크
						//--------------------------------------------------------------------------
						 if(  $("[name=jumin_num]").val() != $("[name=jumin_pass]").val() ){
							alert("주민번호 중복체크 해주세요."); return;
						}
         }
			   
				      	
 	  //**********************************
      // 이메일 유효성 체크하기 
	  //********************************** 		
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
                			
		  //**********************************
		  // 전화번호(11자리)  유효성 체크하기 
		  //**********************************
			  var email = $("[name=email]").val();	      

		      if(email!="" ){   
					 //--------------------------------------------------------------------------
					 if(checkEmpty(  "[name=tel_num1]" ,"전화번호를 선택해주세요.")){return;}				 		      	
					 //if( checkPattern( "[name=tel_num1]", /^[0-9]{3}$/, "첫번째 전화번호 숫자(3자리)를 입력해주세요.")  ){$("name=tel_num1]").val(""); return; }
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
					 //--------------------------------------------------------------------------
					 // 전화번호 중복 체크				 
					 //--------------------------------------------------------------------------
					 if( $("[name=tel_num]").val() != $("[name=tel_pass]").val() ){
							alert("전화번호 중복체크 해주세요."); return;
					 }
		      }

		      //**********************************
			  // 전화번호(11자리)  유효성 체크하기 
			  //**********************************
				  var tel_num = $("[name=tel_num]").val();	      
				  if(tel_num!="" ){ 
				    //***************************
			  		// 거주지 유효성 체크하기 
			  	    //***************************			    			  	        
               	$("[name=addr]").val( $("[name=addr1]").val() + $("[name=addr2]").val() );	
		  	        if(isEmpty ( $("[name=addr]")  )==true  ){
			  	        alert ("주소지 입력을 확인해주세요")
			  	      return; 
		  	        }     
			      }



			  //**********************************
			  // 동의 체크하기 
			  //**********************************
			   var addr = $("[name=addr]").val();	
		          if(addr!="" ){ 
					 //--------------------------------------------------------------------------
					  if(checkEmpty(  "[name=is_confirm]" ,"약관에 동의체크해주세요.")){return;}			
		          }

			  //**********************************
			  // 동의 체크하기 
			  //**********************************
		      var addr = $("[name=is_confirm]").val();	
		          if( $("[name=is_confirm]").prop("checked")==true){ 
		             //------------------------------------------------------------------------	    
						 if(confirm('입력하신 정보로 회원가입하시겠습니까?')==false){
							 
							 document.userRegForm.reset();
								 					 
					      return;
				      }
		          }
/*  	 
		//**************************
     // 아이디 중복 체크 하기
     //**************************
 	  if( $("[name=user_id]").val() != $("[name=id_pass]").val() ){
			  alert("아이디 중복체크 해주세요."); return;
	  	 } 
   	
   

     //**************************
		// 암호재확인 유효성 체크하기 
     //**************************
	          //-------------------------------------------------------
	          // 암호와 암호확인 값이 다르면 경고창 띄워주고 name=pwd_confirm 값을 비우고 초점맞추기
	          //-------------------------------------------------------
 	       if(checkEmpty(  "[name=pwd_confirm]"  ,"비밀번호 재확인 입력해주세요.")){return;}	
			    if( $("[name=pwd]").val() != $("[name=pwd_confirm]").val() ){
					alert("입력하신 비밀번호와 확인번호가 일치하지 않습니다."); 
					 $("[name=pwd_confirm]").val("");
				  	 $("[name=pwd_confirm]").focus(); 
					return;
				  	}
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
			      if(user_nameCnt == 0){
					     if(confirm('유저명 미입력시 입력한 아이디로 사용됩니다. 이대로 진행하시겠습니까?')==false){
							    alert("유저명을 입력해주세요.")
						    	$("[name=user_name]").val('');
						    	return;
				    	 }else{
							  $("[name=user_name]").val( $("[name=user_id]").val());
							  $(".name_pass").val(	$("[name=user_name]").val()   );
						 }   
					     return;    
			      }
		      //---------------------------------------------
		      // userName 지역변수에 name=user_name 라는 태그를 저장한다.
		      //---------------------------------------------			    
		        var userName= $("[name=user_name]").val();
		      //---------------------------------------------
		      // 만약에 userName 이 NULL 이 아니고 공백이 없고 비어있지 않으면 
		      //---------------------------------------------
		        if(userName!=null && userName.split(" ").join("")!=""){
		      //----------------------------------------------------
		      // 만약에 name=user_name 의 value 값 과 중복학인한 후 통과한 name=name_pass 의 value 값이 다르면
		      // 경고창 띄우기
		      //----------------------------------------------------
		    	 if( $("[name=user_name]").val() != $("[name=name_pass]").val()){
						alert("유저명 중복체크 해주세요."); return;
				    }			    
			     }
			    

	    
				       
*/

/*  
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
JSP에서 유효성 체크 
mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm	     	    
	        //***************************
			// 아이디  유효성 체크하기 
		    //***************************		         
			    if(checkEmpty(  "[name=user_id]" ,"아이디을 입력해주세요.")){return;}
			    if( checkPattern( "[name=user_id]", /^[a-zA-Z]{1}[a-zA-Z0-9]{4,9}$/, "영문 대소문으로 시작, 숫자 포함(5~10자리)")  ){ return; }  
				    if( $("[name=user_id]").val() != $("[name=id_pass]").val() ){
						alert("아이디 중복체크 해주세요."); return;
					} 
				  
			//***************************
			// 암호 유효성 체크하기 
		    //***************************		  
			     if(checkEmpty(  "[name=pwd]"  ,"비밀번호를 입력해주세요.")){return;}		      	
			     if( checkPattern( "[name=pwd]", /(?=.*\d{1,13})(?=.*[~`!@#$%\^&*()-+=]{1,13})(?=.*[a-zA-Z]{2,13}).{6,13}$/, "영문 대소문, 숫자, 특수문자 포함(6~13자리)")  ){ return; }
			
			      if( checkPattern( "[name=pwd]", /^[a-zA-Z0-9!@#$%^&*()_+-=~`]{6,13}$/, "영문 대소문, 숫자, 특수문자 포함(6~13자리)")  ){ return; }
 	
			  
		    //***************************
			// 유저명 유효성 체크하기 
		    //***************************
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
			      if(user_nameCnt == 0){
					     if(confirm('유저명 미입력시 입력한 아이디로 사용됩니다. 이대로 진행하시겠습니까?')==false){
							    alert("유저명을 입력해주세요.")
						    	$("[name=user_name]").val('');
						    	return;
				    	 }else{
							  $("[name=user_name]").val( $("[name=user_id]").val());
							  $(".name_pass").val(	$("[name=user_name]").val()   );
						 }   
			      }			    			    
			     var userName= $("[name=user_name]").val();
			     if(userName!=null && userName.split(" ").join("")!=""){
			    	  if( $("[name=user_name]").val() != $("[name=name_pass]").val() ){
							alert("유저명 중복체크 해주세요."); return;
					    }			    

				     }
			    
			    	//***************************
			  		// 거주지 유효성 체크하기 
			  	    //***************************			    			  	        
			  			    if( checkEmpty( "[name=addr1]","거주지를 선택해주세요.") ){ return; }		     
			  	          	if( checkEmpty( "[name=addr2]","나머지주소를 입력해주세요.") ){ return; }
			  	          	
			  	          	$("[name=addr]").val( $("[name=addr1]").val() + $("[name=addr2]").val() );	   
		  
	       //**********************************
		   // 생일 유효성 체크하기 
	       //**********************************
		      //--------------------------------- 
			  // 선택한 생일의 년, 월, 일을 변수 birth_year, birth_month, birth_date 에 저장.
			  //---------------------------------	
		      if(checkEmpty(  "[name=birth_year]"   ,"생일 [년도] 를 입력해주세요.")){return;}
		      if(checkEmpty(  "[name=birth_month]"  ,"생일 [월] 을 입력해주세요.")){return;}
		      if(checkEmpty(  "[name=birth_date]"   ,"생일 [일] 을 입력해주세요.")){return;}

	       //**********************************
	  	   // 주민번호(7자리)  유효성 체크하기 
	       //**********************************			   
		      if( checkEmpty( "[name=jumin_num1]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num1]").val(""); return; }
			  if( checkEmpty( "[name=jumin_num2]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num2]").val(""); return; }
           //---------------------------------
           // hidden 태그에  담기
           //---------------------------------
			$("[name=jumin_num]").val( $("[name=jumin_num1]").val() + "-" +  $("[name=jumin_num2]").val() );


			if( $("[name=jumin_num]").val() != $("[name=jumin_pass]").val() ){
				alert("주민번호 중복체크 해주세요."); return;
			}		     
			
	
	   	  //**********************************
	      // 이메일 유효성 체크하기 
		  //********************************** 				 			
				 //--------------------------------------------------------------------------
				 if(checkEmpty(  "[name=email1]" ,"이메일 아이디를 입력해주세요.")){return;}				 		      	
				 if( checkPattern( "[name=email1]", /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/, "이메일 아이디를 입력해주세요.")  ){ return; }
				 //--------------------------------------------------------------------------	
				 //if(checkEmpty(  "[name=email_select]" ,"이메일 주소를 선택해주세요.")){return;}	
				 //--------------------------------------------------------------------------
				 if( checkEmpty_email( "[name=email_select]","[name=email2]", "[name=email]" ,'[name=email1]' ,"이메일 주소를 선택해주세요." ) ){ return; }	  
				// if(checkEmpty(  "[name=email2]" ,"이메일 주소를 입력해주세요.")){return;}	
				 if( checkPattern( "[name=email2]", /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/ , "이메일 주소를  올바르게 입력해주세요.")  ){ return; }

				 
				 if( $("[name=email]").val() != $("[name=email_pass]").val() ){
						alert("이메일주소 중복체크 해주세요."); return;
					}
				// $("[name=email]").val($("[name=email1]").val() + "@" +  $("[name=email2]").val()  ); 
							
				
		  //**********************************
		  // 전화번호(11자리)  유효성 체크하기 
		  //**********************************
				 //--------------------------------------------------------------------------
				 if(checkEmpty(  "[name=tel_num1]" ,"전화번호를 선택해주세요.")){return;}				 		      	
				// if( checkPattern( "[name=tel_num1]", /^[0-9]{3}$/, "첫번째 전화번호 숫자(3자리)를 입력해주세요.")  ){$("name=tel_num1]").val(""); return; }
				 //--------------------------------------------------------------------------												 
				 //--------------------------------------------------------------------------
				 if(checkEmpty(  "[name=tel_num2]" ,"전화번호를 입력해주세요.")){return;}				 		      	
				 if( checkPattern( "[name=tel_num2]", /^[0-9]{4}$/, "두번째 전화번호 숫자(4자리)를 입력해주세요.")  ){$("name=tel_num2]").val(""); return; }
				 //--------------------------------------------------------------------------
				 if(checkEmpty(  "[name=tel_num3]" ,"전화번호를 입력해주세요.")){return;}				 		      	
				 if( checkPattern( "[name=tel_num3]", /^[0-9]{4}$/, "세번째 전화번호 숫자(4자리)를 입력해주세요.")  ){$("name=tel_num3]").val(""); return; }
				 //--------------------------------------------------------------------------
				 
				 
				 $("[name=tel_num]").val(
							$("[name=tel_num1]").val() + "-" +  $("[name=tel_num2]").val()  + "-" +  $("[name=tel_num3]").val()  );  

				 if( $("[name=tel_num]").val() != $("[name=tel_pass]").val() ){
						alert("전화번호 중복체크 해주세요."); return;
				 }

		  //**********************************
		  // 동의 체크하기 
		  //**********************************
				 //--------------------------------------------------------------------------
				  if(checkEmpty(  "[name=is_confirm]" ,"약관에 동의체크해주세요.")){return;}				


				  */ 
						
				//    alert(    $("[name=userRegForm]").serialize()  );
				
				//--------------------------------------------------------
				// 현재 화면에서 페이지이동 없이 서버쪽 "${requestScope.croot}/boardRegProc.do"을 호출하여
				// 게시판 글을 입력하고 [게시판 입력 행 적용 개수]를 받기
				//--------------------------------------------------------		
				      $.ajax({
					     
							//----------------------------
							// 호출할 서버쪽 URL 주소 설정
							//----------------------------
							url : "${requestScope.croot}/userRegProc.do"
							//----------------------------
							// 전송 방법 설정
							//----------------------------
							, type : "post"
							//----------------------------
							// 서버로 보낼 파라미터명과 파라미터값을 설정
							//----------------------------
							, data : $('[name=userRegForm]').serialize()
							// , data :  {'user_id':user_id,'pwd':pwd }
							//----------------------------
							// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
							// 매개변수 boardRegCnt 에는 입력 행의 개수가 들어온다.
							//----------------------------		 
							, success : function(json){	
							
								//----------------------------------------
								// 웹서버가 보낸 [유효성 체크 메시지]가 "" 이 아니면
								// 경고 문구 보이고 익명함수 중단하기
		                        //----------------------------------------
								if(json.checkMsg!=""){
		                            alert(json.checkMsg );
									return;
							    }
								//----------------------------------------
								// 웹서버가 보낸 입력 성공 행의 개수가 2이 아니면
								// 경고 문구 보이고 익명함수 중단하기
		                        //----------------------------------------						
								if(json.user_infoRegCnt!=2){
									alert("입력 실패! 관리자에 문의 바람!" + json.user_infoRegCnt);
									return;	
							    }																							     							  	 
									alert("회원등록 성공!");
									//------------------------------------------------
									// name="boardListForm" 를 가진 form 태그 action 값의 URL 주소 서버로 접속하기
									// 결국 게시판 목록보기 화면으로 이동하기
									//------------------------------------------------
									document.loginForm.submit();
								}								
							//----------------------------
							// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
							//----------------------------
							, error : function(){
								alert("서버 접속 실패");
								document.userRegForm.reset();
							}
						});

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
		width:150px;
		/* background-color:lightgray; */
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
			   <h5 style="text-align: left;"  class="txt01">${sessionScope.admin_id} 님 관리자모드로 접속하셨습니다! </h5>
			  </c:if>
			 <!-- 유저로 접속 하였을 때 보여주는 멘트 -->
			<!-- 
			  <c:if test="${!empty sessionScope.user_id}">          
			   <h5 style="text-align: left;"  class="txt01">${sessionScope.user_name}님 환영합니다! </h5>
			  </c:if>
			   -->
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
		 </div> 
	
<div class="container">	
	<form name="userRegForm" method="post" action="${requestScope.croot}/userRegProc.do">	
 	
 	<div class="top_des">
        <h5 class="txt01"><strong>회원가입 시작하기</strong></h5>
        <p>MY NOTE 에 오신걸 환영합니다.</p>
    </div>
 	<div class="col-9">
			 <table class="table">
			  <tbody>
			       <tr>
				      <th scope="row">
				      	<div class="ly_tit"><span><label ><p class="user_id"></p>아이디</label></span></div>
				      </th>
				      <td>
				      <div class="ly_con">
		                 <div>
		                      <div class="pdStyle01 my-2">
		                           <input class="inp05 user_id user_id1"  name="user_id" placeholder="아이디을 입력해주세요." title="아이디을 입력해주세요." type="text" value="" maxlength="10"/>
		                            
		                           <a  style="cursor:pointer"  class="btn_Ttype btn_Ttype1" onclick="checkVerify('id_verify');"><span>중복확인</span></a>
		                           <input type="hidden" name="id_pass" class="id_pass" readonly>
		                           <!-- <a href="#" id="btn_UserID_check" class="btn_Ttype"><span>중복확인</span></a> --> 
		                           <p class="detxt mt10 user_id2 user_id3">영문 대소문으로 시작, 숫자 포함(5~10자리)</p>
		                     </div>
		                 </div>
	             	  </div>
				      </td>
			       </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit my-2"><span><label >비밀번호</label></span></div>
			      </th>
			      <td>
					<div class="ly_con">
                    	<div class="my-2">                                                        
	                        <input class="inp05 pwd pwd1"  name="pwd" placeholder="비밀번호를 입력하세요."  type="password" value="" maxlength="13" />
	                        <p class="detxt mt10 pwd2">
	                            영문 대소문, 숫자 포함(6~13자리)
	                        </p>  
                    	</div>                                                             
              	    </div>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">
			        <div class="ly_tit"><span><label >비밀번호 확인</label></span></div>
			      </th>
			      <td>
				  	<div class="ly_con">
                  	 	<div class="my-2">
	                        <input class="inp05 pwd_confirm pwd_confirm1"  name="pwd_confirm" placeholder="비밀번호를 재입력해주세요."  type="password" value="" maxlength="13"/>
	                         <p class="detxt mt10 pwd_confirm2">비밀번호 확인을 위해 다시 한번 입력해주세요.</p>
                   		</div>
               		</div>
				  </td>
			    </tr>
			    <tr>
			      <th scope="row">
			     	 <div class="ly_tit"><span><label >유저명</label></span></div>
			      </th>
			      <td>
			      	<div class="ly_con">
	                    <div>
	                         <input class="inp05 user_name1"  name="user_name" placeholder="미입력시 아이디값 자동입력"  type="text" value="" maxlength="13" />                       
		                     <a style="cursor:pointer"  class="btn_Ttype btn_Ttype1" onclick="checkVerify('name_verify');"><span>중복확인</span></a>
		                     <p class="detxt mt10 user_name2 user_name3">영문 대소문자,한글, 숫자를 포함(1~10자리)</p>
	                    </div>
	                    <input type="hidden" name="name_pass" class="name_pass" readonly>
               		</div>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit"><span><label >생년월일</label><em class="register_optional"></em></span></div>
			      </th>
			      <td>
			      	 <div class="ly_con">
	                    <div>
	                        <span class="ver_m">
	                            <select class="set01 birth_year" data-holdertext="년도"  name="birth_year"><option value="">년도</option>                           
	                            </select>
	                            
	                            <select class="set01 birth_month" data-holdertext="월" name="birth_month"><option value="">월</option>
	                            </select>
	                            
	                            <select class="set01 birth_date" data-holdertext="일"  name="birth_date"><option value="">일</option>
	                            </select>                       
	                        </span>                      
	                    </div>
	                </div>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit"><span><label >주민등록번호</label>
			      	<br><em class="register_optional">(필수사항)</em></span></div>
			      </th>
			      <td>
			      	<div class="ly_con">
                    	<div>
	                         <input class="inp06 jumin_num1" type="text" name="jumin_num1"  maxlength=6 readonly>
				              -
						 	 <input type="text" name="jumin_num2" class="jumin_num2" maxlength=1 size="1">
							 ******
							 <input type="hidden" name="jumin_num" class="jumin_num">
							<!--  <input type="button" value="중복확인" onclick="checkVerify('jumin_verify');">  -->	                   
		                      
		                       
		                     &nbsp;<a  style="cursor:pointer"  class="btn_Ttype" onclick="checkVerify('jumin_verify');" ><span>중복확인</span></a>
	                         <input type="hidden" name="jumin_pass" class="jumin_pass" readonly>
	                    </div>
	                </div>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit"><span><label >이메일</label><em class="register_optional"></em></span></div>
			      </th>
			      <td>
			      	<div class="ly_con">
	                    <div>
	                         <span class="ver_m">
	                         <input class="inp11" type="text" name="email1" placeholder="아이디 입력" value="" size="12" >   
	                           @
	                         <input class="inp12" type="text" name="email2" placeholder="이메일주소 입력" value="" size="15">    
	                         
	                         <select class="set01 email_select"   name="email_select"><option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="gmail.com">gmail.com</option>
									<option value="daum.com">daum.com</option>
					         </select>&nbsp;
			        		 <a style="cursor:pointer"  class="btn_Ttype" onclick="checkVerify('email_verify');" ><span>중복확인</span></a>
					
					        <input type="hidden" name="email" class="email">
					        <input type="hidden" name="email_pass" class="email_pass" readonly>
	                            <span class="detxt">
	                              
	                            </span>
	                        </span>                      
	                    </div>
	                </div>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit"><span><label >전화번호</label><em class="register_optional"></em></span></div>
			      </th>
			      <td>
			      	<div class="ly_con">
	                    <div>
	                          <select class="set01 tel_num1"   name="tel_num1"><option value="">선택</option>
									<option value="010">010</option>
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
							 
							 <input type="hidden" name="tel_pass" class="tel_pass" readonly>
	                    </div>
	                </div>
			      </td>
			    </tr>
			    <tr>
			      <th scope="row">
			      	<div class="ly_tit"><span><label>거주지역</label><em class="register_optional"></em></span></div>
			      </th>
			      <td>
			      	<div class="ly_con">
	                    <div>
	                        <span class="ver_m">
				                <input type="text" class=" addr1"  name="addr1" placeholder="거주지를 입력" value=""  size="15" maxlength="10">
								<input type="text" class=" addr1"  name="addr2" placeholder="나머지주소를 입력해주세요." value=""  size="35" maxlength="30">
								<input type="hidden" name="addr" class="addr">
			             		<!-- <span class="detxt"></span> -->
	                        </span>
	                    </div>
	                </div>
			      </td>
			    </tr>
			    <tr>
			    	<td colspan=2>
                   <p class="agree_title">개인정보 수집 및 이용</p>
				     <div class="agreem" tabindex="0" style="overflow:auto; width:500px; height:150px;">
				        <div class='stipul pv'>
				             <div class='section' left=0>
				                <h3><a name='a1'>1. (수집하는 개인정보 항목)</a></h3>
				                <p>회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</p>
				                <ol>
				                    <li>
				                        <span class='disp_number'>①</span>수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 비밀번호 질문과 답변 , 자택 전화번호 , 자택 주
				                        소 , 휴대전화번호 , 이메일 , 서비스 이용기록 , 접속 로그 , 쿠키 , 접속 IP 정보 , 결제기록 , 선호 아티스트,
				                        아이핀 번호 , 법정대리인 이름
				                    </li>
				                    <li><span class='disp_number'>②</span>개개인정보 수집방법 : 홈페이지(회원가입, 오디션 응모, 이벤트 참여, 배송요청) , 서면양식</li>
				                </ol>
				
				                <h3><a name='a2'>2. (개인정보의 수집 및 이용목적)</a></h3>
				                <p>회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.</p>
				                <ol>
				                    <li>
				                        <span class='disp_number'>①</span>서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산<br />
				                        콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송
				                    </li>
				                    <li>
				                        <span class='disp_number'>②</span>회원 관리<br />
				                        회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 불량회원의 부정 이용 방지와 비인가 사용 방지 , 가입 의
				                        사 확인 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인 , 불만처리 등 민원처
					                        리 , 고지사항 전달
					                    </li>
					                    <li>
					                        <span class='disp_number'>③</span>마케팅 및 광고에 활용<br />
					                        신규 서비스(제품) 개발 및 특화 , 이벤트 등 광고성 정보 전달 , 인구통계학적 특성에 따른 서비스 제공 및
					                        광고 게재 , 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계
					                    </li>
					                </ol>
					
					                <h3><a name='a3'>3. (개인정보의 보유 및 이용기간)</a></h3>
					                <p>
					                    원칙적으로, 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.<br />
					                    단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 아래와 같이 관계법령에서 정한 일정한 기간
					                    동안 회원정보를 보관합니다.
					                </p>
					
					                <ol>
					                    <li>
					                        <span class='disp_number'>①</span>보존 항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 비밀번호 질문과 답변 , 자택 전화번호 , 자택
					                        주소 , 휴대전화번호 , 이메일 , 서비스 이용기록 , 접속 로그 , 쿠키 , 접속 IP 정보 , 결제기록 , 선호 아티스
					                        트, 아이핀 번호 , 법정대리인 이름
					                    </li>
					                    <li><span class='disp_number'>②</span>보존 근거 : 전자상거래등에서의 소비자보호에 관한 법률</li>
					                    <li><span class='disp_number'>③</span>보존 기간 : 3년</li>
					                    <li>
					                        <ol>
					                            <li><span class="disp_number">1.</span>표시/광고에 관한 기록 : 6개월 (전자상거래등에서의 소비자보호에 관한 법률)</li>
					                            <li><span class="disp_number">2.</span>계약 또는 청약철회 등에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
					                            <li><span class="disp_number">3.</span>대금결제 및 재화 등의 공급에 관한 기록 : 5년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
					                            <li><span class="disp_number">4.</span>소비자의 불만 또는 분쟁처리에 관한 기록 : 3년 (전자상거래등에서의 소비자보호에 관한 법률)</li>
					                            <li><span class="disp_number">5.</span>신용정보의 수집/처리 및 이용 등에 관한 기록 : 3년 (신용정보의 이용 및 보호에 관한 법률)</li>
					                        </ol>                        
					                    </li>                    
					                </ol>
					                <p><br>※ 위의 개인정보 수집·이용에 대한 동의를 거부할 권리가 있습니다. 그러나 동의를 거부할 경우 회원 가입 및 홈페이지 이용이 제한됩니다.</p>
					            </div>
					         </div>
					     </div>
		             <div class="choice ly_con">
		             <div></div>    
		                 <span class="enPc agreeTxt">개인정보 수집 및 이용에 동의합니다.&nbsp;&nbsp;</span>
		                 <span><input class="is_confirm"  name="is_confirm" type="checkbox" /> <label for="AgreePrivacy_Y">동의</label>&nbsp;&nbsp;</span>
		                 <!-- <span><input checked="checked" class="rdo01" id="AgreePrivacy_N" name="AgreePrivacy" type="radio" value="N" /> <label for="AgreePrivacy_N">동의안함</label></span> -->
		             </div> 
	        		 </div>
	        		 </td>
	         	</div>
			    </tr>
			  </tbody>
			</table>
		</div>	
<!-- ------------------------------------------------------------------------------------------------------------------------- -->
		<div class="container">
			<div class="col-3"></div>
			<div class="btn_area_c col-6" style="width: 30%; float:none; margin:0 auto"> 
					<button type="button" class="btn btn-dark btn_Ctype_p btn_Ctype_p2 btn-sm">가입완료
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg></button>
					<button type="button" class="btn btn-dark btn_Ctype_p btn_reset btn-sm" onclick="btn_reset">다시작성
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z"/>
					</svg></button>
	     	        <button type="button" class="btn btn-secondary btn-sm" onclick="goLoginForm();">취소</button>
					
			        <!--  <input type="button"  style='cursor:pointer' class="btn btn-dark btn_Ctype_p btn_Ctype_p2 btn-sm"  value=" 가입완료   "  >
			         <input type="reset"   style='cursor:pointer' class="btn btn-dark btn_Ctype_p btn_reset btn-sm"  onclick="btn_reset"   value=" 다시작성   "  >  -->
			</div> 
			<div class="col-3"></div>   
		</div>
</form>
		<br><br>
 		<div class="container">
			 <div class="jumbotron" style="height:0px; padding-bottom: 50px;">
			 </div>
 		</div>
</div>
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


    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>



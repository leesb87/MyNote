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
<%-- <%@include file="common.jsp" %> --%>




<head>
<meta charset="UTF-8">
<title>회원가입</title>

	

	<script>

	
	$(document).ready(function(){


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
			return;
		}
		//월 데이터가 비었는데 일 데이터가 들어갈 경우
		else if( (birth_month=="" ) && (birth_date!="") ){
			//경고하고 calss=birth_date의 value값의 데이터를 초기화하기
			alert("월을 먼저 입력해 주십시오.");
			$(".birth_date").val("");
			$(".birth_month").focus();
			return;
		}	

		insertValidDate( $(".birth_year"),  $(".birth_month"), $(".birth_date") );	

		if( birth_year!="" && birth_month!="" && birth_date!="" ){
				var jumin_num1 = birth_year.substr(2,2) + birth_month + birth_date;
				$("[name=jumin_num1]").val(jumin_num1);
			}
			
		});


	
	});


	
	//++++++++++++++++++++++++++++++++++++++++++
	// 매개변수로 들어오는  숫자(1,2)에 따라 
	// 아이디 중복확인, 주민번호 중복확인을 실행하는 함수 checkVerify 선언
	//++++++++++++++++++++++++++++++++++++++++++
 	function checkVerify( idJumin ){

 		if(idJumin=='id_verify'){
			if( checkEmpty( "[name=userid]", "ID를 입력해주세요.") ){ return; }
			
			$(".idJuminVal").val( $("[name=userid]").val() );
				}
		else if(idJumin=='jumin_verify'){
			if( checkEmpty( "[name=jumin_num1]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num1]").val(""); return; }
			if( checkEmpty( "[name=jumin_num2]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num2]").val(""); return; }
			$(".idJuminVal").val(
				$("[name=jumin_num1]").val() + "-" +  $("[name=jumin_num2]").val()	);

					}

		$(".check_for").val(idJumin);
		alert( $('[name=form_verify]').serialize() );
		
		///memberRegVerify.do		  
		$.ajax({
			//----------------------------
			// 호출할 서버쪽 URL 주소 설정
			//----------------------------
			url : "${requestScope.croot}/memberRegVerify.do"
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
				if(verifyCnt==1){
					//------------------------------------------------
					// 중복 검색여부 확인결과가 0보다 큰 수이면(중복결과가 있으면)
					// 해당 입력양식의 값을 초기화하고 리턴하기
					//------------------------------------------------

					if(idJumin=='id_verify'){
						alert("중복된 ID가 존재합니다!");
						$("[name=userid]").val("");
						}
					else if(idJumin=='jumin_verify'){
						alert("중복된 주민번호가 존재합니다!");
						$("[name=jumin_num1]").val("");
						$("[name=jumin_num2]").val("");
						}					
				}
				// [회원 등록 성공 개수]가 1개가 아니면
				else{
					if(idJumin=='id_verify'){
						$(".id_pass").val(	$("[name=idJuminVal]").val()   );
						alert("사용가능한 ID 입니다!");
					}else{
						$(".jumin_pass").val(	$("[name=idJuminVal]").val()   );
						alert("사용가능한 주민등록번호 입니다!");
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

   	//--------------------------------------------------
	// 로그인 정보 유효성을 체크하고 비동기방식으로 서버와 통신하여
	// 로그인 정보와 암호의 존재여부에 따른 자스코드 실행하기
	//--------------------------------------------------
	function checkForm(){

		if( checkEmpty( "[name=is_confirm]", "약관에 동의하시면 체크버튼을 눌러주세요.") ){ return; }
		//------------------------------------------------------------------
		if( checkEmpty( "[name=username]", "이름을 입력해주세요.") ){ return; }
		//------------------------------------------------------------------
		if( checkEmpty( "[name=userid]", "ID를 입력해주세요.") ){ return; }
		if( checkEmpty( "[name=id_pass]", "ID중복체크를 진행해 주세요.") ){ return; }
		if( $("[name=userid]").val() != $("[name=id_pass]").val() ){
				alert("중복체크한 ID와 입력된 ID가 다릅니다."); return;
			}
		//------------------------------------------------------------------
		if( checkEmpty( "[name=pwd]", "암호를 입력해주세요.") ){ return; }
		if( checkPattern( "[name=pwd]", /^[0-9]{4}$/, "암호는 숫자 4자리를 입력해주세요.")  ){ return; }
		if( $("[name=pwd]").val() != $("[name=pwd_confirm]").val() ){
			alert("입력하신 비밀번호와 확인번호가 일치하지 않습니다."); return;
			}
		//------------------------------------------------------------------
		$("[name=addr]").val( $("[name=addr_select]").val() );
		if( checkEmpty( "[name=addr]", "주소를 입력해주세요.") )
		//------------------------------------------------------------------
		if( checkEmpty( ".birth_year", "생년월일을 확인해 주십시오.") ){ return; }
		if( checkEmpty( ".birth_month", "생년월일을 확인해 주십시오.") ){ return; }
		if( checkEmpty( ".birth_date", "생년월일을 확인해 주십시오.") ){ return; }
		//------------------------------------------------------------------
		
		if( checkEmpty( "[name=jumin_num1]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num1]").val(""); return; }
		if( checkEmpty( "[name=jumin_num2]", "주민번호 입력을 확인해주세요.") ){ $("[name=jumin_num2]").val(""); return; }
		$("[name=jumin_num]").val(
				$("[name=jumin_num1]").val() + "-" +  $("[name=jumin_num2]").val()
				);
		if( $("[name=jumin_num]").val() != $("[name=jumin_pass]").val() ){
			alert("중복체크한 주민번호와 입력된 주민번호가 다릅니다."); return;
		}
		
		if( is_valid_jumin_num( $("[name=jumin_num]") ) == false ){
			$("[name=jumin_num]").val("");
			return;
			}
		
		if(confirm('입력하신 정보로 회원가입하시겠습니까?')==false){return;}
		
		alert($("[name=memberRegForm]").serialize());

		$.ajax({
			//----------------------------
			// 호출할 서버쪽 URL 주소 설정
			//----------------------------
			url : "${requestScope.croot}/memberRegProc.do"
			//----------------------------
			// 전송 방법 설정
			//----------------------------
			, type : "post"
			//----------------------------
			// 서버로 보낼 파라미터명과 파라미터값을 설정
			//----------------------------
			, data : $('[name=memberRegForm]').serialize()
			//----------------------------
			// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			// 매개변수 boardRegCnt 에는 입력 행의 개수가 들어온다.
			//----------------------------		 
			, success : function(memberRegCnt){	
				// [회원 등록 성공 개수]가 1개면
				if(memberRegCnt==1){
					//------------------------------------------------
					// HttpServletRequest 객체가 가진 "b_no" 라는 키워드로 저장된 객체가 
					// 비어있지 않으면 "게시판 댓글 등록 성공!"
					// null 또는  "" 또는 0 이면  "게시판 새글 등록 성공!"을 alert 상자로 경고하기
					//------------------------------------------------
					alert("회원등록 성공!");
					//------------------------------------------------
					// name="boardListForm" 를 가진 form 태그 action 값의 URL 주소 서버로 접속하기
					// 결국 게시판 목록보기 화면으로 이동하기
					//------------------------------------------------
					document.login.submit();
				}
				// [회원 등록 성공 개수]가 1개가 아니면
				else{
					alert("회원등록 등록 실패! 관리자에게 문의 바람. 오류코드 : " + memberRegCnt);
				}
			} 
			//----------------------------
			// 서버의 응답을 못 받았을 경우 실행할 익명함수 설정
			//----------------------------
			, error : function(){
				alert("서버 접속 실패");
			}
		});

		//------------------------------------------------------------------
		}


	
	</script>





</head>

<body> 

<!----------------------------
입력양식관련 태그들을 하나로 묶기 위한 <form>태그 선언하기
------------------------------->
	<form name = "memberRegForm"
	action = "${requestScope.croot}/memberRegProc.do"
	method="post">

		<!-------------------------------->
		<table border=1 cellpadding=5>
		<!-------------------------------->
			<caption>회원가입</caption>
		
		<tr>
			<th bgcolor='#DBDBDB'>성명</th>
			<td><input type="text" name="username" size=20 maxlength=15 value="진달래"></td>
		</tr>
				
		<tr>
			<th bgcolor='#DBDBDB'>아이디</th>
			<td><input type="text" name="userid" size=20 maxlength=15 value="aa1234">
			<input type="button" value="중복확인" onclick="checkVerify('id_verify');">
			<input type="text" name="id_pass" class="id_pass" readonly>
			</td>
				
		</tr>

		<tr>
			<th bgcolor='#DBDBDB'>암호</th>
			<td><input type="password" name="pwd" size=20 maxlength=15 value="1234"></td>
		</tr>

		<tr>
			<th bgcolor='#DBDBDB'>암호확인</th>
			<td><input type="password" name="pwd_confirm" size=20 maxlength=15 value="1234"></td>
		</tr>
				
		<tr>
			<th bgcolor='#DBDBDB' >거주지역</th>
			<td>
				<select name ="addr_select">
					<option value="">--선택--</option>
					<option value="서울" selected>서울</option>
					<option value="경기">경기</option>
					<option value="인천">인천</option>
					<option value="전라도">전라도</option>
					<option value="경상도">경상도</option>
					<option value="부산">부산</option>
					<option value="충청도">충청도</option>
					<option value="제주도">제주도</option>
					<option value="기타">기타</option>
				</select>
				<input type="text" name="addr" value="">
			</td>
		</tr>

		<tr>
			<th bgcolor='#DBDBDB' >생년월일</th>
			<td>
				<select name="birth_year" class="birth_year">
					<option value="">
				</select>년
				<select name="birth_month" class="birth_month">
					<option value="">
				</select>월
				<select name="birth_date" class="birth_date">
					<option value="">
				</select>일

			</td>
		</tr>
	
		<tr>
			<th bgcolor='#DBDBDB'>주민등록번호</th>
			<td>
			<input type="text" name="jumin_num1" class="jumin_num1" maxlength=6 readonly>
			-
			<input type="text" name="jumin_num2" class="jumin_num2" maxlength=1 size="1">
			******
			<input type="hidden" name="jumin_num" class="jumin_num">
			<input type="button" value="중복확인" onclick="checkVerify('jumin_verify');">
			<input type="text" name="jumin_pass" class="jumin_pass" readonly>
			</td>
			
		</tr>

		<tr>
			<th bgcolor='#DBDBDB'>숙지사항</th>
			<td>본사의 회원가입 약관에 동의합니다.<input type="checkbox" name="is_confirm" value="확인" checked>확인</td>
		</tr>
			
		<!-------------------------------->
		</table>
		<!-------------------------------->


	</form>
	
	<input type="button" value="저장" onclick="checkForm();">
	<input type="button" value="로그아웃" onclick="document.logout.submit();">
	<form name="logout" method="post" action="${requestScope.croot}/logout.do">
	</form>
	<form name="login" method="post" action="${requestScope.croot}/loginForm.do">
	</form>
	
	
	<form name="form_verify" method="post" action="${requestScope.croot}/memberRegVerify.do">
	  <input type="text" name="check_for" class="check_for" readonly>
	  <input type="text" name="idJuminVal" class="idJuminVal" readonly>
	</form>

	</form>
	
 </body>
	
</html>
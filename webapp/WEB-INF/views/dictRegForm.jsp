<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리 방식 선언하기 -->
<!-- ****************************************************** -->
	<!-- 현재 이 JSP 페이지 실행 후 생성되는 문서는 HTML 이고,이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다 라고 설정함 -->
	<!-- 현재 이 JSP 페이지는 UTF-8 방식으로 인코딩 한다 -->
	<!-- UTF-8 인코딩 방식은 한글을 포함 전 세계 모든 문자열을 부호화할 수 있는 방법이다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<!-- ****************************************************** -->
<!-- JSP 기술의 한 종류인 [Include Directive]를 이용하여 -->
<!--								common.jsp 파일 내의 소스를 삽입하기 -->	
<!-- ****************************************************** -->
<%@include file="common.jsp" %>


<!-- Required meta tags -->
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<head>
<title>게시판 글쓰기</title>

	<script>			
		//**********************************************************
		// body 태그 안의 모든 태그를 읽어들인 후 실행할 자스 코딩 설정
		//**********************************************************
		$(document).ready(function( ){
			//----------------------------------------------------------------------------
			// 현재시각 표시 JQuery ＊실제로 DB에 보내지지는 않으나 관리자모드로 보내면 DB로 보내짐(우선도↓)
			//----------------------------------------------------------------------------
			setYMD( $(".reg_date") );
			
			//----------------------------------------------------------------------------
			// 초기화버튼을 누를 시에 'resetWithoutThis'를 제외한 'dictRegForm' 내부의 모든 입력양식값 초기화
			//----------------------------------------------------------------------------
			$(".btn_reset").click(function(){ 
				resetWithoutX( 'dictRegForm', '.resetProof' ); 
				//$("[name='"+dictRegForm+"']").find("input, textarea, select").not("."+resetProof+", :checkbox, :radio, :button, :reset, :submit").val("");
				});  
			 
			//----------------------------------------------------------------------------
			// select 입력양식에 배열 형태로 들어있는 문자열을 option태그에 추가해주는 함수 선언
			//----------------------------------------------------------------------------
			insertArr_to_select( $(".lang_code"), ['한국어','영어','일본어','중국어'] );
			
			//----------------------------------------------------------------------------
			// 단어 중복체크 버튼을 눌렀을 떄 실행되는 함수 선언
			//----------------------------------------------------------------------------
			$(".checkWord").click(function(){	goCheckWord();	});
			
			//----------------------------------------------------------------------------
			// 저장언어 선택 변경시에 단어 입력양식의 값과 중복체크여부 값을 초기화하는 구문 선언
			//----------------------------------------------------------------------------
			$(".lang_code").change(function(){
				$(".word").val("");
			}); 	
			
			//----------------------------------------------------------------------------
			// 내용에 초점이 들어가면 textarea의 값을 지우는 함수 선언
			//----------------------------------------------------------------------------
			//$("[name='content']").focus(function(){	$("[name='content']").text("");
			//	});

			//----------------------------------------------------------------------------
			// 저장하기 버튼을 누르면 유효성체크후 서버로 데이터를 전송하는 함수 선언
			//----------------------------------------------------------------------------
			$(".btn_save").click(function(){ checkRegForm(); });
			 
		});

		//*******************************************
		// [단어 입력 폼]의 데이터 유효성을 체크하고 DB연동 후 결과를 보여주는 함수 checkRegForm 선언
		//*******************************************
		function checkRegForm(){

			//alert("유효성  체크타임!");
			//register word lang_code content _refer _note_no _saveAt
			
			if( $(".note_no").val() == "" ){ alert("단어 중복확인을 실행해 주십시오."); return;}
			if( checkEmpty( ".register", "작성자 입력란에 오류가 발생했습니다. 페이지를 새로고침 해 주세요.") == true ){ $(".note_no").val(""); return;}
			if( checkEmpty( ".word", "입력할 단어를 확인해 주십시오.") == true ){ $(".note_no").val(""); return;}
			if( checkEmpty( ".lang_code", "언어코드를 확인해 주십시오.") == true ){ $(".note_no").val(""); return;}
			//alert(	$(".content").text()+"/"	);
			$(".content").text(  $(".content").text().trim()           );
			if( checkEmpty( ".content", "입력내용을 확인해 주십시오.") == true ){ $(".note_no").val(""); return;}
			//alert(	$(".content").text()+"/"	);
			if(confirm("정말 등록 하시겠습니까?")==false) {
				// 등록 취소할 경우 초기화 예외태그를 제외한 모든 태그의 입력내용 초기화
				resetWithoutX( 'dictRegForm', '.resetProof' ); 
				return;
				}

			//alert( $("[name='dictRegForm']").serialize() );
			
			$.ajax({
				url : "${requestScope.croot}/wordRegProc.do"
				, type : "post"
				, data : $("[name='dictRegForm']").serialize()
				, success : function( insertCnt ){
					alert(  "insertCnt : " +  insertCnt  );
						if(insertCnt==2){
							alert("새 노트 작성 성공!");
							//resetWithoutX( 'dictRegForm', '.resetProof' );
							// confirm("결과를 확인해 보시겠습니까?") -> ( 해당 노트 검색화면으로 이동)
							}
						else if(insertCnt==1){
							alert("노트 꼬리글 작성 성공!");
							}
						else{
							alert("노트 작성 실패! 관리자에게 문의해 주십시오." + insertCnt );
							}  	
						}
				, error : function(){
					alert("서버 접속 실패");
				}
			});	
			

			}

		//*******************************************
		// [단어 중복확인]시에 언어, 언어코드의 유효성을 검사하고 중복된 단어가 존재하는지를 확인하는 함수 goCheckWord 선언
		//*******************************************
		function goCheckWord(){	

			var word = $(".word").val();
			var lang_code = $(".lang_code").val();
			
			if( checkEmpty( ".lang_code", "언어를 선택해 주십시오.") == true ){return;}
			if( checkEmpty( ".word", "단어를 선택해 주십시오.") == true ){return;}

			//alert( word + lang_code);
			$.ajax({
				url : "${requestScope.croot}/wordCheckProc.do"
				, type : "post"
				, data : { "word":word, "lang_code":lang_code }
				, success : function(note_no){
					//alert(  "note_no : " +  note_no  );
					if(note_no!=0){
						if(confirm("이미 등록된 단어입니다. 꼬리글을 작성하시겠습니까?")==false) {
							$(".lang_code").val("");
							$(".word").val("");
							return;
							}
						}
					$(".note_no").val(note_no);
					alert("새 노트를 저장합니다.");  	
					}
				, error : function(){
					alert("서버 접속 실패");
				}
			});	
		}

	//선언한 jQuery객체에 작성시각을 YYYY-MM-DD의 형태로 입력해주는 함수 선언
		function setYMD(jqueryObj){
		
		var today = new Date();
			var year = today.getFullYear();
			var month = today.getMonth()+1;
			var date = today.getDate();
			var week = ["일","월","화","수","목","금","토"][today.getDay()];

		if( month<10) { month = "0" + month; }
		if( date<10) { date = "0" + date; }

		jqueryObj.val(year+"-"+month+"-"+date);
		
		}
		
	// 선택한 form태그의 입력양식 중,
	// exceptionalClassV의 클래스값을 갖는 태그를 제외한 모든 value값을 ""로 만들어주는 함수 선언
	// button, reset, submit의 value값은 자동으로 초기화대상에서 제외됨
				// 초기화대상이 되는 form태그 name값(str)
				// 초기화대상에서 제외되는 태그 X의 class값(str)
	function resetWithoutX( formName, resetProofSelector_X ){

		try{
			if(formName==null || formName.split(" ").join("")==""){alert("form태그의 이름을 문자열로 입력해 주십시오."); return; }
			if(resetProofSelector_X==null){alert("열외태그의 선택자 문자열로 입력해 주십시오."); return; }

		if( resetProofSelector_X==""){
			$("[name='" +formName+ "']").find("input, textarea, select").not(":checkbox, :radio, :button, :reset, :submit").val("");			
		}else{
			$("[name='" +formName+ "']").find("input, textarea, select").not( resetProofSelector_X + ", :checkbox, :radio, :button, :reset, :submit").val("");
			}
		
			$("[name='" +formName+ "'] :checked").prop("checked", false);

		}catch(ex){
			alert("관리자에게 문의하십시오.")
			//alert("resetWithoutX 함수 호출시 에러 발생!" + ex.message);
		}
	}

	//textarea의 최소높이를 지정하고, 텍스트의 줄의 개수에 따라 스크롤이 자동확장되는 함수 선언
	//<주의> HTML5.0 이상에서만 oniput함수가 지원된다.
	function autoResize( element ){
			element.style.height = "5px";
			element.style.height = (element.scrollHeight) + "px";		
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
		    // [ 수정/삭제 ]  이동하는 함수 선언
		    //==================================
			function goDictUpDelForm(){
				document.dictUpDelForm.submit();	
			}
			//==================================
		    // [ 회원정보수정 ]  이동하는 함수 선언
		    //==================================
			function goUserModify(){
				document.userModifyForm.submit();
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

			
			/*  $('.carousel').carousel({
				  interval: 2000
			 }); */
			 
	</script>
	
<style> 
/*  thead th {
	width:150;
	background-color:lightblue;
}
 tbody th {
	width:200;
	background-color:#CFE8EC;
}
 */
.faq-edit-textarea {
	width:100%;
	min-height:50px;
	border:1px;
	solid;
	#ccc;
	overflow;
	hidden;	
	resize:none;
}
.tr td {
			  padding:10;
		 }
			
.bg {
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

<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegProc.do">

	<!-- navigation bar 설정-->
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
				   <!-- <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a> -->
				      <!-- <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a> -->
				      <a class="dropdown-item" href="javascript:goMyNote();">나의 노트</a>
	               <div class="dropdown-divider"></div>
	               	  <c:if test="${empty sessionScope.admin_id}"> 
	               	  	<a class="dropdown-item" href="javascript:goUserModify();">회원정보수정</a>
	               	  </c:if>	
					  <!-- <a class="dropdown-item" href="javascript:goLogout();">로그아웃</a> -->
					   <c:if test="${!empty sessionScope.admin_id}">  
	                     <a class="dropdown-item" href="javascript:goAdminForm();">관리자페이지</a>
					   </c:if>			
	              </div>
	            </li>
	          </ul>
	        </div>
      </nav>
      
	 <div class="jumbotron bg" style="height: 100px; background-color: rgb(35, 67, 105);">
	 </div> 
	 
	<!-- 관리자 OR USER 구분 진입 알림창 -->	 
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
	
	<div class="container">
	   <nav class="navbar navbar-expand-lg navbar-light bg-light">
			<span class="navbar-brand"><b>새 글 등록하기</b></span>
       </nav>
		<div class="jumbotron" style="height:500px; padding-top : 50px;">
		 <div class="container">
		 	<table class="table table-bordered table-dark">
		 		<tbody>
		 			<tr>
				    	<th scope="row" style="text-align:center;" class="text-white">작성자</th>
				    	<td>
				    		<c:choose>
				    			<c:when test="${empty sessionScope.user_id}">
				    				<input type='text' name='register' class='register resetProof form-control' value='${sessionScope.admin_id}'>
				    			</c:when>
				    			<c:otherwise>
				    				<input type='text' name='register' class='register resetProof form-control' value='${sessionScope.user_name}'>
				    			</c:otherwise>
				    		</c:choose>
					    </td>
					    <th scope="row" style="text-align:center;" class="text-white">작성일</th>
				    	<td>
				    		<input type='text' name='reg_date' class='reg_date resetProof form-control' readonly>
					    </td>
				    </tr>
				    <tr>
				    	<th scope="row" style="text-align:center;" class="text-white">언어</th>
				    	<td>
				    		<select name="lang_code" class="lang_code form-control">
							<option value="">--언어선택--</option>
							</select>
					    </td>
					    <th scope="row" style="text-align:center;" class="text-white">단어</th>
				    	<td>
				    		<div class="input-group is-invalid">
					    		<input type='text' name ='word' class='word form-control' placeholder="단어를 입력해 주십시오.">
					    		<button type="button" class="btn btn-light checkWord">중복확인</button>
				    		</div>
					    </td>
				    </tr>
				    <tr>
					    <th scope="row" style="text-align:center;" class="text-white">내용</th>
				    	<td colspan="3">
				    		<textarea rows="5" cols="40" style="border:0" name="content" class="content faq-edit-textarea form-control" 
							rows="4" cols="50" placeholder="내용을 입력해 주십시오." maxlength="100" oninput="autoResize(this);"></textarea>
					    </td>
				    </tr>
				    <tr>
					    <th scope="row" style="text-align:center;" class="text-white">참조</th>
				    	<td>
				    		<input type='text' name='refer' class='refer form-control'>
					    </td>
					    <th scope="row" style="text-align:center;" class="text-white">My Note</th>
				    	<td>
				    		<div class="input-group is-invalid">
					    		<!-- <input type='checkbox' name="saveAt" class="text-white saveAt" value="all" checked>전체공개 -->
					    		 <input type="checkbox" name="saveMynote" class="saveMynote form-check" id="exampleCheck1"  value="saveMynote" checked>
					    		 &nbsp;<label class="form-check-label text-white" for="exampleCheck1">My Note에 저장하기</label>
				    		</div>
					    </td>
				    </tr>
		 		</tbody>
		 	</table>
		 	<div align="center">
			 	<button type="button" class="btn_save btn btn-dark btn-sm">저장하기</button>&nbsp;&nbsp;&nbsp;
			 	<button type="button" class="btn_reset btn btn-dark btn-sm">초기화</button>&nbsp;&nbsp;&nbsp;
			 	<c:if test="${empty sessionScope.admin_id}">          
			 		<button type="button" class="btn_list btn btn-secondary btn-sm" onClick="goFrontPage();">검색하러가기</button>
				</c:if>
		 	</div>
		 </div>
	</div>
			
		<br><br>
 		<!-- <div class="container">
			 <div class="jumbotron" style="height:0px; padding-bottom: 30px;">
			 </div>
 		</div> -->
 		<%-- <div id="carouselExampleControlsNoTouching" class="carousel slide" data-touch="false" data-interval="2000">
			  <div class="carousel-inner">
			    <div class="carousel-item active">
			      <img src="${pageContext.request.contextPath}/resources/img/note.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="${pageContext.request.contextPath}/resources/img/note1.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="${pageContext.request.contextPath}/resources/img/cat.jpg" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <a class="carousel-control-prev" href="#carouselExampleControlsNoTouching" role="button" data-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carouselExampleControlsNoTouching" role="button" data-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
		</div> --%>
</div>
<input type='hidden' name='note_no' class='note_no'>
</form>
		<!-- ============================== -->
		<!-- post 방식으로 이동할 form 태그 --> 	
		<!-- ============================== -->
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
		


		<div class="jumbotron" style="height: 100px; background-color: rgb(255, 255, 255);">
		</div>

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    
    
</body>
</html>

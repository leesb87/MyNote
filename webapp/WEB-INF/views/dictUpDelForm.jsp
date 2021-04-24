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
<%@include file="common_admin.jsp" %>

<%-- <%@include file="common.jsp" %> --%>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" >



<head><title>노트 수정/삭제하기</title>
	<script>			
		//**********************************************************
		// body 태그 안의 모든 태그를 읽어들인 후 실행할 자스 코딩 설정
		//**********************************************************
		$(document).ready(function( ){

			
			//----------------------------------------------------------------------------
			//현재시각 표시 JQuery ＊실제로 DB에 보내지지는 않으나 관리자모드로 보내면 DB로 보내짐(우선도↓)
			//----------------------------------------------------------------------------
			setYMD( $(".reg_date") );
			
			//----------------------------------------------------------------------------
			//초기화버튼을 누를 시에 'resetWithoutThis'를 제외한 'dictRegForm' 내부의 모든 입력양식값 초기화
			//----------------------------------------------------------------------------
			$(".btn_reset").click(function(){ 
				resetWithoutX( 'dictUpDelForm', '.resetProof' ); 
				});  
			
			//----------------------------------------------------------------------------
			// A.select 입력양식에 배열 형태로 들어있는 문자열을 option태그에 추가해주는 함수 선언
			// B.DTO클래스에서 가져온 언어값 이외의 값을 disabled 상태로 만들기
			//----------------------------------------------------------------------------
			insertArr_to_select( $(".lang_code"), ['한국어','영어','일본어','중국어'] );
			$(".lang_code").val('${requestScope.dictDTO.lang_code}');// EL로 변경예정
			$(".lang_code option").not(":selected").attr("disabled", "disabled");
			//$("lang_code").val(${requestScope.dictSearchDTO.lang_code});	//요청메시지에서 lang_code값을 받아와 선택하게 해 놓기
			//----------------------------------------------------------------------------
			//단어 중복체크 버튼을 눌렀을 떄 실행되는 함수 선언  ■ 기본 숨김상태
			//----------------------------------------------------------------------------
			$(".checkWord").click(function(){	alert("!!!");					});
			
			
			//===>> TEST용, readonly, hidden인 입력양식에 테스트용 데이터를 자동입력해주는 구문 선언>>
			/* $(".btn_test").click(function(){
					alert("테스트용 값을 입력합니다!");
					$("[name='word']").val("apple");
					$("[name='note_no']").val("2");
					$("[name='content']").val("사과는 맛있어요");
					$("[name='dict_no']").val("142");
					$("[name='note_no']").val("1");
					 
				});
				 */
			
			});//<=><=><=><=><=><=><=>[ document.ready 구문 종료 ]<=><=><=><=><=><=><=>


		//*******************************************
		// [단어 입력 폼]의 데이터 유효성을 체크하고 DB연동 후 결과를 보여주는 함수 checkRegForm 선언
		//*******************************************
		function checkUpDelForm( str ){
			//$("[name=upDel]").val(upDel);
			//로그인한 계정의 user_name과 작성한 글의 register가 일치하는지 DB에서 확인하고 일치하지 않으면 메시지를 보내고 리턴하는 구문 선언 (구현중)
			//alert("str : " + str);

			//========================▼[삭제모드 확인구문]▼=================================================
			if( str == 'del'){
				if(confirm("해당 글을 삭제 하시겠습니까?")==false) {
					location.replace("${requestScope.croot}/frontPage.do");
					return;
					 }
				}
			//=========================▼[수정모드 확인구문]▼=================================================
			else if( str == 'up'){
			//-------------------------------입력한 내용의 유효성체크구문-----------------------------------------
			if( $(".note_no").val() == "" ){ alert("올바른 접근방식이 아닙니다. 검색화면에서 접근해 주십시오."); return;}
			if( checkEmpty( ".register", "작성자 입력란에 오류가 발생했습니다. 페이지를 새로고침 해 주세요.")==true ){return;}
			$(".word").val(  $(".word").val().trim()           );
			if( checkEmpty( ".word", "입력할 단어를 확인해 주십시오.")==true ){return;}
			if( checkEmpty( ".lang_code", "언어코드를 확인해 주십시오.")==true ){return;}
			if( $(".content").val()=="" ){ alert("입력내용을 확인해 주십시오.2" + $(".content").val() ); return;}
			$(".content").val(  $(".content").val().trim()           );
			//-------------------------------입력한 내용의 유효성체크구문-----------------------------------------
			
			if(confirm("해당 글을 수정 하시겠습니까?")==false) {
				// 등록 취소할 경우 초기화 예외태그를 제외한 모든 태그의 입력내용 초기화
				resetWithoutX( 'dictUpDelForm', '.resetProof' ); 
				return;
				}
			}
			$("[name='upDel']").val(str);

			//$(".lang_code option").not(":disabled").attr("disabled", false);

			//alert( $("[name='dictUpDelForm']").serialize()   );

			$.ajax({
				url : "${requestScope.croot}/dictUpDelProc.do"
				, type : "post"
				, data : $("[name='dictUpDelForm']").serialize()
				, success : function(json){
					//--------------------------------------------------
					//서버가 보낸 Map객체를 JAS에서는 JSON객체로 받는다.
					//--------------------------------------------------
					// JSON객체에서 boardUpDelCnt라는 키값으로 저장된 데이터를 꺼내기
					// 즉 수정/삭제가 성공한 행의 개수를 얻는다.
					var upDelCnt = json.noteUpDelCnt;
					// JSON객체에서 checkMsg라는 키값으로 저장된 데이터를 꺼내기 
					// 즉, 유효성체크시 발생한 경고문구를 얻는다.
					var checkMsg = json.checkMsg;

					//alert("upDelCnt : " + upDelCnt);
					//alert( upDelCnt );

					//---------------------------------------------
					// 수정/삭제하려는 꼬리글이 이미 삭제처리된 글일 떄 메시지 띄우고 홈화면으로 이동시키기
					//---------------------------------------------
					if(upDelCnt==-1){
						var log ="삭제";
						if(str=='up'){var log="수정";}
						alert("꼬리글이 삭제되어 "+log+"할 수 없습니다.");
						location.replace("${requestScope.croot}/frontPage.do");
						return;
						}
					
					//수정 모드일 경우
					if(str=="up"){
						if( checkMsg!="" ){
							alert(checkMsg);
							return;
							}
						//---------------------------------------------
						// 수정 적용행의 개수가 1이면 '수정성공' 메시지 띄우기
						//---------------------------------------------
						if(upDelCnt==1){
							alert("수정 성공!");
							return;
							document.dictUpDelForm.action="${requestScope.croot}/dictContentForm.do";
							document.dictUpDelForm.submit();
							}
						//---------------------------------------------
						// 삭제 적용행의 개수가 -2이면 비밀번호가 틀렸음을 알리고 이동시키기
						//---------------------------------------------
						else if(upDelCnt==-2){
							alert("비밀번호가 일치하지 않습니다.");
							location.replace("${requestScope.croot}/frontPage.do");
							}
						//---------------------------------------------
						// 그 외의 경우 "서버측 DB연동 실패!" 경고하기
						//---------------------------------------------
						else{ 
							alert("서버측 DB연동 실패!");
								}
							}
					//삭제 모드일 경우
					else if(str=="del"){
						//---------------------------------------------
						// 삭제 적용행의 개수가 1이면 '삭제성공' 메시지 띄우기
						//---------------------------------------------
						if(upDelCnt==1){
							alert("삭제 성공!");return;
							document.dictUpDelForm.submit();
							}
						
						//---------------------------------------------
						// 삭제 적용행의 개수가 -2이면 비밀번호가 틀렸음을 알리고 이동시키기
						//---------------------------------------------
						else if(upDelCnt==-2){
							alert("비밀번호가 일치하지 않습니다.");
							location.replace("${requestScope.croot}/frontPage.do");
							}
						//---------------------------------------------
						// 삭제 적용행의 개수가 -3이면 댓글이 있어 삭제할 수 없음을 알리기 
						//---------------------------------------------				
						else if(upDelCnt==-3){
							alert("댓글이 있어 삭제할 수 없습니다.");
							}
						//---------------------------------------------
						// 그 외의 경우 "서버측 DB연동 실패!" 경고하기
						//---------------------------------------------
						else{ 
							alert("서버측 DB연동 실패!");
								}
							}				
						} // function() 종료
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
				if(formName==null || formName.split(" ").join("")==""){ alert("form태그의 이름을 문자열로 입력해 주십시오."); return; }
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

		function goDictListForm(){
			<c:forEach items="${sessionScope.dictSearchDTO.search_keyword}" var="search_keyword">  
	           inputData("[name=dictListForm] [name=search_keyword]", "${search_keyword}");                                                                                 				         
	        </c:forEach>
		
			//var ex_keyword  = $("[name='ex_keyword']").val();
			
			//	$("[name='keyword']").val(	$("[name='ex_keyword']").val()	);		
			
			document.dictListForm.action="${requestScope.croot}/dictList.do";
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
	    // [ 수정/삭제 ]  이동하는 함수 선언
	    //==================================
		function goDictUpDelForm(){
			document.dictUpDelForm.submit();	
		}
		
		//==================================
	    // [ 새글쓰기 ]  이동하는 함수 선언
	    //==================================
		function goDictRegForm(){
			document.dictRegForm.submit();
		}
		//==================================
	    // [ 나의노트 ]  이동하는 함수 선언
	    //==================================
		function goMyNote(){
			document.myNoteForm.submit();
		}
		//==================================
	    // [ 관리자페이지 ]  이동하는 함수 선언
	    //==================================
		function goAdminForm(){
			document.adminForm.submit();
		}
	
	</script>
	
	
<style> 
.tr td {
	  padding:10;
	  font-size: 9pt;
}
			
.bg {
	  /* width: 500px;
	  height: 500px; */
	  background-image: url("${pageContext.request.contextPath}/resources/img/background_02.png");
	  background-size: cover;
	  background-position: center;
	  background-repeat: no-repeat;
 }
 
.faq-edit-textarea {
		width:100%;
		min-height:50px;
		border:1px;
		solid;
		#ccc;
		overflow;
		hidden;	
		font-size: 13pt;
		resize:none;
}
</style>	
	
</head>



<body>
	   
		<!-- navigation bar 설정-->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom"><!-- fixed-top -->
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
	                  <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
	                  <a class="dropdown-item" href="javascript:goMyNote();">나의 노트</a>
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
	   
	   <!-- 접속모드안내 -->
        <div class="alert alert-light alert-dismissible fade show" role="alert">
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
		
		
	<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelProc.do">
			<div class="container">
			  <nav class="navbar navbar-expand-lg navbar-light bg-light">
				<span class="navbar-brand"><b>글 수정/삭제</b></span>
     		  </nav>
				<div class="jumbotron" style="height:500px; padding-top : 50px;">
				 	<table class="table table-bordered table-dark">
				 		<tbody>
				 			<tr>
						    	<th scope="row" style="text-align:center;" class="text-white">작성자</th>
						    	<td>
						    		<!--Session객체에 admin_id가 저장되어 있으면 readonly속성 부여 -->
									<c:if test="${!empty sessionScope.admin_id}">
									 <input type='text' name='register' class='register resetProof form-control' value='${sessionScope.admin_id}'>
									</c:if>
									<c:if test="${empty sessionScope.admin_id}">
									 <input type='text' name='register' class='register resetProof form-control' value='${sessionScope.user_name}' readonly> 
									</c:if>
							    </td>
							    <th scope="row" style="text-align:center;" class="text-white">작성일</th>
						    	<td>
						    		<input type='text' name='reg_date' class='reg_date resetProof form-control' readonly>
							    </td>
						    </tr>
						    <tr>
						    	<th scope="row" style="text-align:center;" class="text-white">언어</th>
						    	<td>
						    		<select name="lang_code" class="lang_code resetProof form-control">
										<option value="">--언어선택--</option>
									</select>
							    </td>
							    <th scope="row" style="text-align:center;" class="text-white">단어</th>
						    	<td>
						    		<!-- 관리자계정으로 접속시 중복확인 버튼 활성화 -->
						    		<div class="input-group is-invalid">
							    		<input type='text' name ='word' class='word form-control' placeholder="단어를 입력해 주십시오." value='${requestScope.dictDTO.word}' readonly>
							    		<c:if test="${!empty sessionScope.admin_id}">
										 <button type="button" class='checkWord btn btn-light btn-sm'>중복확인</button>
										</c:if>
										<c:if test="${empty sessionScope.admin_id}">
										 <button type="button" class='checkWord btn btn-light btn-sm'>중복확인</button>
										</c:if>
									</div>
							    </td>
						    </tr>
						    <tr>
							    <th scope="row" style="text-align:center;" class="text-white">내용</th>
						    	<td colspan="3">
						    		<textarea rows="5" cols="40" style="border:0" name="content" class="content faq-edit-textarea" 
									rows="4" cols="50" placeholder="내용을 입력해 주십시오." maxlength="100" 
									oninput="autoResize(this);"> <c:choose><c:when test="${empty sessionScope.admin_id}">${requestScope.dictDTO.content}</c:when><c:otherwise>"현재 페이지는 관리자 모드입니다."</c:otherwise></c:choose></textarea>
							    </td>
						    </tr>
						    <tr>
							    <th scope="row" style="text-align:center;" class="text-white">참조</th>
						    	<td>
						    		<input type='text' name='refer' class='refer form-control' value='${requestScope.dictDTO.refer}'>
							    </td>
							    <th scope="row" style="text-align:center;" class="text-white">My Note</th>
						    	<td>
							    	<div class="input-group is-invalid">
							    		 <input type="checkbox" name="saveAt" class="saveAt form-check" id="exampleCheck1" value="all" checked>
							    		 &nbsp;<label class="form-check-label text-white" for="exampleCheck1">My Note에 저장하기</label>
					    			</div>
						    		<!-- <input type='checkbox' name="saveAt" class="saveAt" value="all" checked>전체공개 -->
							    </td>
						    </tr>
				 		</tbody>
				 	</table>
				 	<div align="center" >
				 		<button type="button" class='btn_update btn btn-dark btn-sm' onClick="checkUpDelForm('up');">수정</button>
					 	&nbsp;&nbsp;
				 		<button type="button" class='btn_delete btn btn-dark btn-sm' onClick="checkUpDelForm('del');">삭제</button>
					 	&nbsp;&nbsp;
				 		<button type="button" class='btn_reset btn btn-dark btn-sm'>초기화</button>
					 	&nbsp;&nbsp;
					 		<button type="button" class="btn_list btn btn-secondary btn-sm" onClick="goDictList();">목록으로</button>
				 		<%-- <c:if test="${empty sessionScope.admin_id}">          
						</c:if> --%>
				 	</div>
				 </div>
			</div>
				<br><br>
		 	<input type='hidden' name='dict_no' class='dict_no' value="${requestScope.dictDTO.dict_no}">	
			<input type='hidden' name='note_no' class='note_no resetProof' value="${requestScope.dictDTO.note_no}">
			<input type='hidden' name='upDel'>
			
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
			    <input type="hidden" name="keyword" value="${sessionScope.dictSearchDTO.keyword}" >   
				<input type="hidden" name="lang_code" value="${sessionScope.dictSearchDTO.lang_code}">
				<input type="hidden" name="selectPageNo" value="1">
				<input type="hidden" name="rowCntPerPage" value="${sessionScope.dictSearchDTO.rowCntPerPage}">				
				<input type="hidden" name="detail_search" value="${sessionScope.dictSearchDTO.detail_search}">
				<input type="hidden" name="detail_keyword" value="${sessionScope.dictSearchDTO.detail_keyword}">
				<input type="hidden" name="search_date" value="${sessionScope.dictSearchDTO.search_date}">
				<input type="hidden" name="range" value="${sessionScope.dictSearchDTO.range}">
				<input type="hidden" name="begin_year" value="${sessionScope.dictSearchDTO.begin_year}">
				<input type="hidden" name="begin_month" value="${sessionScope.dictSearchDTO.begin_month}">
				<input type="hidden" name="end_year" value="${sessionScope.dictSearchDTO.end_year}">
				<input type="hidden" name="end_month" value="${sessionScope.dictSearchDTO.end_month}">
				<input type="hidden" name="orderby" value="${sessionScope.dictSearchDTO.orderby}">
				<input type="hidden" name="asc_desc" value="${sessionScope.dictSearchDTO.asc_desc}">
				<input type="hidden" name="top" value="${sessionScope.dictSearchDTO.top}">	
				<input type="hidden" name="search_keyword" value="전체선택">
				<input type="hidden" name="search_keyword" value="단어" >	
				<input type="hidden" name="search_keyword" value="작성자" >
				<input type="hidden" name="search_keyword" value="내용" >			
				<!-- <input type="text" name="ex_keyword" value="${param.ex_keyword}" placeholder="List에서 온 애" size="50"> -->	
		</form>
		
		<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do"></form>

		<!-- [ 노트 수정/삭제 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"></form>
		
		<!-- [ 관리자페이지 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do"></form>   
		
		<!-- [ 더보기  ] 화면 이동하는 form 태그 선언하기 -->  
		<form name="dictContentForm" method="post" action="${requestScope.croot}/dictContentForm.do"> 
	        <input type="hidden" name="keyword" value="${requestScope.dictDTO.word}" >  
	        <input type="hidden" name="lang_code" value="${sessionScope.dictSearchDTO.lang_code}">
	        <input type="hidden" name="dict_no" value="${requestScope.dictDIO.dict_no}">
	        <input type="hidden" name="selectPageNo" value="1">
			<input type="hidden" name="rowCntPerPage" value="${sessionScope.dictSearchDTO.rowCntPerPage}">
			<input type="hidden" name="ex_keyword" value="${sessionScope.dictSearchDTO.keyword}">
		</form>
		
		<!-- [ 나의 노트 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="myNoteForm" method="post" action="${requestScope.croot}/mynote.do"></form>
		
		
		<div class="jumbotron" style="height: 100px; background-color: rgb(255, 255, 255);">
		</div>
		
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>

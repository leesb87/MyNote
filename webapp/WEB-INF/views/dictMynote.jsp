<!--  ********************************************************* -->
<!--  JSP기술의 한 종류인 [Page Directive]를 이용하여 현 JSP 페이지 처리방식 선언하기 -->
<!--  ********************************************************* -->
	<!--  현재 이 JSP페이지 실행 후 생성되는 문서는 HTML이고, 이 문서 안의 데이터는 UTF-8 방식으로 인코딩한다, 라고 설정한다. -->
	<!--  현재 이 JSP페이지는 UTF-8방식으로 인코딩한다. -->
	<!--  UTF-8 인코딩 방식은 한글을 포함한 전세계 모든 문자열을 부호화할 수 있는 방법이다. -->

<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- 현재 JSP페이지에서 사용할 java클래스 수입하기 -->
<%@ page import="java.util.*" %>
		
<!DOCTYPE html>
<html>

<!-- ******************************************************* -->
<!-- JSP기술의 한 종류인 [Include Directive]를 이용하여      -->
<!-- 					  common.jsp파일 내의 소스를 삽입하기 -->
<!-- ******************************************************* -->
<%@include file="common.jsp" %>

<%-- <%@include file="common.jsp" %> --%>


<!-- jsp파일이 같은 폴더 안에 없을 경우 include file="/WEB-INF/views/common.jsp"로 경로를 설정하며,
	 해당 파일을 찾을 수 있다.
 --> 
<!-- Required meta tags -->
 <meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">

<head>

<title>MYNOTE</title>

<style> 

.bookmarks {
   position:fixed;
   right:30px;
   bottom:30px;
   width:100px;
   /* border:1px solid black;  */
   z-index:1;
}

</style>		
	

	<script>
	$(document).ready(function(){
		$(".myNote_orderby, .asc_desc").change(function(){
			   var orderby  = $(".myNote_orderby").val();
			   var asc_desc = $(".asc_desc").val();				
				if(  (orderby=="") &&   (asc_desc!="") ){                 				    
					$(".myNote_orderby").val("rate_cnt")	
										 
				return;		
				}	
				if( (orderby=!"") &&   (asc_desc=="") ){                 				    
					 $(".asc_desc").val("desc");
					 $(".arrow").text(" ▼ "); 
				}
			});	
		 //--------------------------------------------------------

			  $("[name=asc_desc]").change(function(){	
				  	       
		           var asc_desc = $("[name=asc_desc]").val();
		           if(asc_desc=="") {		        	                 
		        	   $(".arrow").text("기준");
		           }
		           else if(asc_desc=="desc") {            
		        	   $(".arrow").text(" ▼ "); 
		           }
		           else if(asc_desc=="asc") {           
		        	   $(".arrow").text(" ▲ ");
		           }
		           
		    	  
		      });




		
		<c:forEach items="${sessionScope.dictSearchDTO.myNote_search}" var="myNote_search">  
        inputData("[name=dictListForm] [name=myNote_search]", "${myNote_search}");                                                                                 				         
      </c:forEach>

		 inputData(".keyword" , "${sessionScope.dictSearchDTO.keyword}");
		  inputData(".myNote_orderby"     , "${sessionScope.dictSearchDTO.myNote_orderby}");
		  inputData(".asc_desc"    , "${sessionScope.dictSearchDTO.asc_desc}");
    
		//-------------------- [정렬 흔적 남기기 ] -----------------	
	         <c:if test="${empty sessionScope.dictSearchDTO.asc_desc}">                 
		            $(".arrow").text("기준");
		     </c:if>   
		     <c:if test="${sessionScope.dictSearchDTO.asc_desc=='desc'}">
		            $(".arrow").text(" ▼ ");
		     </c:if>  
	      
		     <c:if test="${sessionScope.dictSearchDTO.asc_desc=='asc'}">
		            $(".arrow").text(" ▲ ");
		     </c:if>

		  
		//alert("${requestScope.dictSearchDTO.selectPageNo}" + "${requestScope.dictSearchDTO.rowCntPerPage}"  );

		//===========결과값의 lang_code에 따라 th태그에 색을 입혀주는 jQeury문 선언===============
		$(".lang_color_1 tr th").css({'background-color': '#A4FFF9'});
		$(".lang_color_2 tr th").css({'background-color': 'lightgreen'});
		$(".lang_color_3 tr th").css({'background-color': 'lightpink'});
		$(".lang_color_4 tr th").css({'background-color': 'lightyellow'});

		$(".bookmark_1").css({'background-color': '#A4FFF9'});
		$(".bookmark_2").css({'background-color': 'lightgreen'});
		$(".bookmark_3").css({'background-color': 'lightpink'});
		$(".bookmark_4").css({'background-color': 'lightyellow'}); 
		//========================================================================================
		//$("td").css({'background-color': 'magenta'});
		   
			// enterkey 누르면 search()함수 작동
			$(".keyword").keypress(function(event){
				if ( event.which == 13 ) {
					$('.keywordSearch').click();
					return false;
				}
			});
			// 공용함수 enterKey로 검색하기
			//enterKey( $(".keyword"), $('.keywordSearch') );
			
			//---------------------------------------------------------------------
			/* 페이징 처리 코드 파트 */
			//--------------------------------------
			/*  alert(
					"requestScope.dictListAllCnt_total=>${requestScope.dictListAllCnt_total}"                // 검색 결과 총 행 개수
					+"\n requestScope.selectPageNo=>${requestScope.dictSearchDTO.selectPageNo}"   // 선택된 현재 페이지 번호
					+"\n requestScope.rowCntPerPage=>${requestScope.dictSearchDTO.rowCntPerPage}"  // 페이지 당 출력행의 개수
			);  */ 
			
			// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
			 $(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.dictList_contentAllCnt}"          // 검색 결과 총 행 개수
						,"${requestScope.dictSearchDTO.selectPageNo}"   // 선택된 현재 페이지 번호
						,"${requestScope.dictSearchDTO.rowCntPerPage}"  // 페이지 당 출력행의 개수
						,"5"                                            // 페이지 당 보여줄 페이지번호 개수
						,"search_when_pageNoClick();"                   // 페이지 번호 클릭 후 실행할 자스코드
					)   // ; 은 찍으면 안됨
			);
		
	});

	//****************************************
	// [초기화] 함수 선언
	//******************
	function resetAll(){
		$("[name='dictListForm'] [name=keyword]").val("");
		$("[name='dictListForm'] [name=myNote_search]").val("전체");
	    $("[name='dictListForm'] [name=selectPageNo]").val("1");	    
	    //$("[name='dictListForm'] [name=search_keyword]").prop("checked",false);
        
 
	    $("[name='dictListForm'] [name=lang_code]").val("0");		

		$("[name='dictListForm'] [name=myNote_orderby]").val("");
		
		$("[name='dictListForm'] [name=asc_desc]").val("");
	
		$(".arrow").text("기준");
	}
	//****************************************
	// [키워드 검색] 함수 선언
	//******************
	function search(){
 
			//alert("검색시작!");

			
			//---------------------------------------
			// 만약 키워드가 비어있거나 공백으로 구성되어 있으면, ""로 세팅하기
			// <주의> 공백이면 공백으로 DB연동하므로 공백으로만 되어 있으면 ""로 세팅한다.
			//---------------------
			/*
			if( isEmpty(	$("[name=dictListForm] [name=keyword]")		) ){
				alert("검색 조건이 비어있어 검색할 수 없습니다.");
				$("[name=dictListForm] [name=keyword]").val("");
				$("[name=dictListForm] [name=keyword]").focus();
				return;
			}
			*/
			var lang_code = $("[name=dictListForm] [name=lang_code]").val();
			//alert(lang_code);
			$("[name=dictListForm] [name=lang_code]").val(lang_code);
			//alert(lang_code);
			var keyword = $("[name=dictListForm] [name=keyword]").val();
			//alert(keyword);
			keyword = $.trim(keyword);
			$("[name=dictListForm] [name=keyword]").val(keyword);
           // alert(keyword);
            $(".selectPageNo").val("1");
            $(".rowCntPerPage").val("10");
			
			//alert(   $("[name=dictListForm] [name=keyword]").serialize()  );
			document.dictListForm.submit();
	
	}
	//****************************************
	// [각 언어별 키워드 검색] 함수 선언
	//******************
	function goTabDictList( str ){

	      // 유효성 검사
	       if( isEmpty($("[name=dictListForm] .keyword")) ){
	            alert("검색 조건이 비어있어 검색할 수 없습니다.");
	            $("[name=keyword]").val("");
	            return;
	         }
	      //alert( "str " + str + "!" );
	      // 키워드의 앞뒤 공백을 제거하기
	      var keyword = $("[name=dictListForm] .keyword").val();
	      keyword = keyword.trim();
	       //alert (str );
	      // 히든에 키워드 및 lang_code, 북마크 흔적 넣기, 
	      $("[name=dictListForm] [name=keyword]").val(keyword);
	      $("[name=dictListForm] [name=lang_code]").val(str);
	      $("[name=dictListForm] [name=selectPageNo]").val('1');
	       
	      
	
	      //var lang_code = "${sessionScope.lang_code}";
	      //$("[name=dictListForm] [name=lang_code]").val(lang_code);
	
	      //alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
	
	      document.dictListForm.submit();
	      
            
   }
	
	//****************************************
	// [페이징 처리]관련 함수 선언 파트
	//******************	
	// 페이지 번호 클릭하면 호출되는 함수 선언
	function search_when_pageNoClick( ){
		
			// 페이징 NO. 선택할 때, 페이지 이동시에도 검색어 흔적남기는 코드
			var keyword = $("[name=dictListForm] [name=keyword]").val();
			
			if( keyword!=null && keyword.split(" ").join("")!="" ){
				keyword = $.trim(keyword);
				$("[name=dictListForm] [name=keyword]").val(keyword);
			}
			//alert( $("[name=dictListForm]").serialize() );


			var lang_code = "${sessionScope.lang_code}";
			$("[name=dictListForm] [name=lang_code]").val(lang_code);

			document.dictListForm.action="${requestScope.croot}/mynote.do";
			document.dictListForm.submit();
		 
	}
  
	function goDictListForm(){
		alert("목록보기 눌렀냉!");

		<c:forEach items="${sessionScope.dictSearchDTO.search_keyword}" var="search_keyword">  
       		 inputData("[name=dictListForm] [name=search_keyword]", "${search_keyword}");                                                                                 				         
        </c:forEach>
		inputData(".selectPageNo", "${sessionScope.dictSearchDTO.selectPageNo}");
		var ex_keyword  = $("[name='ex_keyword']").val();
		
		
		$("[name='keyword']").val(	$("[name='ex_keyword']").val()	);		
		
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
		    // [ 관리자페이지 ]  이동하는 함수 선언
		    //==================================
			function goAdminForm(){
				document.adminForm.submit();
			}
			//==================================
		    // [ 회원정보수정 ]  이동하는 함수 선언
		    //==================================
			function goUserModify(){
				document.userModifyForm.submit();
			}

			
			//****************************************
			// Mynote 등록 함수 선언 파트 // dictContentForm, dictMyNoteForm에도 첨부된 함수와 함께 등록해 주세요! [4/5]
			// <span class="btn_mynote" style="cursor:pointer" onClick="insertMynote(${loopTagStatus.index});">MYOTE에 추가</span>
			// 위 함수는 2중테이블을 출력하는 forEach문의 table의 클래스값에 loopTagStatus.index이 함께 등록되어 있어야 가동합니다.
			//****************************************
			function insertMynote( idx ){
				
				var tableObj = $(".dictList").find(".dictListTable_"+idx);
				var dict_no = tableObj.find("[name=dict_no]").val();
				var lang_code = tableObj.find("[name=lang_code]").val();
				var user_id = $(".user_id").val();
	
				//$("[name=recommendForm] [name=d_no]").val(dict_no);
				//$("[name=recommendForm] [name=lang_code]").val(lang_code);
				//alert( $("[name=recommendForm]").serialize());
				var turnOff = "turnOff";
				$.ajax({
					url : "${requestScope.croot}/insertMynote.do"
					, type : "post"
					, data : {"user_id":user_id, "lang_code":lang_code, "dict_no":dict_no}
					, success : function( cnt ){
						if(cnt==1){alert("MYNOTE 등록 성공!");}
						else if(cnt==-1){
							//alert("이미 MYNOTE에 등록된 꼬리글입니다.");
							//MYNOTE 등록을 해제할지 물어보고 YES일 경우 해당 꼬리글의 계정 mynote값을 0으로 변경하도록 DB연동하기
							if(confirm('이미 MYNOTE에 등록된 꼬리글입니다. MYNOTE 등록을 해제하시겠습니까?')==false){return;}
								
							$.ajax({
								url : "${requestScope.croot}/insertMynote.do"
								, type : "post"
								, data : {"user_id":user_id, "lang_code":lang_code, "dict_no":dict_no, "turnOff":turnOff}
								, success : function( turnOffcnt ){

						//if(turnOffCnt==0) {return -2;}			//수정행 개수가 0이면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기
					 	//else if(turnOffCnt==1) {return 2;}		//수정행 개수가 1이면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기
					 	//else { return -3;}						//수정행 개수가 0도 1도 아니면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기

									if(turnOffcnt==2){alert("MYNOTE가 해제되었습니다.");
									

								    }
									else if(turnOffcnt==-2){alert("MYNOTE를 해제할 꼬리글이 존재하지 않습니다.");}
									else{alert("MYNOTE 해제 실패! 관리자에게 문의해 주십시오. :" + turnOffcnt);	}
								}
								, error : function(){
									alert("MYNOTE해제 관련 서버 접속 실패");
								}
							});	//내부 ajax 종료
							
							}
						else{alert("MYNOTE 등록 실패! 관리자에게 문의해 주십시오. :" + cnt);	}
					}
					, error : function(){
						alert("서버 접속 실패");
					}
					
				});



				

				}
			
	</script>
<style>

.th{
		  /* padding:12; */
		  /* my-4; */
		    text-align:center;;
	 }
		
.bg {
	  /* width: 500px;
	  height: 500px; */
	  background-image: url("${pageContext.request.contextPath}/resources/img/background_04.png");
	  background-size: cover;
	  background-position: center;
	  background-repeat: no-repeat;
 }
 .table {
        table-layout: fixed
    }

</style>
</head>
<body><center>

	<!-- 북마크 -->
	<div class="bookmarks">
			<table class="table table-sm table-secondary table-hover">
				<thead>
				<tr><th bgcolor=#DBDBDB style="text-align: center;" width=90px><b>BOOKMARK</b></th></tr>
				</thead>
				<tbody>
				<tr><td style="cursor:pointer; text-align: center;" class="bookmark bookmark_0" onclick="goTabDictList('0');"><b>통합검색
						</b></td></tr>
				<tr><td style="cursor:pointer; text-align: center;" class="bookmark bookmark_1" onclick="goTabDictList('1');"><b>한국어
						</b></td></tr>
				<tr><td style="cursor:pointer; text-align: center;" class="bookmark bookmark_2" onclick="goTabDictList('2');"><b>영어
						</b></td></tr>
				<tr><td style="cursor:pointer; text-align: center;" class="bookmark bookmark_3" onclick="goTabDictList('3');"><b>일본어
						</b></td></tr>
				<tr><td style="cursor:pointer; text-align: center;" class="bookmark bookmark_4" onclick="goTabDictList('4');"><b>중국어
						</b></td></tr>
				</tbody>
			</table>
	</div>


	<!-- navigation -->
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
	                  <!-- <a class="dropdown-item" href="javascript:goDictListForm();">검색 목록</a> -->
				      <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
					  <!-- <a class="dropdown-item" href="javascript:goDictUpDelForm();">글 수정/삭제</a> -->
	               <div class="dropdown-divider"></div>
					  <a class="dropdown-item" href="javascript:goUserModify();">회원정보수정</a>			
	                  <a class="dropdown-item" href="javascript:goUserRegForm();">회원가입</a>
					  <!-- <a class="dropdown-item" href="javascript:goLogout();">로그아웃</a> 	 -->		
	              </div>
	            </li>
	          </ul>
	        </div>
      </nav>
	  <div class="jumbotron bg" style="height: 280px; background-color: rgb(35, 67, 105);">
		  <h3 class="text-white display-5"><strong>MY NOTE</strong> 에 오신 것을 환영합니다.</h3>
		  <hr class="my-4">
		  <p class="text-white"> "MyNote"페이지에서는 직접 저장해두었던 글과 추천했던 글을 모아서 볼 수 있습니다.</p>
	  </div>
	 
	 <!-- 접근자 안내 방법2 -->
	 <div class="alert alert-light alert-dismissible fade show" role="alert">
		  <%--   <h3 style="text-align: left;"  class="txt01"> ${sessionScope.admin_id} 님 '관리자모드'로 접속하셨습니다! </h3> --%>
		  <!-- 관리자로 접속 하였을 때 보여주는 멘트 -->
		  <%-- <c:if test="${!empty sessionScope.admin_id}">          
		   <h4 style="text-align: left;"  class="txt01">${sessionScope.admin_id} 님 관리자모드로 접속하셨습니다! </h4>
		  </c:if> --%>
		 <!-- 유저로 접속 하였을 때 보여주는 멘트 -->
		  <c:if test="${!empty sessionScope.user_id}">          
		   <h5 style="text-align: left;"  class="txt01">${sessionScope.user_name}님 환영합니다! </h5>
		  </c:if>
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
	 </div> 

	
<!-- 메인화면 -->
<div class="all container">
<form name="dictListForm" method="post" action="${requestScope.croot}/mynote.do">
		<br><br><br><br>
			<!-- 언어탭 선택 파트  -->		
			<div class="btn-group float-left" role="group" aria-label="Basic example">
			  <button type="button" class="btn btn-secondary" onClick="goTabDictList('0');"><strong>통합검색</strong></button>
			  <button type="button" class="btn btn-secondary" onClick="goTabDictList('1');"><strong>한국어</strong></button>
			  <button type="button" class="btn btn-secondary" onClick="goTabDictList('2');"><strong>영어</strong></button>
			  <button type="button" class="btn btn-secondary" onClick="goTabDictList('3');"><strong>일본어</strong></button>
			  <button type="button" class="btn btn-secondary" onClick="goTabDictList('4');"><strong>중국어</strong></button>
			</div>
			<div class="jumbotron" style="height: 250px;">
					<div class="cnt txt01" style="text-align: left">
						<b>[등록된 MY NOTE 개수]:
						<c:choose>
							<c:when test="${requestScope.mynote_cnt==0}">
								<span>0</span>
							</c:when>
							<c:otherwise>
								<span>${requestScope.mynote_cnt}</span>
							</c:otherwise>
						</c:choose>
						</b>
					</div>
					<div  style="height: 10px;"></div>
					<!-- 상세 검색 파트 -->
					<div class="container">
							<div class="row">
								<div class="col"></div>
								<div class="col-6">
								<div class="input-group is-invalid" style="text-align: center;">
									<select name="myNote_search" class="myNote_search detail form-control custom-select" style="width:50px;">    
									         <option value="전체">전체</option>
									         <option value="단어">단어</option>						       							       
											 <option value="작성자">작성자</option>
											 <option value="내용">내용</option>         
										</select>
									<input type="text" name="keyword" value="" class="keyword form-control" style="width:170px;"  placeholder="검색어를 넣어주세요" size="50">							
									<button type="button" class="keywordSearch btn btn-dark" onClick="search();">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
				 						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
									</svg></button>
								     &nbsp;
								    <button type="button" class="resetAll btn btn-secondary" onclick="resetAll();">초기화</button>
									<!-- <input type="hidden" class="lang_code" name="lang_code"> -->
								    <input type="hidden" name="ex_keyword" value="${param.ex_keyword}" class="ex_keyword"  placeholder="List에서 온 애" size="50">
									<input type="hidden" name="lang_code" value="${param.lang_code}">
								</div>
								</div>
							<div class="col">
							</div>
						</div>
						<div  style="height: 10px;"></div>
						<div class="row">
						<div class="col"></div>
							<div class="col-6">
							      <div class="input-group is-invalid">
							      		<label class="my-2 mr-2"><b>정렬</b></label>&nbsp;
										<select name="myNote_orderby" class ="myNote_orderby detail form-control-sm" style="text-align: center;">
											<option value="">선택</option>
											<option value="rate_cnt">추천수순</option>
											<option value="input_date">게시글등록일</option>
											<option value="add_date">MyNote등록일순</option>																	
										</select>&nbsp;&nbsp;
										<label class="my-2 mr-2 arrow" style="cursor:pointer"><b>기준</b></label>
										<select name="asc_desc" class ="asc_desc detail form-control-sm" style="text-align: center;">
										    <option value="">선택</option>
											<option value="desc">내림차순</option>
											<option value="asc">오름차순</option>																
										</select>&nbsp;&nbsp;&nbsp;	
								  </div>
							</div>
							<div class="col">
							</div>
						</div>
					</div>
					
				</div><!-- jumbotron 끝 -->	
					<!-- 페이징 처리 관련 파트 -->
					<!--선택한 페이지번호가 저장되는 입력양식 표현하기 선택한 페이지번호는 DB 연동시 아주 중요한 역할을 한다.-->	
					<input type="hidden" name="selectPageNo" class="selectPageNo" value="${param.selectPageNo}">
				    <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="${param.rowCntPerPage}"> 
				     
				    <br><br>
				    
					<!---페이징 번호를 삽입할 span 태그 선언하기------>
					<div class="paging">&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
					<!-- <input type="text" name="paging"> -->
					
		</form><!-- dictListForm 끝 -->	
		
	<div class="container">			
		<div class="dictList">
				<!-- 통합검색 -->
				<c:forEach items="${requestScope.mynoteList}" var="dict" varStatus="loopTagStatus" >
				<table class="table dictListTable_${loopTagStatus.index} lang_color_${dict.lang_code} Regular shadow table-active" border=0 cellpadding=0 cellspacing=0>
					<tr><td>
						<table class="table dicListTable table-light"><!-- table-bordered -->
						  <tbody>
						    <tr>
						    	<!-- UpDelForm 흔적남기기 -->
							    <input type="hidden" name="dict_no" value="${dict.dict_no}">
						        <input type="hidden" name="note_no" value="${dict.note_no}">
						        <input type="hidden" name="lang_code" value="${dict.lang_code}"> 
						        <th scope="row" style="text-align: center; width:10%;">단어</th>
						        <td class="table_word" style="text-align: center; width:20%;">${dict.word}</td>
						        <th scope="row" style="text-align: center;  width:10%;">언어</th>
						        <td class="table_lang" style="text-align: center;  width:15%;">
							      <c:choose>
										<c:when test="${dict.lang_code==1}">
											 한국어
										</c:when>
										<c:when test="${dict.lang_code==2}">
											 영어
										</c:when>
										<c:when test="${dict.lang_code==3}">
											 일본어
										</c:when>
										<c:otherwise>
											 중국어
										</c:otherwise> 
								 </c:choose>
						      </td>
						      <th scope="row" style="text-align: center;  width:10%;">작성자</th>
						      <td class="table_register" style="text-align: center;  width:20%;">${dict.register}</td>
						      <th scope="row" style="text-align: center;  width:10%;">등록일</th>
						      <td class="table_input_date" style="text-align: center;  width:15%;">${dict.input_date}</td>
						    </tr>
						    <tr>
						      <th scope="row" width="100" style="text-align: center; width:10%;">내용</th>
						      <td class="table_content" colspan="9">${dict.content}</td>
						    </tr>
						    <tr>
						      <th scope="row" width="100" style="text-align: center">참조</th>
						       <td colspan="6" class="table_refer" style="text-align: left;">${dict.refer}</td>
					      		<td colspan="1">
						      	<button class="btn_mynote btn-secondary btn-sm" onClick="insertMynote(${loopTagStatus.index});">MYNOTE 제거</button>
						      </td>	
						    </tr>
						  </tbody>
						</table>
				</table>
							<br><br>
				</c:forEach>
				
				<!-- 만약에 검색 후, 게시판 결과가 없을 경우 없다고 출력하기 -->				
				<c:if test="${(requestScope.mynote_cnt)==0}">
					<h4>"MyNote에 저장된 NOTE가 없습니다."</h4>
				</c:if>
			</div><!-- dictList 끝 -->	
		</div><!-- inner container 끝 -->
			
			
			
			
		<!-- ============================== -->
		<!-- post 방식으로 이동할 form 태그 --> 
		<!-- ============================== -->		

		<!-- 검색어 흔적을 보내기 위한 히든 Form -->
		<form name="dictList" method="post" action="${requestScope.croot}/dictList.do"> 
		    <input type="hidden" name="keyword" value="${param.keyword}">   
			<input type="hidden" name="lang_code" value="${param.lang_code}">
			<input type="hidden" name="selectPageNo" value="1">
			<input type="hidden" name="rowCntPerPage" value="${sessionScope.dictSearchDTO.rowCntPerPage}">
			<input type="hidden" class="search_keyword" name="search_keyword" value="전체선택">
			<input type="hidden" class="search_keyword" name="search_keyword" value="단어" >	
			<input type="hidden" class="search_keyword" name="search_keyword" value="작성자" >
			<input type="hidden" class="search_keyword" name="search_keyword" value="내용" >	
		</form> 

		<!-- [ 로그인 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="loginForm" method="post" action="${requestScope.croot}/loginForm.do"></form>

		<!-- [ 로그아웃 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="logout" method="post" action="${requestScope.croot}/logout.do"></form>

		<!-- [ 홈 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="frontPage" method="post" action="${requestScope.croot}/frontPage.do"></form>
	
		<!-- [ 회원가입 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="userRegForm" method="post" action="${requestScope.croot}/userRegForm.do"></form>
		
		<!-- [ 관리자페이지 ] 화면 이동하는 form 태그 선언하기 -->
	    <form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do"></form>   

		<!-- [ 나의 노트 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="myNoteForm" method="post" action="${requestScope.croot}/mynote.do"></form>
		
		<!-- [ 회원정보수정 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="userModifyForm" method="post" action="${requestScope.croot}/user_modify.do"></form>  
		
		<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do"></form>
		
		<!-- [ 노트 수정/삭제 ] 화면 이동하는 form 태그 선언하기 -->
		<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"></form>
		
	
	<div class="jumbotron" style="height: 400px; background-color: rgb(255, 255, 255);">
	</div>
	
	</div><!-- container 태그 끝 -->
	
	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    
		
	<%-- 
	<c:if test="${requestScope.dictListAllCnt_total==0||requestScope.tabDictListAllCnt_kor==0||requestScope.tabDictListAllCnt_eng==0||requestScope.tabDictListAllCnt_cn==0}">
		<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
	</c:if> --%>
		
		
		<!-- 비동기 방식으로 가져온 데이터 보기위해 여기에 소스삽입 코드 -->
		<!--  <textarea cols=100 rows=500 name=xxx></textarea> -->
</div>
</body>

</html>
<%-- //$(".listMenu").attr( { 'width':'200', 'bgcolor':'#CFE8EC', 'align':'center' });
<c:when test="${requestScope.tabDictListAllCnt_kor==0}">
						0
					</c:when>
					<c:when test="${requestScope.tabDictListAllCnt_eng==0}">
						0
					</c:when>
					<c:when test="${requestScope.tabDictListAllCnt_jpn==0}">
						0
					</c:when>
						<c:when test="${requestScope.tabDictListAllCnt_cn==0}">
						0
					</c:when> --%>

<%-- [검색어 총 개수]:
			<c:choose>
				<c:when test="${requestScope.dictListAllCnt_kor+requestScope.dictListAllCnt_eng+requestScope.dictListAllCnt_jpn+requestScope.dictListAllCnt_cn==0}">
					0
				</c:when>
				<c:otherwise>
					<span class="dictListAllCnt">${requestScope.dictListAllCnt_kor+requestScope.dictListAllCnt_eng+requestScope.dictListAllCnt_jpn+requestScope.dictListAllCnt_cn}</span>
				</c:otherwise>
			</c:choose> 
--%>
<%-- <c:choose>
					<c:when test="${requestScope.dictListAllCnt_total==0||requestScope.tabDictListAllCnt_kor==0||requestScope.tabDictListAllCnt_eng==0||requestScope.tabDictListAllCnt_cn==0}">
						<span>0</span>
					</c:when>
					<c:otherwise>
						<span>${requestScope.dictListAllCnt_total}</span>
						<span>${requestScope.tabDictListAllCnt_kor}</span>
						<span>${requestScope.tabDictListAllCnt_eng}</span>
						<span>${requestScope.tabDictListAllCnt_jpn}</span>
						<span>${requestScope.tabDictListAllCnt_cn}</span>
					</c:otherwise>
				</c:choose> --%>
<%-- <form name="dictList_kor" method="post" action="${requestScope.croot}/dictList_kor.do"> 
				<!-- <input type="text" name="keyword">  --> 
				<input type="hidden" name="keyword">    
				<input type="text" name="lang_code" value="1">
				<!-- <input type="hidden" name="lang_code" value="1"> -->
			</form>
			<form name="dictList_eng" method="post" action="${requestScope.croot}/dictList_eng.do"> 
				<!-- <input type="text" name="keyword"> -->
				<input type="hidden" name="keyword">
				 <input type="text" name="lang_code" value="2">
				<!-- <input type="hidden" name="lang_code" value="2"> -->      
			</form>
			<form name="dictList_jpn" method="post" action="${requestScope.croot}/dictList_jpn.do"> 
				<!-- <input type="text" name="keyword">  --> 
				<input type="hidden" name="keyword">   
				<input type="text" name="lang_code" value="3">
				<!-- <input type="hidden" name="lang_code" value="3"> --> 
			</form>
			<form name="dictList_cn" method="post" action="${requestScope.croot}/dictList_cn.do"> 
				<!-- <input type="text" name="keyword">  --> 
				<input type="hidden" name="keyword">     
				<input type="text" name="lang_code" value="4">
				<!-- <input type="hidden" name="lang_code" value="4"> --> 
			</form> --%>
<!-- 
		if($("[name=lang_code]").val()=="0"){
			
			$.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(){
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(){
						alert("서버 접속 실패");
					}
			});
		}else if($("[name=lang_code]").val()=="1"){
			
			$.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList_kor.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(){
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(){
						alert("서버 접속 실패");
					}
			});

		}else if($("[name=lang_code]").val()=="2"){
			
			$.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList_eng.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(){
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(){
						alert("서버 접속 실패");
					}
			});

		}else if($("[name=lang_code]").val()=="3"){
			
			$.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList_jpn.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(){
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(){
						alert("서버 접속 실패");
					}
			});

		}else if($("[name=lang_code]").val()=="4"){
			
			$.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList_cn.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(){
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(){
						alert("서버 접속 실패");
					}
			});

		}
	//****************************************
	// [각 언어별 키워드 검색] 함수 선언
	//******************
	function goTabDictList( str ){

		if(str=="total"){
			 
			 alert("통합탭으로 키워드 갖고 이동~!");
			 	// 유효성 검사
				 if( isEmpty($("[name=dictListForm] .keyword")) ){
						alert("검색 조건이 비어있어 검색할 수 없습니다.");
						$("[name=keyword]").val("");
						return;
					}
				
				// 키워드의 앞뒤 공백을 제거하기
				var keyword = $("[name=dictListForm] .keyword").val();
				keyword = keyword.trim();
				$("[name=dictList] [name=keyword]").val(keyword);
				alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
				
				document.dictList.submit( );
				
		}else if(str=="kor"){
				
				alert("한국어탭으로 키워드 갖고 이동~!");
			 	// 유효성 검사
				 if( isEmpty($("[name=dictListForm] .keyword")) ){
						alert("검색 조건이 비어있어 검색할 수 없습니다.");
						$("[name=keyword]").val("");
						return;
					}
				
				// 키워드의 앞뒤 공백을 제거하기
				var keyword = $("[name=dictListForm] .keyword").val();
				keyword = keyword.trim();
			 	$("[name=dictList_kor] [name=keyword]").val(keyword); 
				alert( "dictList 페이지에서 들어온 키워드=> "+ keyword ); 
				
				document.dictList_kor.submit( );
			
		}else if(str=="eng"){

				 alert("영어탭으로 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=dictListForm] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					 
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=dictListForm] .keyword").val();
					keyword = keyword.trim();
					$("[name=dictList_eng] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword ); 
					
					document.dictList_eng.submit( );

		}else if(str=="jpn"){
				
				 alert("일본어으로 탭 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=dictListForm] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=dictListForm] .keyword").val();
					keyword = keyword.trim();
					 $("[name=dictList_jpn] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
					
					document.dictList_jpn.submit( );

		}else if(str=="cn"){
	
				 alert("중국어으로 탭 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=dictListForm] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=dictListForm] .keyword").val();
					keyword = keyword.trim();
					$("[name=dictList_cn] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
					
					document.dictList_cn.submit( );

		}
		
	} -->
				<!-- 언어탭 선택 파트  -->
				<!-- <table class="dicListTable2 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('total');" ><b>통합검색</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('kor');" ><b>한국어</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('eng');"><b>영어</b></span>
						
						&nbsp;&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('jpn');"><b>일본어</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('cn');"><b>중국어</b></span>
						&nbsp;&nbsp;&nbsp;
				</table> -->

				<!-- ===== 각 언어별 검색 결과 가져오기 ====== -->
				 <%-- <!-- 한국어 -->
				<c:forEach items="${requestScope.tabDictList_kor}" var="dict" varStatus="loopTagStatus">
				<table class="dicListTable1 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
					<tr><td>
					<table class="dicListTable1" border=1 bordercolor="lightblue" cellpadding=10 cellspacing=0>
						<tr align=center>
							<th width=200>${dict.word}
							<td>작성자: <td width=90>${dict.register}
							<td>등록일: <td width=50>${dict.input_date}
							<td>조회수: <td width=50>${dict.readcount}
						<tr>		
							<td colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
						<tr>
							<td colspan=7>
							Comment<br>
							<textarea cols=80 rows=1 name="comment"></textarea>
							<input type="button" name="co_reg_btn" value="댓글달기">
						<c:if test="${requestScope.dictList.size()<(requestScope.dictList.size()-1)}"> 
							<tr>		
								<td align=center colspan=8>
								<span style="cursor:pointer" onClick="goSomeWhere();">다른 작성자 글 더보기 Click!</span>
						</c:if>
					</table>
				</table>
				<br><br>
				</c:forEach>
				<!-- 영어 -->
				<c:forEach items="${requestScope.tabDictList_eng}" var="dict" varStatus="loopTagStatus">
					<table class="dicListTable1 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
						<tr><td>
						<table class="dicListTable1" border=1 bordercolor="lightblue" cellpadding=10 cellspacing=0>
							<tr align=center>
								<th width=200>${dict.word}
								<td>작성자: <td width=90>${dict.register}
								<td>등록일: <td width=50>${dict.input_date}
								<td>조회수: <td width=50>${dict.readcount}
							<tr>		
								<td colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
							<tr>	
								<td colspan=7>
								Comment<br>
								<textarea cols=80 rows=1 name="comment"></textarea>
								<input type="button" name="co_reg_btn" value="댓글달기">
							<c:if test="${requestScope.tabDictList.size()<(requestScope.tabDictList.size()-1)}"> 
								<tr>		
									<td align=center colspan=8>
									<span style="cursor:pointer" onClick="goSomeWhere();">다른 작성자 글 더보기 Click!</span>
							</c:if>
						</table>
					</table>
					<br><br>
				</c:forEach>
				<!-- 일본어 -->
				<c:forEach items="${requestScope.tabDictList_jpn}" var="dict" varStatus="loopTagStatus">
					<table class="dicListTable1 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
						<tr><td>
						<table class="dicListTable1" border=1 bordercolor="lightblue" cellpadding=10 cellspacing=0>
							<tr align=center>
								<th width=200>${dict.word}
								<td>작성자: <td width=90>${dict.register}
								<td>등록일: <td width=50>${dict.input_date}
								<td>조회수: <td width=50>${dict.readcount}
							<tr>		
								<td colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
							<tr>	
								<td colspan=7>
								Comment<br>
								<textarea cols=80 rows=1 name="comment"></textarea>
								<input type="button" name="co_reg_btn" value="댓글달기">
							<c:if test="${requestScope.tabDictList.size()<(requestScope.tabDictList.size()-1)}"> 
								<tr>		
									<td align=center colspan=8>
									<span style="cursor:pointer" onClick="goSomeWhere();">다른 작성자 글 더보기 Click!</span>
							</c:if>
						</table>
					</table>
					<br><br>
				</c:forEach>
				<!-- 중국어 -->
				<c:forEach items="${requestScope.tabDictList_cn}" var="dict" varStatus="loopTagStatus">
					<table class="dicListTable1 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
						<tr><td>
						<table class="dicListTable1" border=1 bordercolor="lightblue" cellpadding=10 cellspacing=0>
							<tr align=center>
								<th width=200>${dict.word}
								<td>작성자: <td width=90>${dict.register}
								<td>등록일: <td width=50>${dict.input_date}
								<td>조회수: <td width=50>${dict.readcount}
							<tr>		
								<td colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
							<tr>	
								<td colspan=7>
								Comment<br>
								<textarea cols=80 rows=1 name="comment"></textarea>
								<input type="button" name="co_reg_btn" value="댓글달기">
							<c:if test="${requestScope.tabDictList.size()<(requestScope.tabDictList.size()-1)}"> 
								<tr>		
									<td align=center colspan=8>
									<span style="cursor:pointer" onClick="goSomeWhere();">다른 작성자 글 더보기 Click!</span>
							</c:if>
						</table>
					</table>
					<br><br>
				</c:forEach> --%>
<!-- 만약에 검색 후, 게시판 결과가 없을 경우 없다고 출력하기 -->				
<%-- <c:if test="${(requestScope.dictListAllCnt_kor+requestScope.dictListAllCnt_eng+requestScope.dictListAllCnt_jpn+requestScope.dictListAllCnt_cn)==0}">
			<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
		</c:if> --%>
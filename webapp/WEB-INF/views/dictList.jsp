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


<!-- Required meta tags -->
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  

<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> 

<head>

<title>게시판 목록</title>
<style> 
 .dicListTable {
	/* width:120; */
	
}
 .dicListTable2 {
	 background-color:lightblue; 
}
.bookmarks {
   position:fixed;
   right:30px;
   bottom:30px;
   width:100px;
   /* border:1px solid black; */ 
   z-index:1;
}
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

</style>		
	

	<script>
	$(document).ready(function(){

		// 텍스트 컬리지정
		//$(".txt01").css({'color':'#b4361f'});

		
		//enterkey 누르면 search()함수 작동
		$(".keyword").keypress(function(event){
			// enterkey는 13번이다.
			if ( event.which == 13 ) {
				$('.keywordSearch').click();
				return false;
			}
		});
		// 공용함수 enterKey로 검색하기
		//enterKey( $(".keyword"), $('.keywordSearch') );

	    $(".lang_color_1 th").css({'background-color': '#A4FFF9'});
		$(".lang_color_2 th").css({'background-color': 'lightgreen'});
		$(".lang_color_3 th").css({'background-color': 'lightpink'});
		$(".lang_color_4 th").css({'background-color': 'lightyellow'});

		$(".bookmark_1").css({'background-color': '#A4FFF9'});
		$(".bookmark_2").css({'background-color': 'lightgreen'});
		$(".bookmark_3").css({'background-color': 'lightpink'});
		$(".bookmark_4").css({'background-color': 'lightyellow'}); 

				
		
//=========================== 체크박스 선택 ================================================		
		 $(".searchAll_keywordCheck").change(function(){									
             if( $(".searchAll_keywordCheck").is(":checked")){                
            	 $(".search_keywordCheck").prop("checked",true);
			 }else{
            	 $(".search_keyword").prop("checked",true);
		     }			  
		 });

		 $(".search_keywordCheck").change(function(){			    
			 if( $(".search_keywordCheck").filter(":checked").length < $(".search_keywordCheck").length ){    					 
				 $(".searchAll_keywordCheck").prop("checked",false);
			 }	            
             else{
            	 $(".searchAll_keywordCheck").prop("checked",true);
			 }
		 });


		 $(".search_keywordCheck").change(function(){
             if( $(".search_keywordCheck").filter(":checked").length==0){
            	 $(".search_keyword").prop("checked",true);
                 }

	      })		
		//========================================
		// [ 읽기권한 여부 체크 ] 	
		//----------------------------------------
		 <c:if test="${sessionScope.acc_read eq'0' && not empty sessionScope.user_id && sessionScope.admin_id==null }">
			 alert("접속이 제한되어 있습니다.");
		    //document.frontPage.submit();
		    location.replace("${requestScope.croot}/frontPage.do");		 	        
		  </c:if>

		    
		
		//---------------------------------------------------------------------
		// 페이징 처리 코드 파트 
		//--------------------------------------
		/*	
		     alert( "페이징!" 
					+"requestScope.dictListAllCnt_total=>${requestScope.dictListAllCnt_total}"     // 검색 결과 총 행 개수
					+"\n requestScope.selectPageNo=>${requestScope.dictSearchDTO.selectPageNo}"   // 선택된 현재 페이지 번호
					+"\n requestScope.rowCntPerPage=>${requestScope.dictSearchDTO.rowCntPerPage}" // 페이지 당 출력행의 개수
			)  
         */			
			// 페이징 처리 관련 HTML 소스를 class=pagingNumber 가진 태그 안에 삽입하기
			 $(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.dictListAllCnt_total}"          // 검색 결과 총 행 개수
						,"${sessionScope.dictSearchDTO.selectPageNo}"   // 선택된 현재 페이지 번호
						,"${sessionScope.dictSearchDTO.rowCntPerPage}"  // 페이지 당 출력행의 개수
						,"5"                                            // 페이지 당 보여줄 페이지번호 개수
						,"search_when_pageNoClick();"                   // 페이지 번호 클릭 후 실행할 자스코드
					)
			);

				$(".orderby, .asc_desc").change(function(){
				   var orderby  = $(".orderby").val();
				   var asc_desc = $(".asc_desc").val();				
					if(  (orderby=="") &&   (asc_desc!="") ){                 				    
						$(".orderby").val("input_date")	
											 
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
			    	  document.dicList.submit(); 
			    	  
			      });
      		//=======================================================================================
			      $(".begin_year, .begin_month , .end_year, .end_month, .search_date, .range").change(function(){
                     var begin_year  = $(".begin_year").val();
                     var begin_month = $(".begin_month").val();
                     var end_year    = $(".end_year").val();
                     var end_month   = $(".end_month").val();
                     var search_date = $(".search_date").val();
                     var range       = $(".range").val(); 
                     
                     if(begin_year!="" || begin_month!="" || end_year!="" || end_month!=""){
                     	  $(".search_date").val("");
                        	  $(".range").val("당일");
                     }
                     
	                    if(search_date!="" || range!="당일" ){
                     	  $(".begin_year").val("");
                           $(".begin_month").val("");
                           $(".end_year").val("");
                           $(".end_month").val("");                     	
                     }	                        							
			      });

			 //=============================
			 // 날짜 상세 검색 
			 //=================
			 // 시작시간
			 insertYMD_to_select2(
						$(".begin_year")             		  // 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".begin_month")           		  // 월 관련 select 태그를 관리하는 JQuery 객체					
						, 1950                                // 최소년도
						, new Date().getFullYear()            // 최대년도
						, 2                                   // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
			 ); 
			 // 종료 시간 
			 insertYMD_to_select2( 
						$(".end_year")             			// 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".end_month")           		// 월 관련 select 태그를 관리하는 JQuery 객체					
						, 1950                              // 최소년도
						, new Date().getFullYear()          // 최대년도
						, 2                                 // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
			 );

										
//============================= [ 날짜 상세 검색  유효성 체크 ] =======================================================				

           $(".begin_year, .begin_month, .end_year, .end_month").change(function(){				 
			// checkYearMonthRange( $(".begin_year"), $(".begin_month"), $(".end_year"), $(".end_month"), "생년월일");							  				  
			    var begin_year = $(".begin_year").val();
				var begin_month = $(".begin_month").val();
				var end_year = $(".end_year").val();
				var end_month = $(".end_month").val();
				
				 //---------------------------------------------------------------------
				// 만약에  최소년도가 없고, 최소 월이 없으면 최소 월이 있을경우에 경고
				//---------------------------------------------------------------------
				if(  (begin_year=="") &&   (begin_month!="") ){                 				    
				    $(".begin_year").val("1000");
						
				}	
			    //---------------------------------------------------------------------
				// 만약에  최소년도가 있고, 최소 월이 없으면 최소 월에 1 넣어주기
				//---------------------------------------------------------------------
				if(  (begin_year!="") &&   (begin_month=="") ){                 
					$(".begin_month").val("01");				
				}
				//---------------------------------------------------------------------
				// 만약에  최대 년도가 있고, 최소년도는 없고 최대 월이 없으면  최소월에 01 넣어주기  최대 월에 12 넣어주기
				//---------------------------------------------------------------------
				if(end_year!="" && begin_year=="" && end_month==""){
					$(".begin_year").val("1000");
					$(".begin_month").val("01");
					$(".end_month").val("12");							
				}
					
				//---------------------------------------------------------------------
				// 만약에  최소 년도 있고, 최소 월도 있고, 최대 년도는 없고, 최대 월이 있으면
				//---------------------------------------------------------------------
				if(begin_year!=""  &&   begin_month!=""  && end_year=="" && end_month!=""){
	
					$(".end_year").val("3000");
				
				}
				//---------------------------------------------------------------------
				// 만약에   최소 년도 , 최소 월, 최대 년도가 없고, 최대 월이 있으면
				//---------------------------------------------------------------------
				if( begin_year==""  &&   begin_month==""   && end_year=="" && end_month!=""){
					$(".begin_year").val("1000");
					$(".begin_month").val("01");
				    $(".end_year").val("3000");

					}
								    
				//---------------------------------------------------------------------
				// 만약에  최대년도, 최대월, 최소년도, 최소월이 모두 있으면
				//---------------------------------------------------------------------
			if( begin_year!="" && begin_month!="" && end_year!="" && end_month!="" ){
			    if( (begin_year>end_year) ||(begin_year==end_year && parseInt(begin_month,10)>parseInt(end_month,10)     )    ){
					alert("가입일 최소값이 가입일 최대값이 보다 큽니다.");
					$(".begin_year").val(end_year);
					$(".begin_month").val("01");
					$(".end_year").val(begin_year);
					$(".end_month").val("12");							
				}
					return;	
			    }
		 });
				 
			//---------------------------------------------------------------------
			// 상세검색 파트
			//-------------------------------------
			// 게시판 목록을 보여주는 table 의 헤더행, 짝수행, 홀수행, 마우스온 일때 배경색 설정하기
			 setTableTrBgColor(
						"dictTable"		//	테이블 class 값
						, "lightpink"		//	헤더 tr 배경색
						, "white"			//	헤더행을 제외한 홀수행 배경색
						, "lightgray"		//	짝수행 배경색
						, "lightblue"		//	마우스온 일때 배경색
					);
			 
			// [ 검색 흔적 남기기] -----------------------------------------
				
	            inputData(".keyword" , "${sessionScope.dictSearchDTO.keyword}");
	            inputData(".lang_code" , "${sessionScope.dictSearchDTO.lang_code}");
	           
				<c:forEach items="${sessionScope.dictSearchDTO.search_keyword}" var="search_keyword">  
		          inputData("[name=dictListForm] [name=search_keyword]", "${search_keyword}");                                                                                 				         
		        </c:forEach>
		        inputData(".detail_search" , "${sessionScope.dictSearchDTO.detail_search}");
	            inputData(".detail_keyword" , "${sessionScope.dictSearchDTO.detail_keyword}");
				inputData(".search_date" , "${sessionScope.dictSearchDTO.search_date}");
			    inputData(".range"       , "${sessionScope.dictSearchDTO.range}");
			    inputData(".begin_year"  , "${sessionScope.dictSearchDTO.begin_year}");
			    inputData(".begin_month" , "${sessionScope.dictSearchDTO.begin_month}");
			    inputData(".end_year"    , "${sessionScope.dictSearchDTO.end_year}");
			    inputData(".end_month"   , "${sessionScope.dictSearchDTO.end_month}");
			    inputData(".orderby"     , "${sessionScope.dictSearchDTO.orderby}");
			    inputData(".asc_desc"    , "${sessionScope.dictSearchDTO.asc_desc}");
			    inputData(".top"    , "${sessionScope.dictSearchDTO.top}");
			    inputData(".selectPageNo"  , "${sessionScope.dictSearchDTO.selectPageNo}");
			    inputData(".rowCntPerPage" , "${sessionScope.dictSearchDTO.rowCntPerPage}");
			 	// [ 체크박스 검색 흔적 남기기] ----------------------------------	
				

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

		     
		    // [ 기간 선택 , 직접 선택 시 보이기 여부] --------------------------	
			/* $(".search_table1 th").hover(function(){
				
				$(".search_table2 td").hide();
				$(".search_table1 td").show();
				
				$(".search_table2 td").find(":input").not(":button , :reset").each(function(){
					var obj = $(this);
					$(obj).val("");
				});
			});
	
			$(".search_table2 th").hover(function(){
				$(".search_table1 td").find(":checkbox").prop("checked",false);
				//$(".search_table1 td :checkbox").prop("checked",false);
				//$("[name=ext_search]").prop("checked",false);
				$(".search_table1 td").hide();
				$(".search_table2 td").show();
				
			}); */
//==================================================        [ 날짜 유효 체크   ]       ==================================================================				
				   $(".search_date, .range").change(function(){	 
					   var date  = $(".search_date").val();
					   var range = $(".range").val();
					   
						if(range=="이전" || range=="이후"){
							$(".search_date").val("오늘");
						}
			   }); 

//--------------------------------------------------
});  //  $(document).ready(function(){           
//--------------------------------------------------	
	//****************************************
	// 상세검색 적용함수
	//******************
/*	
	function goApply_button(){
		var inputCnt = 0;
		//alert( $("[name=dictListForm]").find(":input").filter("select").length );
		$("[name=dictListForm]").find(":input").filter("select").not(":button, [name=detail_search]").each(function(){

			var obj = $(this);
			
			if( obj.is(":checkbox") || obj.is(":radio") ){
				if( obj.filter(":checked").length>0){ inputCnt++; }
			}else{
				if( isEmpty(obj)==false ){inputCnt++;}
			}
		});
		if ( inputCnt<1 ) {
			if(  isEmpty(  $("[name=keyword]") ) ){
				alert("검색조건을 입력해 주십시오");
					document.dictListForm.reset(); 
					return;
			}
		}
		//alert(inputCnt);
		document.dictListForm.submit();  
							
	}
	*/
		
	//****************************************
	// 상세검색 비움 버튼 함수
	//******************
	function emptyData(selector){
		if(selector=='reset_day'){
			$("[name=begin_year]").val("");
			$("[name=begin_month]").val("");
			$("[name=end_year]").val("");
			$("[name=end_month]").val("");
	    }
		else if(selector=='reset_ascDesc'){
			$("[name=orderby]").val("");
			$("[name=asc_desc]").val("");		
	    }
	    else if(selector=='reset_date'){
	    	$("[name=search_date]").val("");
	    	$("[name=range]").val("당일");
	    }
	    else if(selector=='reset_detail'){
	    	$("[name=detail_search]").val("");
	    	$("[name=detail_keyword]").val("");
	    }
	    else if(selector=='top'){
	    	$("[name=top]").val("top_rate_cnt");
	    }
	}

	//****************************************
	// 모두 초기화 버튼 함수
	//******************
	function resetAll(){
		$("[name='dictListForm'] [name=keyword]").val("");
	    $("[name='dictListForm'] [name=selectPageNo]").val("1");	    
	    //$("[name='dictListForm'] [name=search_keyword]").prop("checked",false);
        
        $(".search_keywordCheck1").prop('checked', true);
        $(".search_keywordCheck2").prop('checked', false);
 
	    $("[name='dictListForm'] [name=lang_code]").val("0");
		$("[name='dictListForm'] [name=detail_search]").val("");
		$("[name='dictListForm'] [name=detail_keyword]").val("");
		$("[name='dictListForm'] [name=search_date]").val("");
		$("[name='dictListForm'] [name=range]").val("당일");
		$("[name='dictListForm'] [name=begin_year]").val("");
		$("[name='dictListForm'] [name=begin_month]").val("");
		$("[name='dictListForm'] [name=end_year]").val("");
		$("[name='dictListForm'] [name=end_month]").val("");
		$("[name='dictListForm'] [name=orderby]").val("");
		$("[name='dictListForm'] [name=asc_desc]").val("");
		$("[name='dictListForm'] [name=top]").val("top_rate_cnt");
		$(".arrow").text("기준");
	}
	
	//****************************************
	// [키워드 검색] 함수 선언
	//******************
	function search(  ){
 
			//alert("검색시작!");
			//---------------------------------------
			// 만약 키워드가 비어있거나 공백으로 구성되어 있으면, ""로 세팅하기
			// <주의> 공백이면 공백으로 DB연동하므로 공백으로만 되어 있으면 ""로 세팅한다.
			//---------------------
			var cnt = 0;
			if( isEmpty($("[name=dictListForm] [name=keyword]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=detail_search]"))==false ){cnt++}			
			if( isEmpty($("[name=dictListForm] [name=detail_keyword]"))==false ){cnt++}
			//if(isEmpty($("[name=search_keyword]")) == false){cnt++}
			if( isEmpty($("[name=dictListForm] [name=search_date]"))==false ){cnt++}
			//if( isEmpty($("[name=range]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=begin_year]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=begin_month]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=end_year]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=end_month]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=orderby]"))==false ){cnt++}
			if( isEmpty($("[name=dictListForm] [name=asc_desc]"))==false ){cnt++}
			//if( isEmpty($("[name=dictListForm] [name=top]"))==false ){cnt++}
			if(cnt == 0){
				alert("검색 조건이 비어 있어 검색할 수 없습니다.")
		
				return;
	    	}
	   /* 	
	        var  obj = $(".detail_search_table2");       
	    	var  objVal = obj.find('.detail').val();
			if( isEmpty($("[name=dictListForm] [name=keyword]"))==true  && objVal!=null || objVal.split(" ").join("")!="" ){
    
                      alert("메인 검색부터 입력해주세요.!");

                  
                    $("[name=dictListForm] [name=keyword]").focus();                           
                  return;
				}
  */
			
			if( isEmpty($("[name=dictListForm] [name=detail_search]"))==true && isEmpty($("[name=dictListForm] [name=detail_keyword]"))==false ){
	              alert("선택 먼저 해주세요.")
				  $("[name=keyword]").val("");
				  $("[name=detail_keyword]").val("");
	             return;
			}
	       
			//var lang_code = $("[name=dictListForm] [name=lang_code]").val();
			//alert(lang_code);
			//$("[name=dictList] [name=lang_code]").val(lang_code);
			//$("[name=dictContentForm] [name=lang_code]").val(lang_code);
		
			var keyword = $("[name=dictListForm] [name=keyword]").val();
			keyword = $.trim(keyword);
			//alert(keyword);
			$("[name=dictListForm] [name=keyword]").val(keyword);
			$("[name=dictContentForm] [name=keyword]").val(keyword);
			
			var lang_code = "${sessionScope.dictSearchDTO.lang_code}";
			$("[name=dictListForm] [name=lang_code]").val(lang_code);
			$("[name=dictContentForm] [name=lang_code]").val(lang_code);

		   document.dictListForm.submit();

		   return;
			/* 
			alert($("[name=dictListForm]").serialize());
			 $.ajax({
					// 서버쪽 호출 URL 주소 지정
					url : "${requestScope.croot}/dictList.do"
					, type : "post"
					, data : $("[name=dictListForm]").serialize()	
					, success : function(html){
						//$("[name=xxx]").text(html);
						//alert(html);
						//alert( $(html).find(".paging").text() );
						
						$(".dictList").html($(html).find(".dictList").html());
						//$(".all").html($(html).find(".all").html());
						$(".cnt").html($(html).find(".cnt").html());
						
						//document.dictListForm.submit();
					}
					//,async: false
					, error : function(request,status,error){
						alert("서버 접속 실패");
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
			});  */

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
			var ex_keyword = $("[name=dictListForm] [name=ex_keyword]").val();
			if( keyword!=null && keyword.split(" ").join("")!="" ){
				//keyword = $.trim(keyword);
				keyword = keyword.trim();
				$("[name=dictListForm] [name=keyword]").val(keyword);
			}
			//alert(keyword);
			//alert( $("[name=dictListForm]").serialize() );
			
			search();
			
	} 
	
	//****************************************
	// [ContentForm 화면으로 이동] 함수 선언
	//****************** ★★★★★★ 여기 꼭 갱신해 주세요!	
	function seeMore( str ){
		
			//alert("contentForm으로 이동");
			
			var obj = $(".dictListTable_" + str );
			var lang_code = obj.find("[name='lang_code']").val();
			//alert(lang_code);
			var keyword = obj.find(".table_word").text();
			keyword = $.trim(keyword);	
			//alert(keyword);	
			$("[name=dictListForm] [name=keyword]").val(keyword);
			$("[name=dictListForm] [name=lang_code]").val(lang_code);

		/* 	var lang_code = "${sessionScope.dictSearchDTO.lang_code}";
			alert(lang_code);
			$("[name=dictListForm] [name=lang_code]").val(lang_code); */
          // if(keyword.split(" ").join("")!="" && keyword!=null){
			//$("[name='ex_keyword']").val("${sessionScope.keyword}");	
           //  }
           //else{  	 $("[name='keyword']").val( $("[name='ex_keyword']").val());     }
                   
			
			 //alert(keyword);

			//$("[name=dictContentForm] [name=lang_code]").val(lang_code);
			//$(".selectPageNo").val(      parseInt( $(".selectPageNo").val(), 10 )         );            
	        //$(".rowCntPerPage").val(   parseInt( $(".rowCntPerPage").val(), 10 )            );
			 $(".search_keywordCheck").prop("checked",false);
			 $(".searchAll_keywordCheck").prop("checked",false);
			 $(".search_keywordCheck").first().prop("checked",true);
			 $(".selectPageNo").val("1");

			 
			 document.dictListForm.action="${requestScope.croot}/dictContentForm.do";
			 
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
	//===============================
    // 관리자 게시판 가는  함수 선언
    //===============================
	  function goUserRegForm(){
			document.adminForm.submit();
		}
	//==================================
    // [ 홈 ] 이동하는 함수 선언
    //==================================
	function goFrontPage(){
		document.frontPage.submit();
	}
	//==================================
    // [ 새글쓰기 ]  이동하는 함수 선언
    //==================================
	function goDictRegForm(){

		document.dictRegForm.submit();
	}	
	//==================================
    // [ 회원정보수정 ]  이동하는 함수 선언
    //==================================
	function goUserModify(){
		document.userModifyForm.submit();
	}
	//==================================
    // [ 나의노트 ]  이동하는 함수 선언
    //==================================
	function goMyNote(){
		document.myNoteForm.submit();
	}
	//==================================
    // [ 수정삭제 ]  이동하는 함수 선언
    //==================================
	function goDictUpDelForm(str){
		
	   <c:forEach items="${sessionScope.dictSearchDTO.search_keyword}" var="search_keyword">  
         inputData("[name=dictUpDelForm] [name=search_keyword]", "${search_keyword}");   
       </c:forEach>
		var obj = $(".dictListTable_" + str );

		var dict_no = obj.find("[name='dict_no']").val();
		//alert(dict_no);	
     
		var note_no = obj.find("[name=note_no]").val();
		//alert("note_no=> "+note_no);
			
		var lang_code = obj.find("[name=lang_code]").val();
		//alert(lang_code);
			
		var word = obj.find(".table_word").text();
		word = $.trim(word);
		//alert(word);
		
		
		var content = obj.find(".table_content").text();


		content = $.trim(content);
		//alert(content);
		var register = obj.find(".table_register").text();
		//alert(register);
		register = $.trim(register);
		
		var refer = obj.find(".table_refer").text();
		//alert(refer);
		refer = $.trim(refer);
		
		$("[name=dictUpDelForm] [name=dict_no]").val(dict_no);
		$("[name=dictUpDelForm] [name=lang_code]").val(lang_code);
		$("[name=dictUpDelForm] [name=note_no]").val(note_no);
		$("[name=dictUpDelForm] [name=word]").val(word);
		$("[name=dictUpDelForm] [name=content]").val(content);
		$("[name=dictUpDelForm] [name=refer]").val(refer);
		$("[name=dictUpDelForm] [name=register]").val(register);
		
		
		//alert( $("[name='dictUpDelForm']").serialize() );
		
		document.dictUpDelForm.action="${requestScope.croot}/dictUpDelForm.do";
		document.dictUpDelForm.submit();
	}

	//****************************************
	// 추천 관련 함수 선언 파트
	//****************************************
	function recommend(str){
		var tableObj = $(".dictList").find(".dictListTable_"+str);
		var d_no = tableObj.find("[name=dict_no]").val();
		var lang_code = tableObj.find("[name=lang_code]").val();
		var user_id = $(".user_id").val();
		//alert(d_no);
		//alert(lang_code);
		//alert(user_id);
		$("[name=recommendForm] [name=d_no]").val(d_no);
		$("[name=recommendForm] [name=lang_code]").val(lang_code);
		//alert( $("[name=recommendForm]").serialize() );
		
		$.ajax({
			url : "${requestScope.croot}/recommend.do"
			, type : "post"
			, data : $("[name=recommendForm]").serialize()
			, success : function( cnt ){
				if(cnt==1){//<th class="card-header" name="rate_cnt_${loopTagStatus.index}">
					var number = $(".rate_cnt_"+str).text();
					number = parseInt(number,10) + 1;
					$(".rate_cnt_"+str).text(number);
				}
				else if(cnt==0){alert("추천수 업데이트 실패");}
				else if(cnt==-1){alert("추천하기는 한 번만 가능");}
				else{alert("추천하기 실패!");}
			}
			, error : function(){
				alert("서버 접속 실패");
				}
			});
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

								if(turnOffcnt==2){alert("MYNOTE가 해제되었습니다.");}
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
	  background-image: url("${pageContext.request.contextPath}/resources/img/background_01.png");
	  background-size: cover;
	  background-position: center;
	  background-repeat: no-repeat;
 }
 .table1 {
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
	                  <!-- <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a> -->
				     
				<c:if test="${sessionScope.acc_write eq '0' && not empty sessionScope.user_id && sessionScope.admin_id==null}">
			   		   
			    </c:if>
			    <c:if test="${sessionScope.acc_write eq '1' && not empty sessionScope.user_id && sessionScope.admin_id==null}">	
			            <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
			    </c:if>			
				  <c:if test="${sessionScope.admin_id!=null}">	
			            <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
			    </c:if>	    
				     
			     
			     
			     
			     
				      <a class="dropdown-item" href="javascript:goMyNote();">나의 노트</a>
					 <!--  <a class="dropdown-item" href="javascript:goDictUpDelForm();">글 수정/삭제</a> -->
	               <div class="dropdown-divider"></div>
					  <a class="dropdown-item" href="javascript:goUserModify();">회원정보수정</a>			
	                 <!--  <a class="dropdown-item" href="javascript:goUserRegForm();">회원가입</a> -->
					  <!-- <a class="dropdown-item" href="javascript:goLogout();">로그아웃</a>  -->			
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
	 
	<!--  누구로 접속 했는지 확인 하는  히든 태그 선언 -->
	<input type="hidden" name="admin_id" class="admin_id"  value="${sessionScope.admin_id}"/>
	<input type="hidden" name="user_id" class="user_id" value="${sessionScope.user_id}"/>
	<input type="hidden" name="user_name" class="user_name" value="${sessionScope.user_name}"/>
	<input type="hidden" name="acc_read" class="acc_read" value="${sessionScope.acc_read}"/>
	<input type="hidden" name="acc_upDel" class="acc_upDel" value="${sessionScope.acc_upDel}"/>
	<input type="hidden" name="acc_write" class="acc_write" value="${sessionScope.acc_write}"/>
	<input type="hidden" name="keyword" class="keyword" value="${param.keyword}"/> 
	<input type="hidden" name="lang_code" class="lang_code" value="${param.lang_code}"/>  
	
	<!-- 메인화면 -->
	<div class="all container-fluid" name="dictListDiv">
	<div class="all container">	
	<form name="dictListForm" method="post" action="${requestScope.croot}/dictList.do">
		<div class="row">
			<div class="col">
			</div>
			<div class="col-6">
				<br><br>
				<!--  검색키워드  -->
				<div class="input-group is-invalid">
					<input type="text" name="keyword" value="${param.keyword}" class="keyword form-control"  placeholder="검색어를 넣어주세요" size="50">
					<input type="hidden" name="ex_keyword" value="${param.keyword}" class="ex_keyword"  placeholder="List에서 온 애" size="50">
					<button type="button" class="keywordSearch btn btn-dark" onClick="search();">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
 						<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
					</svg></button>
				     &nbsp;
				    <button type="button" class="resetAll btn btn-secondary" onclick="resetAll();">초기화</button>
					<input type="hidden" class="lang_code" name="lang_code">
				</div>
			</div>
			<div class="col">
			</div>
		</div>
		<br><br><br><br>
			<!-- 언어탭 선택 파트  -->		
			<div class="btn-group float-left" role="group" aria-label="Basic example">
			  <button type="button" class="btn btn-secondary btn0" onClick="goTabDictList('0');"><strong>통합검색</strong></button>
			  <button type="button" class="btn btn-secondary btn1" onClick="goTabDictList('1');"><strong>한국어</strong></button>
			  <button type="button" class="btn btn-secondary btn2" onClick="goTabDictList('2');"><strong>영어</strong></button>
			  <button type="button" class="btn btn-secondary btn3" onClick="goTabDictList('3');"><strong>일본어</strong></button>
			  <button type="button" class="btn btn-secondary btn4" onClick="goTabDictList('4');"><strong>중국어</strong></button>
			</div>
			<div class="jumbotron" style="height: 450px;">
					<div class="cnt txt01" style="text-align: left">
						<b>[총 검색어 개수]:
						<c:choose>
							<c:when test="${requestScope.dictListAllCnt_total==0}">
								<span>0</span>
							</c:when>
							<c:otherwise>
								<span>${requestScope.dictListAllCnt_total}</span>
							</c:otherwise>
						</c:choose>
						</b>
					</div>
					<!-- 상세검색 -->
					<table class="table">
						  <tbody>
						  		<!-- <tr>
						  		<th colspan="3">
						  		</th>
						  		</tr> -->
							    <tr>
							      <th scope="row">확장검색</th>
							      <td>
								      <div>
					                    <input type="checkbox" class="search_keyword searchAll_keywordCheck search_keywordCheck2" name="search_keyword" value="전체선택">&nbsp;<b>전체선택</b>
										&nbsp;						
										<input type="checkbox" class="search_keyword search_keywordCheck search_keywordCheck1" name="search_keyword" value="단어">&nbsp;단어
								        &nbsp;
								        <input type="checkbox" class="search_keyword search_keywordCheck search_keywordCheck2" name="search_keyword" value="작성자">&nbsp;작성자
								        &nbsp;                						    
										<input type="checkbox" class="search_keyword search_keywordCheck search_keywordCheck2" name="search_keyword"  value="내용">&nbsp;내용
								      </div>
							      </td>
							    </tr>
							    <tr>
							      <th scope="row">세부검색</th>
							      <td>
							      	 <div class="input-group is-invalid">
										<div class="form-group my-1" style="text-align: center;">
											<select name="detail_search" class="detail_search detail form-control-sm">    
										         <option value="">선택</option>
										         <option value="단어">단어</option>						       							       
												 <option value="작성자">작성자</option>
												 <option value="내용">내용</option>         
											</select>
											<input type="text" name="detail_keyword" value="" class="detail_keyword form-control-sm"  placeholder="세부 검색어를 넣어주세요" size="30">							
										     &nbsp;&nbsp;
										    <span style="cursor: pointer" onClick="emptyData('reset_detail')">[비움]</span><br>
									    </div>
									</div>
							      </td>
							    </tr>
							    <tr>
							      <th scope="row">기간검색</th>
							      <td>
							        <div>								
										<select name="search_date" class ="search_date detail form-control-sm">
											<option value="">전체날짜</option>
											<option value="오늘">오늘</option>
											<option value="어제">어제</option>
											<option value="7일전">7일전</option>
											<option value="15일전">15일전</option>
										</select>
										<select class="range detail form-control-sm" name="range">				 					
										    <option value="당일">당일</option>
										    <option value="이전">이전</option>
										    <option value="이후">이후</option>			
										</select>&nbsp;&nbsp;
										<span style="cursor: pointer" onClick="emptyData('reset_date')">[비움]</span>
										<br>
										<small class="detxt">※기간을 선택 하시면 날짜검색은 초기화 됩니다.</small>
								    </div>
							      </td>
							    </tr>
							    <tr class="allDay">
							      <th scope="row">날짜검색</th>
							      <td>
							      	<div>
							      		<select name="begin_year" class="begin_year detail form-control-sm" align=center> 
							                  <option value="">선택</option>
							                  <option value="1000">최소 년도</option>
							            </select>  년
							            <select name="begin_month" class="begin_month detail form-control-sm" align=center>
							                  <option value="">선택</option>
							            </select>  월
							               ~
							            <select name="end_year" class="end_year detail form-control-sm" align=center> 
							                <option value="">선택</option>
							                <option value="3000">최대 년도</option>
							            </select>  년
							            <select name="end_month" class="end_month detail form-control-sm" align=center>
							                 <option value="">선택</option>
							            </select>  월
							            &nbsp;&nbsp;
							            <span style="cursor: pointer" onClick="emptyData('reset_day')">[비움]</span>
							            <br>
							         	<small class="detxt">※날짜 선택을 하시면 기간선택이 초기화 됩니다.</small> 
							      	</div>
							      </td>
							    </tr>
							    <tr>
							      <th scope="row">정렬기준</th>
							      <td>
							        <div>		  	
										<select name="orderby" class ="orderby detail form-control-sm">
											<option value="">선택</option>
											<option value="input_date">등록일순</option>
											<option value="rate_cnt">추천수순</option>
											<option value="word">가나다순</option>
											<option value="cnt">꼬리글순</option>										
										</select>&nbsp;&nbsp;
										<span class="arrow" style="cursor:pointer"><b>기준</b></span>&nbsp;</th>
										<select name="asc_desc" class ="asc_desc detail form-control-sm">
										    <option value="">선택</option>
											<option value="desc">내림차순</option>
											<option value="asc">오름차순</option>																
										</select>&nbsp;&nbsp;&nbsp;	
										 <span style="cursor: pointer" onClick="emptyData('reset_ascDesc')">[비움]</span>
											  	
										&nbsp;&nbsp;&nbsp;	<b>대표글 기준설정</b>
										<select name="top" class ="top detail form-control-sm">
											<option value="top_rate_cnt">추천수</option>
											<option value="top_input_date">최신글</option>
										</select>&nbsp;&nbsp;
										<span style="cursor: pointer" onClick="emptyData('top')">[비움]</span>
									</div>
							      </td>
							    </tr>
						  </tbody>
					</table>
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
					<div style="height: 10px;"></div>
			
		<div class="dictList">
				<!-- 통합검색 -->
				<c:forEach items="${requestScope.dictList_total}" var="dict" varStatus="loopTagStatus" >
				<table class="table dictListTable_${loopTagStatus.index} lang_color_${dict.lang_code} Regular shadow table-active" border=0 cellpadding=0 cellspacing=0>
					<tr><td>
						<table class="table dicListTable table-light"><!-- table-bordered -->
						  <tbody>
						    <tr>
						    	<!-- UpDelForm 흔적남기기 -->
							    <input type="hidden" name="dict_no" value="${dict.dict_no}">
						        <input type="hidden" name="note_no" value="${dict.note_no}">
						        <input type="hidden" name="lang_code" value="${dict.lang_code}"> 
						      <th scope="row" style="text-align: center; width:8%;">단어</th>
						      <td class="table_word" style="text-align: center; width:10%;">${dict.word}</td>
						      <th scope="row" style="text-align: center; width:8%;">언어</th>
						      <td class="table_lang" style="text-align: center; width:8%;">
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
						      <th scope="row" style="text-align: center; width:8%;">작성자</th>
						      <td class="table_register" style="text-align: center;  width:10%;">${dict.register}</td>
						      <th scope="row" style="text-align: center; width:8%;">등록일</th>
						      <td class="table_input_date" style="text-align: center; width:10%;">${dict.input_date}</td>
						      <th scope="row" style="text-align: center; width:8%;">추천수</th>
						      <td class="rate_cnt_${loopTagStatus.index}" style="text-align: center; width:15%;">${dict.rate_cnt}&nbsp;&nbsp;
						      	<button type="button" class="btn_R btn btn-outline-primary btn-sm" onClick="recommend(${loopTagStatus.index});">추천하기</button>
						      	<%-- <span class="btn_R" style="cursor:pointer" onClick="recommend(${loopTagStatus.index});">추천하기</span> --%>
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" style="text-align: center">내용</th>
						      <td class="table_content" colspan="9">${dict.content}</td>
						    </tr>
						    <tr>
						      <th scope="row" style="text-align: center">참조</th>
						      <td colspan="7" class="table_refer" style="text-align: left;">
						      	<c:choose>
						      		<c:when test='${dict.refer==""}'><!-- 조건 나중에 확인해볼것..! -->
						      			없음
						      		</c:when>
						      		<c:otherwise>
						      			${dict.refer}
						      		</c:otherwise>
						      	</c:choose>
						      </td>	
						      <td colspan="2">
							      	<div class="input-group is-invalid" align="left">
										<!--  수정/삭제 권한 1이고 유저아이디는 비어있지 않고 관리자아이디가 null이면  수정/삭제 버튼이 보인다.-->
									    <c:if test="${sessionScope.acc_upDel eq '1' && not empty sessionScope.user_id && sessionScope.admin_id==null}">
									   		<button type="button" class="btn_R btn btn-secondary btn-sm" onClick="goDictUpDelForm(${loopTagStatus.index});">수정/삭제</button>
											<%-- <input type="button" value="수정/삭제"  onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp; --%>
									    </c:if>
									    <c:if test="${ sessionScope.admin_id!=null}">	
									    	<button type="button" class="btn_R btn btn-secondary btn-sm" onClick="goDictUpDelForm(${loopTagStatus.index});">수정/삭제</button>
											<%-- <input type="button" value="수정/삭제" onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp; --%>
									    </c:if>			
									    &nbsp; 
									   <button class="btn_mynote btn-secondary btn-sm" onClick="insertMynote(${loopTagStatus.index});">MYNOTE 추가</button>
									</div>
						      </td>
						    </tr>
						    <tr class="table-secondary">
						    	<td  align=center colspan="10">
									<c:if test="${dict.cnt>1}">
										<span class="btn" style="cursor:pointer" onClick="seeMore(${loopTagStatus.index});">다른 작성자 글 (${dict.cnt-1} 개) 더보기 Click!</span> 
									</c:if>
									<c:if test="${dict.cnt<=1}">
										<span class="btn" style="cursor:no-drop">다른 작성자의 글이 없습니다.</span> 
									</c:if>		
								</td>
						    </tr>
						  </tbody>
						</table>
				</table>
							<br><br>
				</c:forEach>
				
				<%-- <table class="dictListTable_${loopTagStatus.index} lang_color_${dict.lang_code}" border=0 cellpadding=0 cellspacing=0>
					<tr><td>
					<table class="dicListTable"  border=0 bordercolor="lightblue" cellpadding=10 cellspacing=0>
						<tr align="center">
							<input type="hidden" name="dict_no" value="${dict.dict_no}">
					        <input type="hidden" name="note_no" value="${dict.note_no}">
					        <input type="hidden" name="lang_code" value="${dict.lang_code}">
							<th class="card-header table_word" width=200>${dict.word}
							<th class="card-header">작성자: <td class="table_register" width=90>${dict.register}
							<th class="card-header">등록일: <td class="table_input_date"  width=50>${dict.input_date}		
							<th class="card-header">참조: <td class="table_refer"  width=50>${dict.refer}
							<!--  추천수  -->
							<th class="card-header">추천수: <td class="rate_cnt_${loopTagStatus.index}" width=50>${dict.rate_cnt}
							<td><span class="btn_R" style="cursor:pointer" onClick="recommend(${loopTagStatus.index});">추천하기</span>
						<tr>		
							<td class="card-body text-dark table_content" colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
				 <!--   <tr>
							<td colspan=7>
							Comment<br>
							<textarea cols=80 rows=1 name="comment"></textarea>
							<input type="button" name="co_reg_btn" value="댓글달기">  -->
						<tr class="card-footer">	
							<td  align=center colspan=8>
							<c:if test="${dict.cnt>1}">
								<span class="btn" style="cursor:pointer" onClick="seeMore(${loopTagStatus.index});">다른 작성자 글 (${dict.cnt-1} 개) 더보기 Click!</span> 
							</c:if>
							<c:if test="${dict.cnt<=1}">
								<span class="btn" style="cursor:no-drop">다른 꼬리글이 없습니다.</span> 
							</c:if>								
						<small class="btn text-muted" style="cursor:pointer" onClick="seeMore(${loopTagStatus.index});">다른 작성자 글 더보기 Click!</small>
					</table>
						<div align="right">
							<!--  수정/삭제 권한 1이고 유저아이디는 비어있지 않고 관리자아이디가 null이면  수정/삭제 버튼이 보인다.-->
						    <c:if test="${sessionScope.acc_upDel eq '1' && not empty sessionScope.user_id && sessionScope.admin_id==null}">
								<input type="button" value="수정/삭제"  onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp;
						    </c:if>
						    <c:if test="${ sessionScope.admin_id!=null}">	
								<input type="button" value="수정/삭제"  onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp;
						    </c:if>			 
				    	</div>
				</table> --%>
						
				<!-- 만약에 검색 후, 게시판 결과가 없을 경우 없다고 출력하기 -->				
				<c:if test="${(requestScope.dictListAllCnt_total)==0}">
					<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
				</c:if>
			</div><!-- dictList 끝 -->	
		</div><!-- inner container 끝 -->
	</div><!-- container 태그 끝 -->	


		<!-- ============================== -->
		<!-- post 방식으로 이동할 form 태그 --> 
		<!-- ============================== -->	
		
		<!--다른 작성글 더보기로 이동하는 form 태그 선언하기-->
		<form name="dictContentForm" method="post" action="${requestScope.croot}/dictContentForm.do"> 
	        <input type="hidden" name="lang_code">
	        <input type="hidden" name="dict_no">
	        <input type="hidden" name="search_date" value="${sessionScope.dictSearchDTO.search_date}">
				<input type="hidden" name="range" value="${sessionScope.dictSearchDTO.range}">
				<input type="hidden" name="orderby" value="${sessionScope.dictSearchDTO.orderby}">
				<input type="hidden" name="asc_desc" value="${sessionScope.dictSearchDTO.asc_desc}">
				<input type="hidden" name="top" value="${sessionScope.dictSearchDTO.top}">
				<input type="hidden" name="begin_year" value="${sessionScope.dictSearchDTO.begin_year}">
				<input type="hidden" name="begin_month" value="${sessionScope.dictSearchDTO.begin_month}">
				<input type="hidden" name="end_year" value="${sessionScope.dictSearchDTO.end_year}">
				<input type="hidden" name="end_month" value="${sessionScope.dictSearchDTO.end_month}">
	    </form>
		<!--===============================================-->
		<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
		<!--===============================================-->
		<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do">
			 <input type="hidden" name="keyword" value="${sessionScope.dictSearchDTO.keyword}">   
			 <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
			 <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10"> 
			 <input type="hidden" name="lang_code">
			 <input type="hidden" name="dict_no">
			 <input type="hidden" name="note_no">
			 <input type="hidden" class="search_keyword" name="search_keyword" value="전체선택">
		     <input type="hidden" class="search_keyword search_keyword1" name="search_keyword" value="단어" >	
			 <input type="hidden" class="search_keyword" name="search_keyword" value="작성자" >
			 <input type="hidden" class="search_keyword" name="search_keyword" value="내용" >
		</form>
		
		<!--===============================================-->
		<!-- [ 수정삭제 ] 화면 이동하는 form 태그 선언하기 -->
		<!--===============================================-->
		<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"> 
			 <input type="hidden" name="dict_no">   
			 <input type="hidden" name="lang_code">
     	     <input type="hidden" name="note_no">				
	 	     <input type="hidden" name="word">   
			 <input type="hidden" name="content">
	 	     <input type="hidden" name="refer">   				
     	     <input type="hidden" name="register">
	     	 <input type="hidden" class="search_keyword" name="search_keyword" value="전체선택">
		     <input type="hidden" class="search_keyword" name="search_keyword" value="단어" >	
			 <input type="hidden" class="search_keyword" name="search_keyword" value="작성자" >
			 <input type="hidden" class="search_keyword" name="search_keyword" value="내용" >
		</form>
		<!--===============================================-->
		<!--추천하기 클릭하면 이동하는 form 태그 선언하기-->
		<!--===============================================-->
		<form name="recommendForm" method="post" action="${requestScope.croot}/recommend.do"> 
			<input type="hidden" name="d_no">
			<input type="hidden" name="lang_code">
			<input type="hidden" name="user_id" class="user_id" value="${sessionScope.user_id}"/>
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
		
		
	<%-- 
	<c:if test="${requestScope.dictListAllCnt_total==0||requestScope.tabDictListAllCnt_kor==0||requestScope.tabDictListAllCnt_eng==0||requestScope.tabDictListAllCnt_cn==0}">
		<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
	</c:if> --%>
			
		
	<!-- 비동기 방식으로 가져온 데이터 보기위해 여기에 소스삽입 코드 -->
	<!-- <textarea cols=100 rows=500 name=xxx></textarea> -->
	
	
  	<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <div class="jumbotron" style="height: 400px; background-color: rgb(255, 255, 255);">
	</div>

</body>

</html>


<!-- 
	<table>
		<tr>
			<td align="center">
		        
		        <br><br> -->
				<%-- 
				<!-- 페이징 처리 관련 파트 -->
				<!--선택한 페이지번호가 저장되는 입력양식 표현하기 선택한 페이지번호는 DB 연동시 아주 중요한 역할을 한다.-->	
				<input type="hidden" name="selectPageNo" class="selectPageNo" value="${param.selectPageNo}">
			    <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="${param.rowCntPerPage}"> 
			      --%>
							
				<%-- <br><br>
				<div class="cnt">
					[검색어 총 개수]:
					<c:choose>
						<c:when test="${requestScope.dictListAllCnt_total==0}">
							<span>0</span>
						</c:when>
						<c:otherwise>
							<span>${requestScope.dictListAllCnt_total}</span>
						</c:otherwise>
					</c:choose>
				</div> --%>
				
			
				<!---페이징 번호를 삽입할 span 태그 선언하기------>
				<!-- <div class="paging">&nbsp;<span class="pagingNumber"></span>&nbsp;</div> -->
				<!-- <input type="text" name="paging"> -->
				<!-- 언어탭 선택 파트  -->
				<!-- <table class="dicListTable2 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('0');" ><b>통합검색</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer"  onClick="goTabDictList('1');" ><b>한국어</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('2');"><b>영어</b></span>
						
						&nbsp;&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('3');"><b>일본어</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('4');"><b>중국어</b></span>
						&nbsp;&nbsp;&nbsp;
				</table>
			 -->
		<!-- 검색어 흔적을 보내기 위한 히든 Form -->
       <!--    
         <form name="dictListForm" method="post" action="${requestScope.croot}/dictList.do">
         <input type="text" name="dict_no" value="${requestScope.dict_no}">
	        <input type="text" name="note_no" value="${requestScope.note_no}">
		    <input type="text" name="keyword" value="${sessionScope.dictSearchDTO.keyword}">
		    <input type="text" name="lang_code" value="${sessionScope.dictSearchDTO.lang_code}">	
	        <input type="text" name="note_no" value="${requestScope.note_no}">
		 </form>
		 -->
		<!--다른 작성글 더보기로 이동하는 form 태그 선언하기-->
		<%-- <form name="dictContentForm" method="post" action="${requestScope.croot}/dictContentForm.do"> 
	        <input type="hidden" name="lang_code">
	        <input type="hidden" name="dict_no">
	    </form> --%>
	<!--     <input type="hidden" name="lang_code" value="${sessionScope.dictSearchDTO.lang_code}">		    			    
		    <input type="hidden" name="keyword" value="${sessionScope.dictSearchDTO.keyword}">			
			 <input type="hidden" name="keyword" value="${sessionScope.dictSearchDTO.search_keyword}"> 			
			<input type="hidden" name="search_date" value="${sessionScope.dictSearchDTO.search_date}">
			<input type="hidden" name="range" value="${sessionScope.dictSearchDTO.range}">
			<input type="hidden" name="orderby" value="${sessionScope.dictSearchDTO.orderby}">
			<input type="hidden" name="asc_desc" value="${sessionScope.dictSearchDTO.asc_desc}">
			<input type="hidden" name="begin_year" value="${sessionScope.dictSearchDTO.begin_year}">
			<input type="hidden" name="begin_month" value="${sessionScope.dictSearchDTO.begin_month}">
			<input type="hidden" name="end_year" value="${sessionScope.dictSearchDTO.end_year}">
			<input type="hidden" name="end_month" value="${sessionScope.dictSearchDTO.end_month}">						
			<input type="hidden" name="selectPageNo" class="selectPageNo" value="${sessionScope.dictSearchDTO.selectPageNo}">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="${sessionScope.dictSearchDTO.rowCntPerPage}">
		</form>
		-->
		<%-- <!--====================================================-->
		<!-- [ 관리자 게시판 ] 화면 이동하는 form 태그 선언하기 -->
		<!--====================================================-->
		 <form name="adminForm"  method="post" action="${requestScope.croot}/adminForm.do"></form> 
		<!--====================================================-->
		<!-- [ 홈 ] 화면 이동하는 form 태그 선언하기            -->
		<!--====================================================-->
		<form name="frontPage" method="post" action="${requestScope.croot}/frontPage.do"></form> 
		<!--===============================================-->
		<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
		<!--===============================================-->
		<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do">
			 <input type="hidden" name="keyword" value="${sessionScope.dictSearchDTO.keyword}">   
			 <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
			 <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10"> 
			 <input type="hidden" name="lang_code">
			 <input type="hidden" name="dict_no">
			 <input type="hidden" name="note_no">
			 <input type="hidden" class="search_keyword" name="search_keyword" value="전체선택">
		     <input type="hidden" class="search_keyword search_keyword1" name="search_keyword" value="단어" >	
			 <input type="hidden" class="search_keyword" name="search_keyword" value="작성자" >
			 <input type="hidden" class="search_keyword" name="search_keyword" value="내용" >
		</form>
		<!--===============================================-->
		<!-- [ 수정삭제 ] 화면 이동하는 form 태그 선언하기 -->
		<!--===============================================-->
			<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"> 
				 <input type="hidden" name="dict_no">   
				 <input type="hidden" name="lang_code">
		 	     <input type="hidden" name="word" >   
				 <input type="hidden" name="content" >
		 	     <input type="hidden" name="refer"  >   				
	     	     <input type="hidden" name="note_no" >  				
	     	     <input type="hidden" name="register" >
		     	 <input type="hidden" class="search_keyword" name="search_keyword" value="전체선택">
			     <input type="hidden" class="search_keyword" name="search_keyword" value="단어" >	
				 <input type="hidden" class="search_keyword" name="search_keyword" value="작성자" >
				 <input type="hidden" class="search_keyword" name="search_keyword" value="내용" >
			</form> --%>
		
<%-- 			<td>
<div class="dictList">
				<!-- 통합검색 -->
				<c:forEach items="${requestScope.dictList_total}" var="dict" varStatus="loopTagStatus" >
				<table class="card border-dark mb-3 dictListTable_${loopTagStatus.index} lang_color_${dict.lang_code}" border=0 cellpadding=0 cellspacing=0>
					<tr><td>
					<table class="dicListTable"  border=0 bordercolor="lightblue" cellpadding=10 cellspacing=0>
						<tr align="center">
							<input type="hidden" name="dict_no" value="${dict.dict_no}">
					        <input type="hidden" name="note_no" value="${dict.note_no}">
					        <input type="hidden" name="lang_code" value="${dict.lang_code}">
							<th class="card-header table_word" width=200>${dict.word}
							<th class="card-header">작성자: <td class="table_register" width=90>${dict.register}
							<th class="card-header">등록일: <td class="table_input_date"  width=50>${dict.input_date}		
							<th class="card-header">참조: <td class="table_refer"  width=50>${dict.refer}
							<!--  추천수  -->
							<th class="card-header">추천수: <td class="rate_cnt_${loopTagStatus.index}" width=50>${dict.rate_cnt}
							<td><span class="btn_R" style="cursor:pointer" onClick="recommend(${loopTagStatus.index});">추천하기</span>
							
						<tr>		
							<td class="card-body text-dark table_content" colspan=8>&nbsp;&nbsp;&nbsp;${dict.content}
				 <!--   <tr>
							<td colspan=7>
							Comment<br>
							<textarea cols=80 rows=1 name="comment"></textarea>
							<input type="button" name="co_reg_btn" value="댓글달기">  -->
					 
						<tr class="card-footer">	
							<td  align=center colspan=8>
							<c:if test="${dict.cnt>1}">
							<span class="btn" style="cursor:pointer" onClick="seeMore(${loopTagStatus.index});">다른 작성자 글 (${dict.cnt-1} 개) 더보기 Click!</span> 
							</c:if>
							<c:if test="${dict.cnt<=1}">
							<span class="btn" style="cursor:no-drop">다른 꼬리글이 없습니다.</span> 
							</c:if>								
						<small class="btn text-muted" style="cursor:pointer" onClick="seeMore(${loopTagStatus.index});">다른 작성자 글 더보기 Click!</small>
					
					</table>
						<div align="right">
						<!--  수정/삭제 권한 1이고 유저아이디는 비어있지 않고 관리자아이디가 null이면  수정/삭제 버튼이 보인다.-->
							   <c:if test="${sessionScope.acc_upDel eq '1' && not empty sessionScope.user_id && sessionScope.admin_id==null}">
									<input type="button" value="수정/삭제"  onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp;
							   </c:if>
							   <c:if test="${ sessionScope.admin_id!=null}">	
									<input type="button" value="수정/삭제"  onClick="goDictUpDelForm(${loopTagStatus.index});">&nbsp;
							   </c:if>			 
						    </div>
				</table>
				<br><br>	
				</c:forEach>
				

		
		<!-- 만약에 검색 후, 게시판 결과가 없을 경우 없다고 출력하기 -->				
		<c:if test="${(requestScope.dictListAllCnt_total)==0}">
			<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
		</c:if>
</div>	 --%>
		
	

  <!-- 탭이동 좌축 vertical
	  <div class="d-flex" id="wrapper">
	  
			Sidebar
		    <div class="bg-dark border-dark" id="sidebar-wrapper">
		      <div class="list-group list-group-flush">
		        <a href="javascript:goTabDictList('0');" class="list-group-item list-group-item-action bg-dark text-white">통합검색</a>
		        <a href="javascript:goTabDictList('1');" class="list-group-item list-group-item-action bg-dark text-white">한국어</a>
		        <a href="javascript:goTabDictList('2');" class="list-group-item list-group-item-action bg-dark text-white">영어</a>
		        <a href="javascript:goTabDictList('3');" class="list-group-item list-group-item-action bg-dark text-white">일본어</a>
		        <a href="javascript:goTabDictList('4');" class="list-group-item list-group-item-action bg-dark text-white">중국어</a>
		      </div>
		    </div>
		    
	   </div>
 -->
    
	<!-- 북마크 -->
	<!-- <div class="bookmarks">
			<table border=1>
				<thead>
				<tr><th bgcolor=#DBDBDB width=100px><a>BOOKMARK</a></th></tr>
				</thead>
				<tbody>
				<tr><td style="cursor:pointer" class="bookmark bookmark_0" onclick="goTabDictList('0');"><b>통합검색
						</b></td></tr>
				<tr><td style="cursor:pointer" class="bookmark bookmark_1" onclick="goTabDictList('1');"><b>한국어
						</b></td></tr>
				<tr><td style="cursor:pointer" class="bookmark bookmark_2" onclick="goTabDictList('2');"><b>영어
						</b></td></tr>
				<tr><td style="cursor:pointer" class="bookmark bookmark_3" onclick="goTabDictList('3');"><b>일본어
						</b></td></tr>
				<tr><td style="cursor:pointer" class="bookmark bookmark_4" onclick="goTabDictList('4');"><b>중국어
						</b></td></tr>
				</tbody>
			</table>
	</div> -->
	
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
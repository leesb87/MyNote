
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<%@include file="common_admin.jsp" %>

<%-- <%@include file="common.jsp" %> --%>

<html>

<!-- Required meta tags -->
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 

<!-- Bootstrap CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"> 
<head>

<title>회원관리 목록</title>
  <script>	
	$(document).ready(function(){

		
		// 텍스트 컬리지정
		//$(".txt01").css({'color':'#b4361f'});

		
			// 관리자, 유저 접근 관리
		    <c:if test="${empty sessionScope.admin_id}">
				alert("관리자만 접근 가능합니다.")
				document.loginForm.submit();
			</c:if>  

//======================================= [ 전체 선택  ] =======================================================			
			
            $(".access_all").change(function(){									
	             if( $(".access_all").is(":checked")){               
	            	 $(".accessCheck").prop("checked",true);
				 }else{
	            	 $(".accessCheck").prop("checked",false);
			     }			  
			});
			$(".accessCheck").change(function(){			    
				 if($(".accessCheck").filter(":checked").size() < $(".accessCheck").size()){    					 
					 $(".access_all").prop("checked",false);
				 }	            
	             else{
	            	 $(".access_all").prop("checked",true);
				 }
			 });

							
//======================================= [ 생년월일 상세 검색 ] =======================================================			
//------------------  시작 시간 ----------------------------------------
			 insertYMD_to_select3(
						$(".begin_birth_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".begin_birth_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
						, $(".begin_birth_day")                               // 일 관련 select 태그를 관리하는 JQuery 객체
						, 1950                        // 최소년도
						, new Date().getFullYear()    // 최대년도
						, 1                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
					);
//------------------  종료 시간 ----------------------------------------
			 insertYMD_to_select3(
						$(".end_birth_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".end_birth_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
						, $(".end_birth_day")                            // 일 관련 select 태그를 관리하는 JQuery 객체
						, 1950                        // 최소년도
						, new Date().getFullYear()    // 최대년도
						, 1                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
					);

//======================================= [ 생년월일 상세 검색  유효성 체크 ] =======================================================				
			 $(".begin_birth_year, .begin_birth_month, .end_birth_year, .end_birth_month").change(function(){				 
				// checkYearMonthRange( $(".begin_year"), $(".begin_month"), $(".end_year"), $(".end_month"), "생년월일");			
				    var minYear = $(".begin_birth_year").val();
					var minMonth = $(".begin_birth_month").val();
					var minDay = $(".begin_birth_day").val();
					var maxYear = $(".end_birth_year").val();
					var maxMonth = $(".end_birth_month").val();
					var maxDay = $(".end_birth_day").val();
					 //---------------------------------------------------------------------
					// 만약에  최소년도가 없고, 최소 월이 없으면 최소 월이 있을경우에 경고
					//---------------------------------------------------------------------
					if(  (minYear=="") &&   (minMonth!="") ){                 				    
					    $(".begin_birth_year").val("1000");
							
					}	
				    //---------------------------------------------------------------------
					// 만약에  최소년도가 있고, 최소 월이 없으면 최소 월에 1 넣어주기
					//---------------------------------------------------------------------
					if(  (minYear!="") &&   (minMonth=="") ){                 
						$(".begin_birth_month").val("01");				
					}
			     
				    //---------------------------------------------------------------------
					// 만약에  최소년도고, 최소 월이 없으면 최소 월에 1 넣어주기
					//---------------------------------------------------------------------
					if(  (minYear!="") &&   (minMonth=="") ){                 
						$(".begin_birth_month").val("01");				
					}
					//---------------------------------------------------------------------
					// 만약에  최대 년도가 있고, 최소 년도  최대 월이 없으면 최대 월에 12 넣어주기
					//---------------------------------------------------------------------
					if(maxYear!="" && minYear=="" && maxMonth==""){
						$(".begin_birth_year").val("1000");
						$(".begin_birth_month").val("01");
						$(".begin_birth_day").val("01");
						$(".end_birth_month").val("12");						
					}
						
					//---------------------------------------------------------------------
					// 만약에  최소 년도 있고, 최소 월도 있고, 최대 년도는 없고, 최대 월이 있으면
					//---------------------------------------------------------------------
					if(minYear!=""  &&   minMonth!=""  && maxYear=="" && maxMonth!=""){
		
						$(".end_birth_year").val("3000");
					
					}
					//---------------------------------------------------------------------
					// 만약에   최소 년도 , 최소 월, 최대 년도가 없고, 최대 월이 있으면
					//---------------------------------------------------------------------
					if( minYear==""  &&   minMonth==""   && maxYear=="" && maxMonth!=""){
						$(".begin_birth_year").val("1000");
						$(".begin_birth_month").val("01");
						$(".begin_birth_day").val("01");
						$(".end_birth_year").val("3000");						
						}
					//---------------------------------------------------------------------
					// 만약에   최소 년도 , 최소 월, 최대 년도가 있고, 최대 월이 없으면
					//---------------------------------------------------------------------
					if( minYear!=""  &&   minMonth!=""   && maxYear!="" && maxMonth==""){
						  
							$(".end_birth_month").val("01");
							  
						}
										    
					//---------------------------------------------------------------------
					// 만약에  최대년도, 최대월, 최소년도, 최소월이 모두 있으면
					//---------------------------------------------------------------------
					if( minYear!="" && minMonth!="" && maxYear!="" && maxMonth!="" ){
					    if( (minYear>maxYear) ||(minYear==maxYear && parseInt(minMonth,10)>parseInt(maxMonth,10)     )    ){
							alert("가입일 최소값이 가입일 최대값이 보다 큽니다.");
							$(".begin_birth_year").val("");
							$(".begin_birth_month").val("");
							$(".end_birth_year").val("");
							$(".end_birth_month").val("");							
						}
					return;	
				    }
			 });

			
//======================================= [ 가입일 상세 검색 ] =======================================================			
//------------------  시작 시간 ----------------------------------------
			 insertYMD_to_select2(
						$(".begin_regDate_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".begin_regDate_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
						
						, 1950                        // 최소년도
						, new Date().getFullYear()    // 최대년도
						, 1                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
					);
//------------------  종료 시간 ----------------------------------------
			 insertYMD_to_select2(
						$(".end_regDate_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
						, $(".end_regDate_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
						
						, 1950                        // 최소년도
						, new Date().getFullYear()    // 최대년도
						, 1                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
					);


//======================================= [ 가입일 상세 검색  유효성 체크 ] =======================================================				
			 $(".begin_regDate_year, .begin_regDate_month, .end_regDate_year, .end_regDate_month").change(function(){				 
				// checkYearMonthRange( $(".begin_year"), $(".begin_month"), $(".end_year"), $(".end_month"), "생년월일");							  				  
				    var minYear = $(".begin_regDate_year").val();
					var minMonth = $(".begin_regDate_month").val();
					var maxYear = $(".end_regDate_year").val();
					var maxMonth = $(".end_regDate_month").val();
					
					 //---------------------------------------------------------------------
					// 만약에  최소년도가 없고, 최소 월이 없으면 최소 월이 있을경우에 경고
					//---------------------------------------------------------------------
					if(  (minYear=="") &&   (minMonth!="") ){                 				    
					    $(".begin_regDate_year").val("1000");
							
					}	
				    //---------------------------------------------------------------------
					// 만약에  최소년도가 있고, 최소 월이 없으면 최소 월에 1 넣어주기
					//---------------------------------------------------------------------
					if(  (minYear!="") &&   (minMonth=="") ){                 
						$(".begin_regDate_month").val("01");				
					}
					//---------------------------------------------------------------------
					// 만약에  최대 년도가 있고,  최대 월이 없으면 최대 월에 12 넣어주기
					//---------------------------------------------------------------------
					if(maxYear!="" && minYear=="" && maxMonth==""){
						$(".begin_regDate_year").val("1000");
						$(".begin_regDate_month").val("01");
						$(".end_regDate_month").val("12");							
					}
						
					//---------------------------------------------------------------------
					// 만약에  최소 년도 있고, 최소 월도 있고, 최대 년도는 없고, 최대 월이 있으면
					//---------------------------------------------------------------------
					if(minYear!=""  &&   minMonth!=""  && maxYear=="" && maxMonth!=""){
		
						$(".end_regDate_year").val("3000");
					
					}
					//---------------------------------------------------------------------
					// 만약에   최소 년도 , 최소 월, 최대 년도가 없고, 최대 월이 있으면
					//---------------------------------------------------------------------
					if( minYear==""  &&   minMonth==""   && maxYear=="" && maxMonth!=""){
						   alert("최소년도 부터 선택해주세요.")
							$(".end_regDate_month").val("");
							   return;
						}
					//---------------------------------------------------------------------
					// 만약에   최소 년도 , 최소 월, 최대 년도가 있고, 최대 월이 없으면
					//---------------------------------------------------------------------
					if( minYear!=""  &&   minMonth!=""   && maxYear!="" && maxMonth==""){						  
							$(".end_regDate_month").val("01");
							
						}						    
					//---------------------------------------------------------------------
					// 만약에  최대년도, 최대월, 최소년도, 최소월이 모두 있으면
					//---------------------------------------------------------------------
					if( minYear!="" && minMonth!="" && maxYear!="" && maxMonth!="" ){
					    if( (minYear>maxYear) ||(minYear==maxYear && parseInt(minMonth,10)>parseInt(maxMonth,10)     )    ){
							alert("가입일 최소값이 가입일 최대값이 보다 큽니다.");
							$(".begin_regDate_year").val("");
							$(".begin_regDate_month").val("");
							$(".end_regDate_year").val("");
							$(".end_regDate_month").val("");							
						}
					return;	
				    }
			 });
			/* var begin_year = $(".begin_year");
	        insertYear(begin_year, 1930);
	        
	        var begin_month = $(".begin_month");
	        insertMonth(begin_month); 
	
	        var end_year = $(".end_year");
	        insertYear(end_year, 1930);
	        
	        var end_month = $(".end_month");
	        insertMonth(end_month);  */

	        
			//alert("user_accessSearchDTO.selectPageNo" + ${user_accessSearchDTO.selectPageNo} + "user_accessSearchDTO.rowCntPerPage" + ${user_accessSearchDTO.rowCntPerPage});
	
	       //-------------------- name=rowCntPerPage 를 가진 태그의  change 이벤트가 발생하면 실행하면 search_when_pageNoClick( ) 함수가 실행된다.   -----------------
	        $('[name=rowCntPerPage]').change(function( ){
				search_when_pageNoClick( );
			});
			
//==================================================        [ 검색흔적 남기기 ]       ==================================================================
          //-------------------- [키워드 검색 흔적 남기기] -----------------	
	         inputData("[name=main_keyword]", "${requestScope.adminSearchDTO.main_keyword}"); 

	      //-------------------- [키워드 검색 흔적 남기기] -----------------	
	         inputData("[name=content_keyword]", "${requestScope.adminSearchDTO.content_keyword}"); 

	      //-------------------- [성별 검색 흔적 남기기] -----------------	 
		        <c:forEach items="${adminSearchDTO.access}" var="access_tmp">  
		          inputData("[name=adminForm] [name=access]", "${access_tmp}");                                                                                 
		          <%-- $("[name=boardListForm] [name=date]").filter("[value=${date}]").prop("checked",true); --%>  
		        </c:forEach> 


		  //-------------------- [페이징처리 흔적 남기기] -----------------	
	         inputData( ".selectPageNo", "${requestScope.adminSearchDTO.selectPageNo}"); 
	     
	         inputData( ".rowCntPerPage", "${requestScope.adminSearchDTO.rowCntPerPage}");       

		  //-------------------- [성별 검색 흔적 남기기] -----------------	 
	        <c:forEach items="${adminSearchDTO.gender}" var="gender_tmp">  
	          inputData("[name=adminForm] [name=gender]", "${gender_tmp}");                                                                                 
	          <%-- $("[name=boardListForm] [name=date]").filter("[value=${date}]").prop("checked",true); --%>  
	        </c:forEach> 

		  //-------------------- [거주지 검색 흔적 남기기] -----------------	  
	         inputData("[name=addr]", "${requestScope.adminSearchDTO.addr}"); 

          //-------------------- [연령대 검색 흔적 남기기] -----------------	        
	        <c:forEach items="${adminSearchDTO.age_group}" var="age_group_tmp">  
	          inputData("[name=adminForm] [name=age_group]", "${age_group_tmp}");                                                                                 
	      
	        </c:forEach> 

	       //-------------------- [날짜 검색 흔적 남기기] -----------------	  
	         inputData("[name=date]", "${requestScope.adminSearchDTO.date}"); 
           
	         inputData("[name=range]", "${requestScope.adminSearchDTO.range}"); 

		   //-------------------- [정렬 내림차순 또는 오름차순 흔적 남기기] -----------------	  
	         inputData("[name=orderby]", "${requestScope.adminSearchDTO.orderby}");  

   
	         //-------------------- [생년월일  상세 검색 흔적 남기기] -----------------	
             inputData("[name=begin_birth_year]", "${requestScope.adminSearchDTO.begin_birth_year}"); 
           
             inputData("[name=begin_birth_month]", "${requestScope.adminSearchDTO.begin_birth_month}"); 
		
             inputData("[name=end_birth_year]", "${requestScope.adminSearchDTO.end_birth_year}"); 

             inputData("[name=end_birth_month]", "${requestScope.adminSearchDTO.end_birth_month}"); 
        
	   
	       //-------------------- [가입일 상세 검색 흔적 남기기] -----------------	
	           inputData("[name=begin_regDate_year]", "${requestScope.adminSearchDTO.begin_regDate_year}"); 
             
               inputData("[name=begin_regDate_month]", "${requestScope.adminSearchDTO.begin_regDate_month}"); 
		
               inputData("[name=end_regDate_year]", "${requestScope.adminSearchDTO.end_regDate_year}"); 

               inputData("[name=end_regDate_month]", "${requestScope.adminSearchDTO.end_regDate_month}"); 
                        

//==================================================   [ 정렬 내림차순 또는 오름차순  DB 연동된 데이터 출력하기  ]       ==================================================================	
          
          //-------------------- [ 회원ID 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".user_idCnt").text("회원ID");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='user_id desc'}">
		            $(".user_idCnt").text("회원ID ▼");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='user_id asc'}">
		            $(".user_idCnt").text("회원ID ▲");
		     </c:if>    
	
	      //-------------------- [이름 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".user_nameCnt").text("유저명");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='user_name desc'}">
		            $(".user_nameCnt").text("유저명 ▼");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='user_name asc'}">
		            $(".user_nameCnt").text("유저명 ▲");
		     </c:if>    

		  //-------------------- [주소 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".addrCnt").text("주소");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='addr desc'}">
		            $(".addrCnt").text("주소 ▼");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='addr asc'}">
		            $(".addrCnt").text("주소 ▲");
		     </c:if>    

		  //-------------------- [주민번호 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".jumin_numCnt").text("주민번호");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='jumin_num asc'}">
		            $(".jumin_numCnt").text("주민번호 ▼");

		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='jumin_num desc'}">
		            $(".jumin_numCnt").text("주민번호 ▲");
		     </c:if>   
		            //alert(  ${requestScope.adminSearchDTO.orderby});
		   
		  //-------------------- [이메일 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".emailCnt").text("이메일");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='email desc'}">
		            $(".emailCnt").text("이메일 ▼");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='email asc'}">
		            $(".emailCnt").text("이메일 ▲");
		     </c:if>

	      //-------------------- [전화번호 정렬 DB연동된 데이터를 꺼내기 ] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".tel_numCnt").text("전화번호");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▼" 덮어씌우기   
		     <c:if test="${requestScope.adminSearchDTO.orderby=='tel_num desc'}">
		            $(".tel_numCnt").text("전화번호 ▼");
		     </c:if>  
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='tel_num asc'}">
		            $(".tel_numCnt").text("전화번호 ▲");
		     </c:if>   
		          
		  //-------------------- [가입일 정렬 DB연동된 데이터를 꺼내기] -----------------	
	         <c:if test="${empty requestScope.adminSearchDTO.orderby}">                 
		            $(".reg_dateCnt").text("가입일");
		     </c:if>  		
		     // 만약에 BoardSearchDTO 객체 안의 orderby 속성변수에 "" 저장되어 있으면  
		     //classs=readCnt 를 가진 태그 내부에 "조회수▲" 덮어씌우기        
		     <c:if test="${requestScope.adminSearchDTO.orderby=='reg_date asc'}">
		            $(".reg_dateCnt").text("가입일 ▲");
		     </c:if>   

//==================================================        [ 페이징 처리  ]       ==================================================================	
	        
			$(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.adminAllCnt}"     
						,"${requestScope.adminSearchDTO.selectPageNo}"      
						,"${requestScope.adminSearchDTO.rowCntPerPage}"       
						,"5"                      						
				     	,"search_when_pageNoClick();"             
					)
			);
			
//==================================================        [ 행별로 색 넣기 ]       ==================================================================	
			setTableTrBgColor(
					"boardTable"            
					, "#E0E0E0"                
					, "white"                 
					, "#F2F2F2"		    
					, "lightblue"          
			);
//==================================================        [ 공백 넣기  ]       ==================================================================			
			//inputBlank_to_tdth( ".boardTable", 1);			
//==========================================  [ 정렬  오름차순 또는 내림차순 ]       ==================================================================				
	  // ----- [ 글번호 클릭하면 일어날 이벤트 발생 ] ---------	 
	

	 // ----- [ 회원ID을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".user_idCnt").click(function(){		       
		           var txt = $(this).text();
		           if(txt=="회원ID") {		        	                 
		        	     $(".orderby").val("user_id desc");
		           }
		           else if(txt=="회원ID ▼") {            
		        	     $(".orderby").val("user_id asc");   
		           }
		           else if(txt=="회원ID ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 
		         
	 // ----- [ 이름을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".user_nameCnt").click(function(){		       
		           var txt = $(this).text();                  
		           if(txt=="유저명") {		        	                 
		        	     $(".orderby").val("user_name desc");
		           }
		           else if(txt=="유저명 ▼") {            
		        	     $(".orderby").val("user_name asc");   
		           }
		           else if(txt=="유저명 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 	
			 
	// ----- [ 주소을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".addrCnt").click(function(){		       
		           var txt = $(this).text();                 
		           if(txt=="주소") {		        	                 
		        	     $(".orderby").val("addr desc");
		           }
		           else if(txt=="주소 ▼") {            
		        	     $(".orderby").val("addr asc");   
		           }
		           else if(txt=="주소 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 	
	// ----- [ 주민번호을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".jumin_numCnt").click(function(){		       
		           var txt = $(this).text();                 
		           if(txt=="주민번호") {		        	                 
		        	     $(".orderby").val("jumin_num asc");
		           }
		           else if(txt=="주민번호 ▼") {            
		        	     $(".orderby").val("jumin_num desc");   
		           }
		           else if(txt=="주민번호 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 
		         
	// ----- [ 이메일을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".emailCnt").click(function(){		       
		           var txt = $(this).text();                 
		           if(txt=="이메일") {		        	                 
		        	     $(".orderby").val("email desc");
		           }
		           else if(txt=="이메일 ▼") {            
		        	     $(".orderby").val("email asc");   
		           }
		           else if(txt=="이메일 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      });
		       
	// ----- [ 전화번호을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".tel_numCnt").click(function(){		       
		           var txt = $(this).text();                  
		           if(txt=="전화번호") {		        	                 
		        	     $(".orderby").val("tel_num desc");
		           }
		           else if(txt=="전화번호 ▼") {            
		        	     $(".orderby").val("tel_num asc");   
		           }
		           else if(txt=="전화번호 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 	         		         
			 	 
	 // ----- [ 가입일을 클릭하면 일어날 이벤트 발생 ] ---------	 
			  $(".reg_dateCnt").click(function(){		       
		           var txt = $(this).text();
		           if(txt=="가입일") {		                   
		        	     $(".orderby").val("reg_date asc");   
		           }
		           else if(txt=="가입일 ▲"){              
		      	         $(".orderby").val("");   
		           }  
		      document.adminForm.submit(); 
		      }); 	
		
//==================================================        [ 날짜 유효 체크   ]       ==================================================================	
		
	   $(".date, .range").change(function(){	 
			   var date  = $(".date").val();
			   var range = $(".range").val();
			   
				if( (date=="") && (range!="") ){
					alert("날짜부터 선택해 주십시오.");
					//경고하고 class=birth_motnh, class=birth_date를 가진 태그가 selet태그이므로
					//""를 가진 option태그가 선택됨
					$(".date").val("");
					$(".range").val("당일");
					$(".date").focus();
					return;
				}
	   }); 


  });	// $(document).ready(function() 끝나는 부분

  
//=================================================================================================================================
//===================================== [ 체크박스 클릭시 실행될 함수 선언 ] ======================================================
//=================================================================================================================================
	
	function updateAccess( classV, columnN ){

		//alert(event.target.value );
		
		var obj = $("."+classV);
		var checked = obj.prop("checked");
		// 체크될때 넣어주는 변수 updateV 선언
		var updateV = "0";
		//만약 체크될 때 updateV 변수에 "1" 넣어준ㄷ
		if(checked){ updateV="1";}
			
		var value = obj.val();
		var user_no = obj.parent().parent().find("[name=user_no]").val();
		alert("체크박스 눌렀냉2!" + "user_no : "+ user_no + "columnN : " +columnN + "/updateV : " + updateV);

//================ ▼입력한 체크박스 양식으로 비동기 DB연동 실행구문 선언▼ ====================
		
		$.ajax({

			url : "${requestScope.croot}/accessUpdateProc.do"
			,type:"post"
			,data:{"user_no":user_no, "columnN":columnN, "updateV":updateV}
			,success:function(updateCnt){
				if(updateCnt==1){alert("권한 갱신 성공!")}
				else{alert("권한 갱신 실패! 관리자 호출 요망");}
				}
			,error:function(){
				alert("서버 접속 실패");

				}

			});
		
		}

//=====================================  [ 페이지 번호 클릭하면 호출되는 함수 선언 ] ================================================================		
	
	function search_when_pageNoClick(){      
		  var keyword = $("[name=main_keyword]").val();   
        if(keyword!=null && keyword.split(" ").join("")!=""){	        
			   keyword = $.trim(keyword);  		       
			   $("[name=main_keyword]").val(keyword);
        }
	  // name=boardListForm 를 가진 form 태그 안의 action의 값의  URL 주소로 웹서버로 접속하기 입력한 키워드 얻기
	  document.adminForm.submit();  
  }		
	
//==============================================         [ 검색 ]        ================================================================
	function search(){
		var cnt = 0;
		
		if(isEmpty($("[name=main_keyword]")) == false){cnt++}
		//if(isEmpty($("[name=content_keyword]")) == false){cnt++}		
		if(isEmpty($("[name=gender]")) == false){cnt++}
		if(isEmpty($("[name=addr]")) == false){cnt++}
		if(isEmpty($("[name=age_group]")) == false){cnt++}
		if(isEmpty($("[name=date]")) == false){cnt++}
		//if(isEmpty($("[name=range]")) == false){cnt++}
		if(isEmpty($("[name=access]")) == false){cnt++}
		
	
		if(isEmpty($("[name=begin_birth_year]")) == false){cnt++}
		if(isEmpty($("[name=begin_birth_month]")) == false){cnt++}
		if(isEmpty($("[name=end_birth_year]")) == false){cnt++}
		if(isEmpty($("[name=end_birth_month]")) == false){cnt++}
		if(isEmpty($("[name=begin_regDate_year]")) == false){cnt++}
		if(isEmpty($("[name=begin_regDate_month]")) == false){cnt++}
		if(isEmpty($("[name=end_regDate_year]")) == false){cnt++}
		if(isEmpty($("[name=end_regDate_month]")) == false){cnt++}

	if(cnt == 0){
			alert("검색 조건이 비어 있어 검색할 수 없습니다.")
	
			return;
		}
	
		if(isEmpty($("[name=begin_birth_year]")) == false  &&  isEmpty($("[name=begin_birth_month]"))== false         
		    && isEmpty($("[name=end_birth_year]")) ){
			   alert("최대날짜의 년과 월을  입력해주세요")
			return;
		}
		
		if(isEmpty($("[name=begin_regDate_year]")) == false  &&  isEmpty($("[name=begin_regDate_month]"))== false         
			    && isEmpty($("[name=end_regDate_year]")) ){
				   alert("최대날짜의 년과 월을  입력해주세요")
				return;
		}
	 
     document.adminForm.submit();    

     //alert( $("[name=userAccessForm]").serialize()  );
     return; 

  
     
    /*   $.ajax({
          url :"${request.croot}/userAccessForm.do"
          , type : "post"
          , data : $("[name=userAccessForm]").serialize()         
          ,success :function(html){
        	 // alert(html)
             // alert( $(html).find(".boardListAllCnt").text()  );
              // $("[name=xxx]").text(html);
          } 
  	      ,error : function(){
             alert("서버 접속 실패");
          }			
      });*/		
   }      

//=====================================  [모두 검색 클릭하면 실행되는 함수 선언 ] =========================================================

    function searchAll(){   
         	$("[name=selectPageNo]").val("1");
			$("[name=main_keyword]").val("");
			$("[name=content_keyword]").val("");			
		    $("[name=gender]").prop("checked",false);
		    $("[name=addr]").val("");
		    $("[name=age_group]").prop("checked",false);
		    $("[name=date]").val("");
		    $("[name=range]").val("");
		
		    $("[name=access]").prop("checked",false);
		    
		    $("[name=begin_regDate_year]").val("");
		    $("[name=begin_regDate_month]").val("");
		    $("[name=end_regDate_year]").val("");
		    $("[name=end_regDate_month]").val("");

			$("[name=begin_birth_year]").val("");
		    $("[name=begin_birth_month]").val("");
		    $("[name=end_birth_year]").val("");
		    $("[name=end_birth_month]").val("");	 	    
          document.adminForm.submit();
    }
 
  //=====================================  [초기화 버튼 클릭하면 실행되는 함수 선언 ] =========================================================

   function resetAll(){
		    $("[name=selectPageNo]").val("1");
			$("[name=main_keyword]").val("");
			$("[name=content_keyword]").val("");
		    $("[name=gender]").prop("checked",false);
		    $("[name=addr]").val("");

			$("[name=age_group]").prop("checked",false);

			$("[name=date]").val("");
		    $("[name=range]").val("");

		    $("[name=access]").prop("checked",false);
		    
		    $(".orderby").val("");

		    $("[name=begin_regDate_year]").val("");
		    $("[name=begin_regDate_month]").val("");
		    $("[name=end_regDate_year]").val("");
		    $("[name=end_regDate_month]").val("");

			$("[name=begin_birth_year]").val("");
		    $("[name=begin_birth_month]").val("");
		    $("[name=end_birth_year]").val("");
		    $("[name=end_birth_month]").val("");	  
          document.adminForm.submit();
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

		
	</script>
	<style>
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

<body><center>
	  
<!-- adminForm  폼 테그  -->
<form name="adminForm" method="post" action="${requestScope.croot}/adminForm.do">

			<!--  관리자 페이지에서 흔적 확인 -->
			<input type="hidden" name="admin_id" class="admin_id"  value="${sessionScope.admin_id}"/>
			<input type="hidden" name="user_id" class="user_id" value="${sessionScope.user_id}"/>
			<input type="hidden" name="user_name" class="user_name" value="${sessionScope.user_name}"/>
			<input type="hidden" name="user_name" class="user_name" value="${sessionScope.acc_read}"/>
			<input type="hidden" name="user_name" class="user_name" value="${sessionScope.acc_upDel}"/>
			<input type="hidden" name="user_name" class="user_name" value="${sessionScope.acc_write}"/>      
			<input type="hidden" name="selectPageNo" class="selectPageNo">
			<input type="hidden" name="orderby" class="orderby" >
       
       <nav class="navbar navbar-expand-lg navbar-dark bg-dark border-bottom">
			<b><a class="navbar-brand" href="javascript:goFrontPage();">MY NOTE</a></b>
	        <div class="collapse navbar-collapse" id="navbarSupportedContent">
	          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
	            <li class="nav-item active">
	             <b><a class="nav-link" href="javascript:goFrontPage();">HOME<span class="sr-only">(current)</span></a></b>
	            </li>
	            <li class="nav-item">
	              <b><a class="nav-link" href="javascript:goLoginForm();">LogOut</a></b>
	            </li>
	            <li class="nav-item dropdown">
	              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	                이동하기
	              </a>
	              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
	                  <!-- <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a> -->
				      <a class="dropdown-item" href="javascript:goDictRegForm();">새 글 등록하기</a>
					  <a class="dropdown-item" href="javascript:goDictUpDelForm();">글 수정/삭제</a>
					  <a class="dropdown-item" href="javascript:goMyNote();">나의 노트</a>
	               <div class="dropdown-divider"></div>
					  <!-- <a class="dropdown-item" href="javascript:goLogout();">회원정보수정</a> -->			
	                  <a class="dropdown-item" href="javascript:goUserRegForm();">회원가입</a>
	              </div>
	            </li>
	          </ul>
	        </div>
      </nav>
	  <div class="jumbotron bg" style="height: 100px; background-color: rgb(35, 67, 105);">
	  </div> 
	  <!-- 관리자 모드 안내 방법2 -->
      <div class="alert alert-light alert-dismissible fade show" role="alert">
	  	<h5 style="text-align: left;"  class="txt01"><b>${sessionScope.admin_id} 님 '관리자모드'로 접속하셨습니다!</b></h5>
	  	<button type="button" class="close" data-dismiss="alert" aria-label="Close">
	   		<span aria-hidden="true">&times;</span>
	  	</button>
	  </div> 
	  
	  <div class="container">
	  <nav class="navbar navbar-expand-lg navbar-light bg-light">
			<span class="navbar-brand"><b>회원정보관리</b></span>
      </nav>
<!--   <nav class="justify-content-end navbar navbar-expand-lg navbar-dark bg-dark">
		  <b><a class="navbar-brand" href="#">회원정보검색</a></b>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>
			  <div class="collapse navbar-collapse" id="navbarNavDropdown">
			    <ul class="navbar-nav navbar-right">
			      <li class="nav-item active">
			        <b><a class="nav-link" href="javascript:goFrontPage();">HOME<span class="sr-only">(current)</span></a></b>
			      </li>
			      <li class="nav-item">
			        <b><a class="nav-link" href="javascript:goLoginForm();">LogIn</a></b>
			      </li>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          이동하기
			        </a>
			        <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
				      <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a>
				      <a class="dropdown-item" href="javascript:goDictRegForm();">새 글쓰기</a>
					  <a class="dropdown-item" href="javascript:goUserRegForm();">회원가입</a>
					  <a class="dropdown-item" href="javascript:goDictUpDelForm();">수정/삭제</a>
					  <a class="dropdown-item" href="javascript:goLogout();">로그아웃</a>								
				    </div>
			      </li>
			    </ul>
			  </div>
		</nav>    -->
		<div class="jumbotron" style="height:550px; padding-top : 50px;">
		 <div class="container-xl">
		 <div class="adminAllCnt txt01" style="text-align: left">[총 회원 수] : ${requestScope.adminAllCnt} 명</div>
				<table class="table table-striped table-bordered table-secondary">
				  <tbody>
				    <tr>
				    	<th scope="row" style="text-align:center;">검색</th>
				    	<td colspan="3">
						    <div class="input-group is-invalid">
							     <div class="form-group my-1" style="text-align: center;">
									 <div class="btn-group" data-toggle="buttons">
										<select class="form-control-sm content_keyword" name="content_keyword">					 
										  <option value="전체">전체</option>
										  <option value="회원ID">회원ID</option>
										  <option value="이름">유저명</option>
										  <option value="주소">주소</option>
										  <option value="이메일">이메일</option>
										  <option value="전화번호">전화번호</option>						
										</select>
									</div>					
								 </div>
							      <!-- 검색어 파트 -->
							      <div class="form-group my-1">	
									<input type="text" name="main_keyword" class="form-control-sm main_keyword" size="20" placeholder="검색어를 입력해주세요." ></td> 
								  </div>
						    </div>
					    </td>
				    </tr>
				    <tr>
				      <th scope="row" style="text-align:center;">성별선택</th>
				      <td>
						<div class="form-group " style="text-align: left;" >
								<input type="checkbox" class="gender" name="gender" value="남자">&nbsp;남자
						        &nbsp;&nbsp;                						    
								<input type="checkbox" class="gender" name="gender"  value="여자">&nbsp;여자															
						   </div>
					  </td>
					  <th scope="row" style="text-align:center;">거주지 <br>선택</th>
				      <td>
					      <div class="form-group" style="text-align:left;">
								<div class="btn-group" data-toggle="buttons">
									<select class="form-control form-control-sm addr" name="addr">					 
									  <option value="">전체</option>
									  <option value="서울">서울</option>
									  <option value="인천">인천</option>
									  <option value="부산">부산</option>
									  <option value="경상도">경상도</option>
									  <option value="제두도">제주도</option>
									  <option value="전라도">전라도</option>
									  <option value="대구">대구</option>
									</select>
								</div>					
						  </div>
				      </td>
				    </tr>
				    <tr>
				      <th scope="row" style="text-align:center;">연령대 <br>선택</th>
				      <td>
					       <div class="form-group" style="text-align:left;">				
								<input type="checkbox" class="age_group" name="age_group" value="10">&nbsp;20대미만
						        &nbsp;                						    
								<input type="checkbox" class="age_group" name="age_group"  value="20">&nbsp;20대이상
						        &nbsp;                 						    
								<input type="checkbox" class="age_group" name="age_group"  value="30">&nbsp;30~40대
	                            &nbsp; 
				                <input type="checkbox" class="age_group" name="age_group" value="50">&nbsp;50대이상																		
							</div>
				      </td>
				      <th scope="row" style="text-align:center;">가입일<br>선택</th>
				      <td>
					      <div class="form-group">
							<div class="btn-group ly_cont" data-toggle="buttons">				 								
								<select class="form-control-sm date" name="date">
								  <option value="">전체날짜</option>					 						  
								  <option value="오늘">오늘</option>
								  <option value="어제">어제</option>
								  <option value="7일전">7일전</option>
								  <option value="15일전">15일전</option>		
								</select>																										
						    </div>
							&nbsp;&nbsp;
							<div class="btn-group" data-toggle="buttons">									
								<select class="form-control-sm range" name="range">					 					
								  <option value="당일">당일</option>
								  <option value="이전">이전</option>
								  <option value="이후">이후</option>			
								</select>
							    </div>	
							</div>	
					  </td>			
				     </tr>
				     <tr>
				      <th scope="row" style="text-align:center;">생년월일</th>
				      	<td>
				   			  <select name="begin_birth_year" class="begin_birth_year form-control-sm"> 
				                   <option value="">-선택-</option>
				                   <option value="1000">최소</option>
				               </select>  년
								
				               <select name="begin_birth_month" class="begin_birth_month form-control-sm">
				                    <option value="">-선택-</option>
				               </select>  월
				                ~
				                 <br>
				                 <select name="end_birth_year" class="end_birth_year form-control-sm"> 
				                   <option value="">-선택-</option>
				                   <option value="3000">최대</option>
				               </select>  년
				
				               <select name="end_birth_month" class="end_birth_month form-control-sm">
				                    <option value="">-선택-</option>
				               </select>  월
				    	</td>
				    	<th scope="row" style="text-align:center;">가입일<br>상세조건</th>
				    	<td>
				    		<select name="begin_regDate_year" class="begin_regDate_year form-control-sm" > 
			                   <option value="">-선택-</option>
			                   <option value="1000">최소</option>			                 
			               </select>  년
							
			               <select name="begin_regDate_month" class="begin_regDate_month form-control-sm">
			                    <option value="">-선택-</option>
			               </select>  월                                                   
			                ~
			                 <br>
			                 <select name="end_regDate_year" class="end_regDate_year form-control-sm" > 
			                   <option value="">-선택-</option>
			                   <option value="3000">최대</option>	
			               </select>  년
			               		
			               <select name="end_regDate_month" class="end_regDate_month form-control-sm">
			                    <option value="">-선택-</option>
			               </select>  월
				    	</td>
				    </tr>
				    <tr>
					    <th scope="row" style="text-align:center;">권한조회</th>
					      	<td colspan="3">
					      	<div class="form-group" style="text-align:left;">				
									<input type="checkbox" class="access_all"   name="access_all" >&nbsp;<b>전체선택</b>
									&nbsp;						
									<input type="checkbox" class="access accessCheck" name="access" value="acc_read">&nbsp;읽기가능
							        &nbsp
							        <input type="checkbox" class="access accessCheck" name="access" value="acc_read_dis">&nbsp;읽기불가
							        &nbsp;                						    
									<input type="checkbox" class="access accessCheck" name="access"  value="acc_upDel">&nbsp;수정/삭제가능
							        &nbsp;
							        <input type="checkbox" class="access accessCheck" name="access" value="acc_upDel_dis">&nbsp;수정/삭제불가
							        &nbsp;                 						    
									<input type="checkbox" class="access accessCheck" name="access" value="acc_write">&nbsp;쓰기가능
							        &nbsp;
									<input type="checkbox" class="access accessCheck" name="access"  value="acc_write_dis">&nbsp;쓰기불가																					
							</div>		
					      	</td>
					    </tr>
				  </tbody>
				</table>
				</div>
				<div class="btn_area_c" style="width: 30%; float:none; margin:0 auto"> 
					<button type="button" class="btn btn-dark btn-sm" onClick="search();">검색</button>
					&nbsp;
					<button type="button" class="btn btn-dark btn-sm" onClick="searchAll();">모두검색</button>
					&nbsp;
					<button type="reset" class="btn btn-dark btn-sm" onclick="resetAll();">초기화</button>
		        </div>   
		</div>
	    <!--  [ 회원 목록 게시판 ]    --> 
			<div class="container" >
			<!--<div class="center-block" style="width:1500px; padding:100px;" >  -->
				<div class="row">
					<div class="float-left">		 
						 <select name="rowCntPerPage" class="rowCntPerPage">
					           <option value="10">10
					           <option value="15">15
					           <option value="20">20
					           <option value="25">25
					           <option value="30">30		     		      		      		      
				         </select>행보기
		     		 &nbsp;<span class="pagingNumber"></span>&nbsp;
		      	    </div>
		      	</div>
	      	    <div class="row">
					<table class="table table-light table-hover table-bordered shadow-sm p-3 mb-5 bg-white rounded" style="margin-left: auto; margin-right: auto;">
						  <thead>
							    <tr class="table-secondary" style="text-align: center;">
								<th scope="col"><span class="orderCnt" style="cursor:pointer">글번호</span></th>
								<th scope="col"><span class="user_idCnt" style="cursor:pointer">회원ID</span></th>
								<th scope="col"><span class="user_nameCnt" style="cursor:pointer">유저명</span></th>
								<th scope="col"><span class="addrCnt" style="cursor:pointer">주소</span></th>
								<th scope="col"><span class="jumin_numCnt" style="cursor:pointer">주민번호</span></th>
								<th scope="col"><span class="emailCnt" style="cursor:pointer">이메일</span></th>
								<th scope="col"><span class="tel_numCnt" style="cursor:pointer">전화번호</span></th>
								<th scope="col"><span class="reg_dateCnt" style="cursor:pointer">가입일</span></th>
								<th scope="col">읽기</th>
								<th scope="col">수정/삭제</th>
								<th scope="col">쓰기</th>
							    <!-- <th  bgcolor="${requestScope.thBgcolor}" style="text-align: center;"><span class="user_no" style="cursor:pointer">번호</span></th>-->				
								<%-- <th  bgcolor="${requestScope.thBgcolor}" style="text-align: center;">비밀번호</th> --%>
							    </tr>
						  </thead>
						  <tbody>
						   <c:forEach items="${requestScope.adminList}" var="user_info" varStatus="loopTagStatus">
							 <tr>  		
								<td align=center>${requestScope.adminAllCnt-(adminSearchDTO.selectPageNo*adminSearchDTO.rowCntPerPage-adminSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1}</td>
			 			 	 	<input type="hidden" name="user_no" value="${user_info.user_no}">             
								<%--<td align=center>${adminSearchDTO.selectPageNo*adminSearchDTO.rowCntPerPage-adminSearchDTO.rowCntPerPage+1+loopTagStatus.index}</td>--%>
						
								<td align=center>${user_info.user_id}</td>
							<%--<td align=center>${user_info.pwd}</td> --%>
								<td align=center>${user_info.user_name}</td>
								<td align=center>${user_info.addr}</td>
								<td align=center>${user_info.jumin_num}******</td>
								<td align=center>${user_info.email}</td>
								<td align=center>${user_info.tel_num}</td>
								<td align=center>${user_info.reg_date}</td>
							
							<c:if test="${user_info.acc_read=='1'}">
								<td align=center>
								<input type="checkbox" class="acc_read_${loopTagStatus.index}" name="acc_read_${loopTagStatus.index}" onChange="updateAccess('acc_read_${loopTagStatus.index}','acc_read');" checked></td>
							</c:if>
							<c:if test="${user_info.acc_read=='0'}">
								<td align=center>
								<input type="checkbox" class="acc_read_${loopTagStatus.index}" name="acc_read_${loopTagStatus.index}" onChange="updateAccess('acc_read_${loopTagStatus.index}','acc_read');"></td>
							</c:if>
							<c:if test="${user_info.acc_upDel=='1'}">
								<td align=center>
								<input type="checkbox" class="acc_upDel_${loopTagStatus.index}" name="acc_upDel_${loopTagStatus.index}" onChange="updateAccess('acc_upDel_${loopTagStatus.index}','acc_upDel');" checked></td>
							</c:if>
							<c:if test="${user_info.acc_upDel=='0'}">
								<td align=center>
								<input type="checkbox" class="acc_upDel_${loopTagStatus.index}" name="acc_upDel_${loopTagStatus.index}" onChange="updateAccess('acc_upDel_${loopTagStatus.index}','acc_upDel');"></td>
							</c:if>
							<c:if test="${user_info.acc_write=='1'}">
								<td align=center>
								<input type="checkbox" class="acc_write_${loopTagStatus.index}" name="acc_write_${loopTagStatus.index}" onChange="updateAccess('acc_write_${loopTagStatus.index}','acc_write');" checked></td>
							</c:if>
							<c:if test="${user_info.acc_write=='0'}">
								<td align=center>
								<input type="checkbox" class="acc_write_${loopTagStatus.index}" name="acc_write_${loopTagStatus.index}"  onChange="updateAccess('acc_write_${loopTagStatus.index}','acc_write');"></td>
							</c:if>						
					    	</tr>
				  		</c:forEach>
				  </table>
						<c:if test="${empty requestScope.adminList}">
								<h5>검색 조건에 맞는 데이터가 없습니다.</h5>
						</c:if>
						<div class="jumbotron" style="height: 100px; background-color: rgb(255, 255, 255);">
	 					</div> 
			    </div>
			 </div>
			<!-- </div> -->
		</div>
 </form>  
 		<br><br>
 		
 		<div class="container">
		 <div class="jumbotron" style="height:0px; padding-bottom: 50px;">
		 </div>
 		</div>
 		
<!-- post 방식으로 이동할 form 태그 --> 	
			<!-- ---------------------------------------------->
			<!-- [ 로그인 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="loginForm" method="post" action="${requestScope.croot}/loginForm.do"></form>
			<!-- ------------------------------------------------>
			<!-- [ 로그아웃 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="logout" method="post" action="${requestScope.croot}/logout.do"></form>
			<!-- --------------------------------------------------->
			<!-- [ 홈 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="frontPage" method="post" action="${requestScope.croot}/frontPage.do"></form>
			<!-- -------------------------------------------------->
			<!-- [  검색 목록  ] 화면 이동하는 form 태그 선언하기 -->
			<%-- <form name="dictListForm" method="post" action="${requestScope.croot}/dictList.do">
				<input type="hidden" name="lang_code" value="0">
				<input type="hidden" class="search_keyword" name="search_keyword" value="전체선택" checked>
				<input type="hidden" class="search_keyword" name="search_keyword" value="단어" checked>	
				<input type="hidden" class="search_keyword" name="search_keyword" value="작성자" checked>
				<input type="hidden" class="search_keyword" name="search_keyword" value="내용" checked>	
			</form> --%>
			<!-- ------------------------------------------------>
			<!-- [ 회원가입 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="userRegForm" method="post" action="${requestScope.croot}/userRegForm.do"></form>
			<!-- ------------------------------------------------>
			<!-- [ 새글쓰기 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="dictRegForm" method="post" action="${requestScope.croot}/dictRegForm.do"></form>
			<!-- ------------------------------------------------>
			<!-- [ 노트 수정/삭제 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="dictUpDelForm" method="post" action="${requestScope.croot}/dictUpDelForm.do"></form>
			<!-- ------------------------------------------------>
			<!-- [ 나의 노트 ] 화면 이동하는 form 태그 선언하기 -->
			<form name="myNoteForm" method="post" action="${requestScope.croot}/mynote.do"></form>
			
			
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>


<!-- 

   //=====================================  [ 최소년도,최소월, 최대년도,최대월 유효성 체크 ] =========================================================

   
   /*  function checkDate(){
	   
	   
   }*/

	
/* 	function checkDate(){
			var begin_year = $(".begin_year").val();
	        var begin_month = $(".begin_month").val();
	        var end_year = $(".end_year").val();
	        var end_month = $(".end_month").val();
	
	        var begin_date = new Date(
	            parseInt(begin_year, 10),
	            parseInt(begin_month, 10)-1
	        );
	
	        var end_date = new Date(
	            parseInt(end_year, 10),
	            parseInt(end_month, 10)-1
	        );
	
	        var today = new Date();
	
	        if(today.getTime() < begin_date.getTime()){
	        	alert("현재날짜보다 미래를 선택하셨습니다.")
	            $(".begin_year").val("");
	        	$(".begin_month").val("");
	            return;
	        }
	
	        else if(today.getTime() < end_date.getTime()  ){
	        	alert("현재날짜보다 미래를 선택하셨습니다.")
	            $(".end_year").val("");
	        	$(".end_month").val("");
	            return;
	        }
	
	        if(end_date.getTime() < begin_date.getTime()){
	        	alert("최소날짜가 최대날짜보다 큽니다.")
	            $(".begin_year").val("");
	        	$(".begin_month").val("");
	        	$(".end_year").val("");
	        	$(".end_month").val("");
	        }
		}
	  */
<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
			data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			<%-- <c:if test="${!empty sessionScope.admin_id}">
			<li><a href="javascript:goUserRegForm();" >회원 멤버 목록</a></li>
			</c:if> --%>
	       </ul>
		
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class = "dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
				aria-expanded="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
				        <li><a href="javascript:goFrontPage();"> 홈 </a></li>
			            <li><a href="javascript:goDictList();">검색 목록</a></li>
			            <li><a href="javascript:goDictRegForm();">새글 쓰기</a></li>
			            <li><a href="javascript:goLoginForm();">로그인 화면</a></li>
						<li><a href="javascript:goLogout();">로그 아웃</a></li>									
					    <li><a href="javascript:goUserRegForm();">회원가입</a></li>
					    <li><a href="javascript:goDictUpDelForm();">수정/삭제</a>
				</ul>				
			</li>
		</ul>
	</div>
</nav>

 <div class="btn-group-vertical float-left">
			  <button type="button" class="btn btn-secondary" onClick="goFrontPage();">HOME</button>
			  <button type="button" class="btn btn-secondary" onClick="goLoginForm();">LogIn</button>
	 		  <div class="btn-group" role="group">
				    <button id="btnGroupDrop1" type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				      이동하기
				    </button>
				    <div class="dropdown-menu" aria-labelledby="btnGroupDrop1">
				      <a class="dropdown-item" href="javascript:goDictList();">검색 목록</a>
				      <a class="dropdown-item" href="javascript:goDictRegForm();">새글 쓰기</a>
					  <a class="dropdown-item" href="javascript:goUserRegForm();">회원가입</a>
					  <a class="dropdown-item" href="javascript:goDictUpDelForm();">수정/삭제</a>
					  <a class="dropdown-item" href="javascript:goLogout();">로그 아웃</a>								
				    </div>
			 	  </div>
	  </div> -->

   
   
   
   
            

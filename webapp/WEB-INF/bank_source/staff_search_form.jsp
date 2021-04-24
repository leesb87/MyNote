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
<%-- <%@include file="common.jsp" %> --%>
<!-- jsp파일이 같은 폴더 안에 없을 경우 include file="/WEB-INF/views/common.jsp"로 경로를 설정하며,
	 해당 파일을 찾을 수 있다.
 --> 



<head>
<meta charset="UTF-8">
<title>검색 화면</title>
	
	

	<script>
	//------------------------------------------
	// body태그 안의 모든 태그를 읽어들인 후 실행할 자스코딩 설정
	//------------------------------------------
	$(document).ready(function(){

		$(".staffTable").hide();
		if(${empty requestScope.staffList}){ alert("스태프리스트가 비었습니다.");}	
		if(${!empty requestScope.staffList}){ alert("스태프리스트에 뭔가 있습니다.");
		$(".staffTable").show();}	
		

    	//************************************************
		// class="keyword1"을 가진 입력양식에 HttpServletRequest객체가 가진
		// "boardSearchDTO" 키값명에 저장된 객체에서,
		// keyword1이라는 속성변수 안의 데이터를 EL로 표현하여 저장하기
 		//************************************************
  	    inputData(".staff_name", "${requestScope.staffSearchDTO.staff_name}");
  		//************************************************
		// class="selectPageNo"을 가진 입력양식에 HttpServletRequest객체가 가진
		// "boardSearchDTO" 키값명에 저장된 객체에서,
		// selectPageNo이라는 속성변수 안의 데이터를 EL로 표현하여 저장하기
 		//************************************************
		inputData(".selectPageNo", "${requestScope.staffSearchDTO.selectPageNo}");

		
		/* if(달러{!empty requestScope.staffList}){달러(".staffTable").show();} */
		$(".search").click(function(){
			checkSearchForm();
			});
		$(".searchAll").click(function(){

			alert("전체검색 눌렀냉!");
			document.staffList.submit();
			
				});
		$(".register").click(function(){

			alert("등록 눌렀냉!");

				});
		 
		inputBlank_to_tdth(".staffTable", 3);
	 
		$(".pagingNumber").html(

				getPagingNumber(
						"${requestScope.staffListAllCnt}"   		   // 검색 결과 총 행 개수
						,"${requestScope.staffSearchDTO.selectPageNo}" // 선택된 현재 페이지 번호
						,"${requestScope.staffSearchDTO.rowCntPerPage}" // 페이지 당 출력행의 개수
						,"5" 										   // 페이지 당 출력번호 개수
						,"search_when_pageNoClick();"     			   // 페이지 번호 클릭후 실행할 자스 코드

						)
				); 


	

		insertYMD_to_select3(
				$(".grad_year")              // 년도 관련 select 태그를 관리하는 JQuery 객체
				, $(".grad_month")           // 월 관련 select 태그를 관리하는 JQuery 객체
				, $(".grad_date")            // 일 관련 select 태그를 관리하는 JQuery 객체
				, 1950                        // 최소년도
				, new Date().getFullYear()    // 최대년도
				, 2                           // 년도의 오름차순 또는 내림차순 옵션. 1이면 오름차순, 2면 내림차순
			);
		
			
 		//------------------------------------------------------------------
		// class=birth_year, class=birth_monnth, class=birth_date를 가진 3개의 태그에
		// change 이벤트가 발생하면 실행할 자스코딩 설정하기
		//------------------------------------------------------------------	
		$(".min_grad_year, .min_grad_month, .min_grad_date").change(function(){

		//선택한 연,월,일을 얻어서 각각 변수에 저장하기	
		var grad_year = $(".min_grad_year").val();
		var grad_month = $(".min_grad_month").val();
		var grad_date = $(".min_grad_date").val();
		//alert("birth_year : " + birth_year + " birth_month : " + birth_month + " birth_date : " + birth_date);

		if(grad_year!="" && grad_month!=""){
			insertValidDate( $(".min_grad_year"),  $(".min_grad_month"), $(".min_grad_date") );	
			}
		});

		$(".max_grad_year, .max_grad_month, .max_grad_date").change(function(){

			//선택한 연,월,일을 얻어서 각각 변수에 저장하기	
			var grad_year = $(".max_grad_year").val();
			var grad_month = $(".max_grad_month").val();
			var grad_date = $(".max_grad_date").val();
			//alert("birth_year : " + birth_year + " birth_month : " + birth_month + " birth_date : " + birth_date);

			if(grad_year!="" && grad_month!=""){
				insertValidDate( $(".max_grad_year"),  $(".max_grad_month"), $(".max_grad_date") );	
				}
			});

		

	});


 	function checkSearchForm(){
		//------------------------------------------------------------------
		if( checkEmpty( ".staff_name", "이름을 입력해주세요.")==true ){ return; }
		//------------------------------------------------------------------	
		//religion min_grad_day max_grad_day

		document.staffList.submit();
	} 


	//+++++++++++++++++++++++++++++++++++++++++++++
	// [페이지 번호를 클릭]하면 호출되는 함수 선언
	//+++++++++++++++++++++++++++++++++++++++++++++
	function search_when_pageNoClick( ){

		//입력한 키워드 얻기		
		var staff_name = $(".staff_name").val();
		//-------------------------------------------
		
		//-------------------------------------------
		//입력한 키워드가 비어있지 않으면
		if(staff_name!=null && staff_name.split(" ").join("")!=""){
			// 정상적인 검색을 위해 키워드의 앞뒤공백을 제거하기
				staff_name = $.trim(staff_name);
		}
		//-------------------------------------------
		// name=keyword1가진 입력양식에 앞뒤공백 제거한 키워드 넣어주기
		$(".staff_name").val(staff_name);
		//-------------------------------------------
		//-------------------------------------------
		// name=boardListForm을 가진 form태그의 action값의 URL로 웹서버에 접속하기
		// 이동시 해당 form태그안의 모든 입력양식이 파라미터값으로 전송된다.
		//-------------------------------------------
		document.staffList.submit();

		}



	function btnSelector( str ){

			if(str=='logout'){
				document.milestone.action="${requestScope.croot}/logout.do";
			}
			else if(str=='gesipan'){
				document.milestone.action="${requestScope.croot}/boardList.do";
			}
			else if(str=='goDictRegForm'){
				document.milestone.action="${requestScope.croot}/dictRegForm.do";
			}
			else if(str=='goDictUpDelForm'){
				document.milestone.action="${requestScope.croot}/dictUpDelForm.do";
			}
			document.milestone.submit();
		}

	
	</script>


</head>

<body><center>
	<!-- ****************************************************** -->
	<!--  [새글쓰기 탭]을 내포한 form태그 선언 -->
	<!-- ****************************************************** -->
	
	<div>
	<input type="button" value="로그아웃" onClick="btnSelector('logout');">
	<input type="button" value="게시판" onClick="btnSelector('gesipan');">
	<input type="button" value="사전" onClick="btnSelector('goDictRegForm');">
	<input type="button" value="수정/삭제" onClick="btnSelector('goDictUpDelForm');">
	</div>
	<form name="milestone" method="post" action="${requestScope.croot}/logout.do">
	</form>
<p></p>
<form name="staffList" class="staffList" method="post" action="${requestScope.croot}/staffList.do">
	
	<table border=1  class="boardTable tbcss1" cellpadding="7">

	

	<tr><th colspan="6" bgcolor="${requestScope.thBgcolor}">사원 정보 검색</th></tr>
	<tr>
		<th width=80 bgcolor="${requestScope.thBgcolor}">이름
		<td><input type="text" name="staff_name" class="staff_name">
		<th width=80 bgcolor="${requestScope.thBgcolor}">성별
		<td>		<input type="checkbox" name="gender" class="gender" value="male">남
					<input type="checkbox" name="gender" class="gender" value="female">여
		<th width=80 bgcolor="${requestScope.thBgcolor}">종교<td align="center"><select name="religion" class="religion">
					<option value="">
					<option value="기독교">기독교</option>
					<option value="천주교">천주교</option>
					<option value="불교">불교</option>
					<option value="이슬람">이슬람</option>
					<option value="무교">무교</option>
					</select>
	</tr>
	<tr>
		<th width=80 bgcolor="${requestScope.thBgcolor}">학력
				<td><input type="checkbox" name="school_name" class="school_name" value="1">고졸
					<input type="checkbox" name="school_name" class="school_name" value="2">전문대졸
					<input type="checkbox" name="school_name" class="school_name" value="3">일반대졸

		<th width=80 bgcolor="${requestScope.thBgcolor}">기술<td colspan="3">
					<input type="checkbox" name="skill_name" class="skill_name=" value="Java">Java
					<input type="checkbox" name="skill_name" class="skill_name=" value="JSP">JSP
					<input type="checkbox" name="skill_name" class="skill_name=" value="ASP">ASP
					<input type="checkbox" name="skill_name" class="skill_name=" value="PHP">PHP
					<input type="checkbox" name="skill_name" class="skill_name=" value="Delphi">Delphi
		</tr>
		<tr>
			<th bgcolor="${requestScope.thBgcolor}">졸업일</th>
			<td colspan="6">
				<select name="min_grad_year" class="min_grad_year grad_year">
					<option value="">
				</select> 년
				<select name="min_grad_month" class="min_grad_month grad_month">
					<option value="">
				</select> 월
				<select name="min_grad_date" class="min_grad_date grad_date">
					<option value="">
				</select> 일    ~    
				
				<select name="max_grad_year" class="max_grad_year grad_year">
					<option value="">
				</select> 년
				<select name="max_grad_month" class="max_grad_month grad_month">
					<option value="">
				</select> 월
				<select name="max_grad_date" class="max_grad_date grad_date">
					<option value="">
				</select> 일
			</td>
		</tr>
		<!-- <tr><td colspan="6"><textarea cols=20 rows=40 name=xxx></textarea></td></tr> -->
		
	</table>				
</form>		
		
	
<form>	
	<table>	
		<tr><td width=80><td width=80><td width=80><td width=80><td width=80><td width=80></tr>
		<tr>
			<td align="center" colspan="3"><input type="button" class="search" value="            검색             ">
			<td align="right" colspan="3"><input type="button" class="searchAll" value=" 전부검색 ">
										   <input type="reset" value=" 초기화 ">
									 	   <input type="button" class="register" value="  등록  ">
		</tr>
		
	</table>

</form>	
		<!-- -------------- -->
		<!-- 게시판 총 검색개수 출력하기 -->
		<!-- -------------- -->
	[검색 결과] : <span class ="staffListAllCnt" float="right"><b>${requestScope.staffListAllCnt}&nbsp;&nbsp;건&nbsp;</b></span>
<!-- </table> -->
	<p></p>
	
	<table border=1 class="staffTable tbcss2">
		<tr align='center' bgcolor='gray'>
		<!--  <th>번호</th> -->
		<th>번호</th><th width=150>이름</th><th>성별</th><th>종교</th><th>졸업일</th><th>&nbsp;&nbsp;&nbsp;&nbsp;</th>
		</tr>
	

	<c:forEach items="${requestScope.staffList}" var="staff" varStatus="loopTagStatus">
	<tr>
		<td align=center>
			<!-- 역순번호 출력 
	&nbsp;&nbsp;
	S{boardListAllCnt-((boardSearchDTO.selectPageNo-1)*boardSearchDTO.rowCntPerPage+loopTagStatus.index+1)+1}
	&nbsp;&nbsp; -->
					<!-- 정순번호 출력시 아래코드로 대체 
					달러표시{boardSearchDTO.selectPageNo*boardSearchDTO.rowCntPerPage-boardSearchDTO.rowCntPerPage+1+loopTagStatus.index}
					 --> 
				${loopTagStatus.index+1}	 
			<td>&nbsp;${staff.staff_name}&nbsp;&nbsp;
			<td align=center>&nbsp;&nbsp;${staff.gender}&nbsp;&nbsp;
			<td align=center>&nbsp;&nbsp;${staff.religion}&nbsp;&nbsp;
			<td align=center>&nbsp;&nbsp;${staff.graduate_day}	&nbsp;&nbsp;
			<td align=center><input type="button" value="수정/삭제">				
			</c:forEach>


<!-- 	int staff_no; -->


		<tr><td align=center colspan="6">
		<!-- ******************************************************* -->
		<!-- 페이징 번호를 삽입할 span태그 선언하기 -->
		<!-- ******************************************************* -->
		<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>

	</table>

	<input type="hidden" name="selectPageNo" class="selectPageNo">


	

</body>

</html>
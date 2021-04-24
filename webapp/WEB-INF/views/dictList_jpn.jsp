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
<!-- jsp파일이 같은 폴더 안에 없을 경우 include file="/WEB-INF/views/common.jsp"로 경로를 설정하며,
	 해당 파일을 찾을 수 있다.
 --> 



<head>
<meta charset="UTF-8">
<title>게시판 목록</title>
<style> 
 .dicListTable1 {
	width:100;
	
}
 .dicListTable2 {
	
	background-color:lightblue;
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
	//------------------------------------------
	// body태그 안의 모든 태그를 읽어들인 후 실행할 자스코딩 설정
	//------------------------------------------
	$(document).ready(function(){
		$(".keyword").keypress(function(event){
			if ( event.which == 13 ) {
				$('.keywordSearch').click();
				return false;
			}
		});
		
	});
	// 공용함수 enterKey로 검색하기
	//enterKey( $(".keyword"), $('.keywordSearch')
	//****************************************
	// [키워드 검색] 함수 선언
	//******************
	function search(){
		alert("검색시작!");

		//---------------------------------------
		// 만약 키워드가 비어있거나 공백으로 구성되어 있으면, ""로 세팅하기
		// <주의> 공백이면 공백으로 DB연동하므로 공백으로만 되어 있으면 ""로 세팅한다.
		//---------------------
		if( isEmpty($("[name=keyword]")) ){
			alert("검색 조건이 비어있어 검색할 수 없습니다.");
			$("[name=keyword]").val("");
			$("[name=keyword]").focus();
			return;
		}
		
		var keyword = $("[name=keyword]").val();
		keyword = $.trim(keyword);
		$("[name=keyword]").val(keyword);
		$.ajax({
				// 서버쪽 호출 URL 주소 지정
				url : "${requestScope.croot}/dictList_jpn.do"
				//, type : "get"
				, type : "post"
				, data : $("[name=searchKeyword]").serialize()	
				, success : function(html){

					$(".dictList").html(
							$(html).find(".dictList").html()
					);
					//document.searchKeyword.submit();
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

		if(str=="0"){
			 
			 alert("통합탭으로 키워드 갖고 이동~!");
			 	// 유효성 검사
				 if( isEmpty($("[name=searchKeyword] .keyword")) ){
						alert("검색 조건이 비어있어 검색할 수 없습니다.");
						$("[name=keyword]").val("");
						return;
					}
				
				// 키워드의 앞뒤 공백을 제거하기
				var keyword = $("[name=searchKeyword] .keyword").val();
				keyword = keyword.trim();
				$("[name=dictList] [name=keyword]").val(keyword);
				alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
				
				document.dictList.submit( );
				
		}else if(str=="1"){
				
				alert("한국어탭으로 키워드 갖고 이동~!");
			 	// 유효성 검사
				 if( isEmpty($("[name=searchKeyword] .keyword")) ){
						alert("검색 조건이 비어있어 검색할 수 없습니다.");
						$("[name=keyword]").val("");
						return;
					}
				
				// 키워드의 앞뒤 공백을 제거하기
				var keyword = $("[name=searchKeyword] .keyword").val();
				keyword = keyword.trim();
			 	$("[name=dictList_kor] [name=keyword]").val(keyword); 
				alert( "dictList 페이지에서 들어온 키워드=> "+ keyword ); 
				
				document.dictList_kor.submit( );
			
		}else if(str=="2"){

				 alert("영어탭으로 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=searchKeyword] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					 
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=searchKeyword] .keyword").val();
					keyword = keyword.trim();
					$("[name=dictList_eng] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword ); 
					
					document.dictList_eng.submit( );

		}else if(str=="3"){
				
				 alert("일본어으로 탭 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=searchKeyword] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=searchKeyword] .keyword").val();
					keyword = keyword.trim();
					 $("[name=dictList_jpn] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
					
					document.dictList_jpn.submit( );

		}else if(str=="4"){
	
				 alert("중국어으로 탭 키워드 갖고 이동~!");
				 	// 유효성 검사
					 if( isEmpty($("[name=searchKeyword] .keyword")) ){
							alert("검색 조건이 비어있어 검색할 수 없습니다.");
							$("[name=keyword]").val("");
							return;
						}
					
					// 키워드의 앞뒤 공백을 제거하기
					var keyword = $("[name=searchKeyword] .keyword").val();
					keyword = keyword.trim();
					$("[name=dictList_cn] [name=keyword]").val(keyword);
					alert( "dictList 페이지에서 들어온 키워드=> "+ keyword );
					
					document.dictList_cn.submit( );
		}
		
	}
	</script>
	
</head>
<body><center>
	<img class="bg" src="${pageContext.request.contextPath}/resources/img/mynote.png"/>
	<table>
		<tr>
			<td align="center">
			<!-- 입력양식 관리 폼테그 파트 -->
			<form name="searchKeyword" method="post" action="${requestScope.croot}/dictList_jpn.do">
		
				<input type="text" name="keyword" value="${param.keyword}" class="keyword"  placeholder="검색어를 넣어주세요" size="50">
				<input type="button" class="keywordSearch" value="  검색  " onClick="search();">		
			
				<!-- 상세조건 검색파트 -->
				<br><br>
				[검색어 총 개수]:
				<c:choose>
					<c:when test="${requestScope.tabDictListAllCnt_jpn==0}">
						<span>0</span>
					</c:when>
					<c:otherwise>
						<span>${requestScope.tabDictListAllCnt_jpn}</span>
					</c:otherwise>
				</c:choose>
		<tr>
			<td>	
				<!-- 언어탭 선택 파트  -->
				<table class="dicListTable2 tbcss2" border=1 bordercolor="lightblue" cellpadding=0 cellspacing=0>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('0');" ><b>통합검색</b></span>
						
						&nbsp;&nbsp;&nbsp;
					<td>&nbsp;&nbsp;&nbsp;
						<span style="cursor:pointer" onClick="goTabDictList('1');" ><b>한국어</b></span>
						
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
			</form>
			<!-- 검색어 흔적을 보내기 위한 히든 Form -->
			<form name="dictList" method="post" action="${requestScope.croot}/dictList.do"> 
				<!-- <input type="text" name="keyword">  -->   
				<input type="hidden" name="keyword">     
			</form>
			<form name="dictList_kor" method="post" action="${requestScope.croot}/dictList_kor.do"> 
				<!-- <input type="text" name="keyword">  -->   
				<input type="hidden" name="keyword">     
			</form>
			<form name="dictList_eng" method="post" action="${requestScope.croot}/dictList_eng.do"> 
				<!-- <input type="text" name="keyword">  -->   
				<input type="hidden" name="keyword">     
			</form>
			<form name="dictList_jpn" method="post" action="${requestScope.croot}/dictList_jpn.do"> 
				<!-- <input type="text" name="keyword">  -->   
				<input type="hidden" name="keyword">      
			</form>
			<form name="dictList_cn" method="post" action="${requestScope.croot}/dictList_cn.do"> 
				<!-- <input type="text" name="keyword">  -->   
				<input type="hidden" name="keyword">      
			</form>
		<tr>
			<td>
			<span class="dictList">
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
							<c:if test="${requestScope.tabDictList.size()>(requestScope.tabDictList.size()-1)}"> 
								<tr>		
									<td align=center colspan=8>
									<span style="cursor:pointer" onClick="goSomeWhere();">다른 작성자 글 더보기 Click!</span>
							</c:if>
						</table>
					</table>
					<br><br>
				</c:forEach>
			</span>
				
		<!-- 비동기 방식으로 가져온 데이터 보기위해 여기에 소스삽입 코드 -->
		<!-- <textarea cols=100 rows=500 name=xxx></textarea> -->
	</table>
			
		<!-- 만약에 검색 후, 게시판 결과가 없을 경우 없다고 출력하기 -->
		<c:if test="${empty requestScope.tabDictList_jpn}">
			<h4>"검색 조건에 맞는 데이터가 없습니다."</h4>
		</c:if>

</body>

</html>
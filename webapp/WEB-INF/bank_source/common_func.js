//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
//검색화면에서 검색 결과물의 페이징 번호 출력 소스 리턴
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getPagingNumber(
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str         // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력 페이지번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	//--------------------------------------------------------------
	// name=nowPage을 가진 hidden 태그없으면 경고하고 중지하는 자바스크립트 소스 생성해 저장
	//--------------------------------------------------------------
	if( $('[name=selectPageNo]').length==0 ){
		alert("name=selectPageNo 을 가진 hidden 태그가 있어야 getPagingNumber(~) 함수 호출이 가능함.');" );
		return;
	}
	var arr = [];
	try{
		if( totRowCnt==0 ){	return ""; }
		if( jsCodeAfterClick==null || jsCodeAfterClick.length==0){
			alert("getPagingNumber(~) 함수의 5번째 인자는 존재하는 함수명이 와야 합니다");
			return "";
		}
		//--------------------------------------------------------------
		// 페이징 처리 관련 데이터 얻기
		//--------------------------------------------------------------
		if( selectPageNo_str==null || selectPageNo_str.length==0 ) {
			selectPageNo_str="1";  // 선택한 현재 페이지 번호 저장
		}
		if( rowCntPerPage_str==null || rowCntPerPage_str.length==0 ) {
			rowCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		if( pageNoCntPerPage_str==null || pageNoCntPerPage_str.length==0 ) {
			pageNoCntPerPage_str="10";  // 선택한 현재 페이지 번호 저장
		}
		//---
		var selectPageNo = parseInt(selectPageNo_str, 10);
		var rowCntPerPage = parseInt(rowCntPerPage_str,10);
		var pageNoCntPerPage = parseInt(pageNoCntPerPage_str,10);
		if( rowCntPerPage<=0 || pageNoCntPerPage<=0 ) { return; }
		//--------------------------------------------------------------
		//최대 페이지 번호 얻기
		//--------------------------------------------------------------
		var maxPageNo=Math.ceil( totRowCnt/rowCntPerPage );
			if( maxPageNo<selectPageNo ) { selectPageNo = 1; }

		//--------------------------------------------------------------
		// 선택된 페이지번호에 따라 출력할 [시작 페이지 번호], [끝 페이지 번호] 얻기
		//--------------------------------------------------------------
		var startPageNo = Math.floor((selectPageNo-1)/pageNoCntPerPage)*pageNoCntPerPage+1;  // 시작 페이지 번호
		var endPageNo = startPageNo+pageNoCntPerPage-1;                                      // 끝 페이지 번호
			if( endPageNo>maxPageNo ) { endPageNo=maxPageNo; }
			/*//--------------------------------------------------------------
			// <참고>위 코딩은 아래 코딩으로 대체 가능
			//--------------------------------------------------------------
			var startPageNo = 1;
			var endPageNo = pageNoCntPerPage;
			while( true ){
				if( selectPageNo <= endPageNo ){ startPageNo = endPageNo - pageNoCntPerPage + 1; break; }
				endPageNo = endPageNo + pageNoCntPerPage;
			}*/

		//---
		var cursor = " style='cursor:pointer' ";
		//arr.push( "<table border=0 cellpadding=3 style='font-size:13'  align=center> <tr>" );
		//--------------------------------------------------------------
		// [처음] [이전] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=right width=110> " );
		if( startPageNo>pageNoCntPerPage ) {
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('1');"
							+jsCodeAfterClick+";\">[처음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
				+(startPageNo-1)+"');"+jsCodeAfterClick+";\">[이전]</span>   " );
		}
		//--------------------------------------------------------------
		// 페이지 번호 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=center>  " );
		for( var i=startPageNo ; i<=endPageNo; ++i ){
			if(i>maxPageNo) {break;}
			if(i==selectPageNo || maxPageNo==1 ) {
				arr.push( "<b>"+i +"</b> " );
			}else{
				arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
							+(i)+"');"+jsCodeAfterClick+";\">["+i+"]</span> " );
			}
		}
		//--------------------------------------------------------------
		// [다음] [마지막] 출력하는 자바스크립트 소스 생성해 저장
		//--------------------------------------------------------------
		//arr.push( "<td align=left width=110>  " );
		if( endPageNo<maxPageNo ) {
			arr.push( "   <span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(endPageNo+1)+"');"+jsCodeAfterClick+";\">[다음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(maxPageNo)+"');"+jsCodeAfterClick+";\">[마지막]</span>" );
		}
		//arr.push( "</table>" );
		return arr.join( "" );
	}catch(ex){
		alert("getPagingNumber(~) 메소드 호출 시 예외발생!");
		return "";
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function printPagingNumber(
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	totRowCnt               // 검색 결과 총 행 개수
	, selectPageNo_str         // 선택된 현재 페이지 번호
	, rowCntPerPage_str     // 페이지 당 출력행의 개수
	, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
	, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
) {
	document.write(
		getPagingNumber(
			totRowCnt               // 검색 결과 총 행 개수
			, selectPageNo_str         // 선택된 현재 페이지 번호
			, rowCntPerPage_str     // 페이지 당 출력행의 개수
			, pageNoCntPerPage_str  // 페이지 당 출력번호 개수
			, jsCodeAfterClick      // 페이지 번호 클릭후 실행할 자스 코드
		)
	);
}
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 테이블 색상 지정 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function setTableTrBgColor(
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
		tableClassV				// 테이블의 class속성값
		,headerColor			// tr태그 중 헤더부분 배경색
		,oddBgColor			// tr태그 중 홀수 tr 배경색
		,evenBgColor			// tr태그 중 짝수 tr 배경색
		,mouseOnBgColor		// tr태그 중 마우스 hover 배경색
){
		try{
			//----------------------------------------------------------
			// 헤더 tr태그를 관리하는 JQuery객체 생성하기
			//----------------------------------------------------------
			var firstTrObj = $("."+tableClassV+" tr:eq(0)"); 
			//----------------------------------------------------------
			// 메인 tr 중 tr태그를 관리하는 JQeury객체 생성하기
			//----------------------------------------------------------
			var trObjs = firstTrObj.siblings("tr");
			//----------------------------------------------------------
			// 첫째 tr, 짝수 tr, 홀수tr배경색 지정하기
			//----------------------------------------------------------
			firstTrObj.css("background",headerColor);
			trObjs.filter(":odd").css("background",evenBgColor);
			trObjs.filter(":even").css("background",oddBgColor);
			//----------------------------------------------------------
			// 메인tr태그에 마우스를 대거나 땔 때의 배경색 지정하기
			//----------------------------------------------------------
			
			trObjs.hover(
					function(){
						$(this).css("background", mouseOnBgColor);
					},
					function(){
						
						if( $(this).index()%2==0){
							$(this).css("background",evenBgColor);
						}else{
							$(this).css("background",oddBgColor);
						}
					}
			);
		}catch(e){
			alert("setTableTrBgColor(~) 함수호출 시 에러발생!");
		}
			
}
		

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식이 비어있거나 미체크시 true리턴하는 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function isEmpty( jqueryObj ){
	
	try{
		var flag = true;
		if(jqueryObj.is(":checkbox")|| jqueryObj.is(":radio") ){
			if(jqueryObj.filter(":checked").length>0){flag=false;}
		}
		else{
			var value = jqueryObj.val();
			if(value!=null && value.split(" ").join("")!=""){
				flag=false;				
			}
		}
		return flag;
	}catch(e){
		alert("isEmpty(~) 함수호출 시 에러발생!" + e.message);
		return false;
	}
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식이 비어있거나 미체크시 경고하고 true리턴하는 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	function checkEmpty( selector, alertMsg ){
		try{
			var jqueryObj = $(selector);
			if( isEmpty( jqueryObj) ){
				alert(alertMsg);
				if( jqueryObj.is(":checkbox")==false && jqueryObj.is(":radio")==false){
					jqueryObj.val("");
					jqueryObj.focus();
				}
				return true;
			}else{
				return false;
			}
		}catch(e){
			alert("checkEmpty(~,~) 함수호출 시 에러 발생" + e.message);
			return false;
		}
		
		
	}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식의 value값이 패턴에 맞지 않으면 경고하고 true리턴함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	function checkPattern( selector, regExpObj, alertMsg){
		try{
			var jqueryObj = $(selector);
			var value = jqueryObj.val();
			if(regExpObj.test(value)==false){
				alert(alertMsg);
				jqueryObj.val("");
				return true;
			}else{
				return false;
			}
		}catch(e){
			alert("checkPattern(~,~) 함수호출 시 에러발생!");
			return false;
		}
		
	}

	
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 각 셀의 앞뒤에 공백을 넣어주는 함수 선언	
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function inputBlank_to_tdth(table_selector, blankCnt){
	try{
		var blankStr="";
		for(var i=1; i<=blankCnt; i++){
			blankStr = blankStr + "&nbsp;";			
		}
				
		var tableObj = $(table_selector);
		
		tableObj.find("td,th").each(function(){
		var thTdObj = $(this);	
		
		thTdObj.html(
				blankStr + thTdObj.html() + blankStr
			);
		});
				
	}catch(e){
		alert("inputBlank_to_tdth(~,~) 함수호출 시 에러발생!")
		
	}
	
}


//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식의 value값을 삽입하거나 체크해주는 함수 선언
// 매개변수로 선택자가 들어온다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function inputData(
		selector 		//JQuery객체가 사용할 선택자 문자열
		, data			//위 선택자가 가리키는 입력양식에 삽입할 데이터, 또는 체크를 넣어줄 checkbox, radio입력양식의  value값 	
		){
	
	try{
		// data가 null 또는 undefined면 함수 중단
		if( data==null || data==undefined ) {return;}
		// 만약 길이가 없거나 공백으로만 구성되어 있으면 함수 중단
		if( (data+"").split(" ").join("")=="" ){return;}
		//----------------------------------------------------------------
		// selector가 가리키는 입력양식을 관리하는 JQuery객체 생성하기
		//----------------------------------------------------------------
		var obj = $(selector);
		//----------------------------------------------------------------
		// selector가 가리키는 입력양식이 없으면 경고하고 함수 중단하기
		//----------------------------------------------------------------
		if( obj.length==0 ){
			alert("inputData("+selector+", "+data+" ) 함수 호출 시 [" +selector+"]라는 선택자가 가리키는 입력양식이 없습니다.");
			return;
		}
		//----------------------------------------------------------------
		// 입력양식이 checkbox, radio일 경우 매개변수 data안의 데이터를 value값으로 가진 항목을 체크하기
		//----------------------------------------------------------------
		if(obj.is(":checkbox") || obj.is(":radio")){
			obj.filter("[value='"+data+"']").prop("checked" , true);
		}
		//----------------------------------------------------------------
		// 입력양식이 checkbox, radio가 아닐 경우 매개변수 data 안의 데이터를 입력양식의 value값으로 삽입하기
		//----------------------------------------------------------------	
		else{
			obj.val(data);
		}
	}catch(e){
		alert("inputData( '" +selector+"','" +data+ "') 함수 호출 시 에러발생!");
		
	}
	
}

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// checkbox 또는 radio의 체크 개수를 구하는 함수 선언
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getCheckedCnt( selector ){
	
	var jqueryObj = $(selector);
	if(jqueryObj.length==0){
		alert( "선택자 " +selector+ " 가 가리키는 입력양식이 존재하지 않습니다.");
		return 0;
	}
	
	return jqueryObj.filter(":checked").length;
	
}
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 입력양식의 value값을 리턴하는 함수
// 입력양식이 checkbox나 radio일 경우 체크된 항목의 value값만 얻는다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
function getValue(selector){
	var jqueryObj = $(selector);
	if( jqueryObj.length==0){
		alert("선택자 " +selector+ "가 가리키는 입력양식이 없습니다." );
		return "";
	}
	var result = "";
	if( jqueryObj.is(":checkbox") ){
		if( jqueryObj.filter(":checked").length>0){
			result=[];
			
			jqueryObj.filter(":checked").each(function(){
				result.push( $(this).val() );
				});			
		}
	}
	else if( jqueryObj.is(":radio") ){
		if( jqueryObj.is(":checked") ){
			result = jqueryObj.val();	
		}
		
	}
	else{
		if( isEmpty(jqueryObj)==false){
			result = jqueryObj.val();			
		}
		
	}
	return result;
}


function insertYMD_to_select3(

		
		yearObj 	//연도관련 select태그를 관리하는 JQuery객체
		,monthObj	//월 관련 select태그를 관리하는 JQuery객체
		,dateObj	//일 관련 select태그를 관리하는 JQuery객체

		,min_year	//입력할 연도의 최소값
		,max_year	//입력할 연도의 최대값
		,year_asc_or_desc //연도의 오름차순 또는 내림차순 옵션, 1이면 내림차순, 입력되지 않거나 1이 아니면 오름차순
	){
	
	try{
	//----------------------------------------------
	// 매개변수 year_asc_or_desc가 undefined(매개변수가 입력되지 않음)이면,  year_asc_or_desc값을 1로 설정하기
	//-----------------------------------------------
	//if(year_asc_or_desc==undefined){year_asc_or_desc == 1;}
	
	//----------------------------------------------
	// 반복문을 사용하여 class=birth_year를 가진 태그 내부에 option태그를 막내 태그로 삽입하기
	// 연도표기관련 option태그를 막내아들로 삽입하기
	//-----------------------------------------------
	if(year_asc_or_desc==1){
		for(var i=max_year; i>=min_year; i--){
			yearObj.prepend("<option value='"+i+"'>"+i+"</option>");
			}
		}
		else{
		for(var i=min_year; i<=max_year; i++){
			yearObj.append("<option value='"+i+"'>"+i+"</option>");
			}	
		}
	//----------------------------------------------
	// 반복문을 사용하여 class=birth_month를 가진 태그 내부에 option태그를 막내 태그로 삽입하기
	// 월 표기관련 option태그를 막내아들로 삽입하기
	//-----------------------------------------------
	for( var i=1; i<=12; i++){
		if(i<10)
			monthObj.append("<option value='0"+i+"'>0"+i+"</option>");
		else{																
			monthObj.append("<option value='"+i+"'>"+i+"</option>");
				}
			}
	//----------------------------------------------
	// 반복문을 사용하여 class=birth_year를 가진 태그 내부에 option태그를 막내 태그로 삽입하기
	// 일 표기관련 option태그를 막내아들로 삽입하기
	//-----------------------------------------------	
	for(var i=1; i<=31; i++){
		if(i<10){
			dateObj.append("<option value=0'"+i+"'>0"+i+"</option>"); }
		else{
			dateObj.append("<option value='"+i+"'>"+i+"</option>");
			}

		}
	  }
	  catch(ex){
		alert("insertYMD_to_select3 함수의 매개변수로 '연도,월,일 select태그를 관리하는 각 JQuery객체의 메위주',\n"
			+"최소연도, 최대연도 (,오름/내림차순옵션)을 순서대로 입력해 주십시오." + ex.message);
					
	  }
	}
	


	//*************************************************
	//*************************************************
	//*************************************************
	function insertValidDate(
		yearObj		// 연도 관련 select태그를 관리하는 JQuery객체
		,monthObj		// 월 관련 select태그를 관리하는 JQuery객체
		,dateObj		// 일 관련 select태그를 관리하는 JQuery객체
	){
		try{	
		//-----------------------------------------------------------------
		// 연도관련 태그를 관리하는 JQuery객체의 val메소드 호출로
		// 연도관련 태그의 value값 얻기 = 선택한 연도 얻기
		//-----------------------------------------------------------------
		var birth_year = yearObj.val();
		//-----------------------------------------------------------------
		// 월관련 태그를 관리하는 JQuery객체의 val메소드 호출로
		// 월 관련 태그의 value값 얻기 = 선택한 월 얻기
		//-----------------------------------------------------------------
		var birth_month = monthObj.val();
		//-----------------------------------------------------------------
		// 일 관련 태그를 관리하는 JQuery객체의 val메소드 호출로
		// 일 관련 태그의 value값 얻기 = 선택한 일 얻기
		//-----------------------------------------------------------------
		var birth_date = dateObj.val();
		 
		//-----------------------------------------------------------------
		// 연도와 월 데이터가 입력되어 있으면
		//----------------------------------------------------------------- 
		if( birth_year!="" && birth_month!="" ){
			//연도와 월에 해당하는 마지막 날짜를 관리하는 Date객체를 생성하고 선택 연월의 마지막 일 수를 얻기
			var last_date = new Date(
				parseInt(birth_year,10)
				,parseInt(birth_month,10)
				,0
				).getDate();
		//-----------------------------------------------------------------
		// 일을 표현하는 태그를 JQuery객체의 empty메소드를 호출하여
		// 일을 표현하는 태그의 내부를 비우기 = 일을 표현하는 태그의 내부 option태그를 모두 없애기
		//-----------------------------------------------------------------
		dateObj.empty();
		//-----------------------------------------------------------------
		// 일을 표현하는 태그를 JQuery객체의 append메소드를 호출하여
		// 일을 표현하는 태그의 내부에 1~마지막 일 수까지 표현하기
		//-----------------------------------------------------------------
		dateObj.append("<option value=''>--선택--</option>");
		for( var i=1; i<=last_date ; i++){
		if(i<10){
			dateObj.append("<option value=0" +i+ ">0" +i+ "</option>");		
			}
			else{
			dateObj.append("<option value=" +i+ ">" +i+ "</option>");
			}
		}	
			//-----------------------------------------------------------------
			// 선택한 일 셀렉트가 비어있지 않을 경우
			//-----------------------------------------------------------------
			if( birth_date!="" ) {
				//일을 표현하는 태그를 JQuery객체의 val메소드를 호출하여 원래 선택한 일 데이터로 다시 선택하게 하기
				dateObj.val(birth_date);	
			}
		}
	}catch(ex){
		alert( "insertValidDate 함수 호출 시 예외발생! 흑흑흑");

		}
	}


	function insertComma(
		obj		// 숫자와 콤마(,) 어울려 삽입될 입력양식을 관리하는 JQuery객체의 메위주
	){
	
			//-----------------------------------------------------
			// keyUp이벤트가 발생한 입력양식의 value값, 즉 유저가 입력한 데이터를
			// 자바스크립트 영역으로 가져와 money변수에 저장
			//-----------------------------------------------------
			var money = obj.val();
			//-----------------------------------------------------
			// 숫자만 골라서 저장할 변수 선언
			//-----------------------------------------------------
			var num = "";
			//-----------------------------------------------------
			// money 변수 안의 데이터를 숫자만 골라 num변수에 누적
			//-----------------------------------------------------
			for(var i=0; i<money.length; i++){
				//money 안의 문자데이터를 i번째 데이터가 숫자문자면 num변수에 축적하기
				if( ("01234567890").indexOf(money[i] )>=0 ){
					num = num + money[i];
					}
				if(num.charAt(0)=="0"){
					num = num.replace('0',"");
			// num = parseInt(num,10);
				} 
			}
				//---------------------------------------------------
				// num 변수 안의 문자열의 데이터의 맨 앞이 0이면 0을 제거하는 반복문 선언
				// 단, 0 하나만의 데이터일 경우에는 없애지 않는다.
				//---------------------------------------------------
				//***********(위 반복문은 아래 코딩으로도 대체 가능)*********
				//while( charAt(0)==0 && num.length>1 ){ num =num.substring(1); }
				//if( num.length>=1 ){ num = parseInt(num,10) + "" );

				//---------------------------------------------------
				// 콤마를 포함한 최종 문자열을 저장할 변수 result 선언
				//---------------------------------------------------
				var result="";
				var cnt=0;
				
				for( var i=num.length-1 ; i>=0; i--){
				cnt++;
					if(cnt%3==1 && cnt>1){ result = "," + result; }
					result = num.charAt(i) + result;
					}
		
		obj.val(result);
			
	}

	
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
// 두 개로 나뉘어진 주민등록번호 7자리의 유효성 검사흘 실행하는 함수 선언	
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++	
	/*function is_valid_jumin_num(jumin_num1, jumin_num2){
		
		if(jumin_num2==undefined){
			jumin_num2="";}

		var jumin_num = jumin_num1 + jumin_num2;

		if(checkPattern(jumin_num, /^[0-9]{7}$/, "주민번호 7자리를 바르게 입력하여 주십시오")==false){
			return false;}
		
		var gender = jumin_num.substr(6,1);
		var year = jumin_num.substr(0,2);
		if(gender=="1" || gender=="2"){
			year = "19" + year;
			}
			else if(gender=="3" || gender=="4"){
				year = "20" + year;
				}
				else{
				alert("주민등록번호 7번째 자리에는 1에서 4까지만 입력 가능합니다.");
				return;
				}
		var month = jumin_num.substr(2,2);
		var date = jumin_num.substr(4,2);
		
		if( is_future(year,month,date) ){
			alert("아직 존재하지 않는 주민번호입니다. 입력을 확인해 주십시오.");
			return false;
		}	
		if( is_valid_YMD(year,month,date) == false){
			alert("합당한 주민번호가 존재하지 않습니다.");
			return false;
		}
	return;
		}*/
//================================================================================================================


	function is_valid_jumin_num( jqueryObj ){

		//if(jumin_num2==undefined){
		//	jumin_num2="";}

		//var jumin_num = jumin_num1.concat(jumin_num2);
		if(checkPattern( jqueryObj, /^[0-9]{6}-[1-4]{1}$/, "주민번호 7자리를 바르게 입력하여 주십시오")==false){
			return false;}

		var gender = jumin_num.substr(7,1);
		var year = jumin_num.substr(0,2);
		if(gender=="1" || gender=="2"){
			year = "19" + year;
			}
			else if(gender=="3" || gender=="4"){
				year = "20" + year;
				}
				else{
				alert("주민등록번호 7번째 자리에는 1에서 4까지만 입력 가능합니다.");
				return false;
				}
		var month = jumin_num.substr(2,2);
		var date = jumin_num.substr(4,2);
	
		alert("year : " + year + "month : " + month + "date : " + date + "gender : " + gender);	
		
		if( is_future(year, month, date)==true ){
			alert("아직 존재하지 않는 주민번호입니다. 입력을 확인해 주십시오.");
			return false;
		}		
		if( is_valid_YMD(year,month,date)==false){
			alert("합당한 주민번호가 존재하지 않습니다.");
			return false;
		}	
			return true;
		}

	
	
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// 선택된 연월일이 미래의 날짜인지를 판별하는 함수 is_future 선언
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

	function is_future(year, month, date) {
		try{	
			// 현재 시스템 날짜를 관리하는 Date객체 생성하기	
			var today = new Date();
			// 매개변수로 들어온 년월일을 관리하는 Date객체 생성하기
			var xxday = new Date(
			parseInt(year,10)
			, parseInt(month,10)-1
			, parseInt(date,10)
			);
			
			//매개변수로 들어온 년월일이 현재 시스템 날짜의 년월일보다 크면 true 리턴
			if(xxday.getTime()>today.getTime()){
				return true;
				}
			//그 외의 경우 false리턴하기
			else{
				return false;
				}
		}catch(ex){
			alert("예외발생! " + ex.message + ", 매개변수 년,월,일이 이 정확히 들어와야 합니다." );
			alert("예외발생! " + year + " " + month + " " + date );
		}

	}


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	function ajax(
			url_addr		// 서버접속 url
			,formName		// 서버로 전송할 파라미터값을 내포한 form태그 name값
			,callback_func	// 서버의 응답이 왔을 때 실행할 익명함수 선언
			){
		try{
			//--------------------------------------------------------
			// form태그를 관리하는 JQuery객체 생성하기
			//--------------------------------------------------------
			var formObj = $("[name="+formName+"]");
			//--------------------------------------------------------
			if(formObj.length==0){
				alert("ajax함수호출 시 2번째 인자에 입력되는 "+formName+"라는 form태그가 없습니다.");
				return;
			}
			//--------------------------------------------------------
			// form태그 안에 파일업로드 입력양식의 존재여부 얻기
			//--------------------------------------------------------
			var isFile = formObj.find("[type='file']").length>0;
			//--------------------------------------------------------
			// JQuery객체의 ajax메소드 호출로 비동기방식으로 서버에 접속하기
			//--------------------------------------------------------
			alert( isFile );
			$.ajax({
				//--------------------------------------------------------
				// 호출할 서버쪽 URL주소 성정
				//--------------------------------------------------------
				url : url_addr
				//--------------------------------------------------------
				// 전송방법 설정
				//--------------------------------------------------------
				,type : "post"
			    //--------------------------------------------------------
				//전송하는 파라미터명, 파라미터값을 "파일명=파일값&~"형태의 문자열로 변경할지 여부 성정하기
				//form태그 안에 파일업로드 입력양식이 있으며9ㄴ false, 없으면 true로 설정한다.
				//서버로 보내는 데이터에 파일이 있으면 문자열로 변경하지 않고 FormDAta객체 그대로 보내야한다.
			    //--------------------------------------------------------
				,processData : isFile?false:true 
				//--------------------------------------------------------	
				// "content-type"라는 헤더명의 헤더값 설정하기
				// contentType:true 면 헤더값으로 "application/x-www-form-urlencoded"가 설정된다.
				// contentType:false면 헤더값으로 "multipart/form-data"가 설정된다.
				// 파일이 존재하므로, "multipart/form-data"로 설정한다.
				//--------------------------------------------------------
				,contentType : isFile?false:true
				//--------------------------------------------------------
				// 서버로 보내는 데이터 설정하기
				// form태그 안에 파일업로드 입력양식이 있으면 new FormData객체를 설정하고
				// 없으면 data: "파일명-파일값&~" 형태 또는 data: {"파일명":파일값, ~} 또는 data: $("[name=폼이름]").serialize()로 설정한다.
				//--------------------------------------------------------
				,data : isFile?(	new FormData(formObj.get(0))	):(formObj.serialize())
				//--------------------------------------------------------
				// 서버의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정
				//--------------------------------------------------------
				,success : callback_func
				//--------------------------------------------------------
				// 서버의 응답을 받지 못했을경우 실행할 익명함수 설정
				//--------------------------------------------------------
				,error : function(){
					alert( url_addr + " 접속시 서버응답 실패! 관리자에게 문의바람!" );
				}
			});			
			
			}catch(e){
				alert("ajax함수 호출 시 에러발생!" + e.message);
			}
		}
	
	
							
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// select 입력양식의 option값에 배열에 포함된 문자열 옵션을 차례대로 삽입하는 함수 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	function insertArr_to_select(
		selectObj 	//문자열 삽입대상이 되는 select태그를 관리하는 JQuery객체
		,arr		//삽입할 문자열이 포함된 배열객체
	){
	try{
		
	for(var i=0; i<arr.length; i++){
			var str = arr[i];
			selectObj.append("<option value='"+(i+1)+"'>"+str+"</option>");
			}
		}
	  catch(ex){
		alert("문자열이 포함된 배열객체를 매개변수로 select태그에 삽입해 주십시오" + ex.message);
					
	  }
	}	
	
	
	
	
	
	
	













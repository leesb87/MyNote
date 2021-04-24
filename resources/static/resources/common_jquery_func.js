//***********************************************
//월년
//***********************************************
function insertYMD_to_select3(
		    yearObj        //년도 관련 select 태그를 관리하는 JQuery 객체
		    ,monthObj      //월 관련 select 태그를 관리하는 JQuery 객체
			,dateObj       //일 관련 select 태그를 관리하는 JQuery 객체		  
		    ,min_year      //최소 년도 
            ,max_year      //최대 년도 
		    ,year_asc_or_desc  //년도의 오름차순 또는 내림차순 옵션. 1이면오름차순 2이면 내림차순
		){		
		  try{
			  //-----------------------------------------------------
			  // 매개변수 year_asc_or_desc 가 undefined 이면 = 즉 매개변수 year_asc_or_desc 로 데이터가 
			  // 안들어오면 
			  //-----------------------------------------------------
			  if(year_asc_or_desc==undefined){ //undefined = 알수없는 데이터
				 year_asc_or_desc=1;
			  }
			  //-------------------------------------------------------------------
			  // 년도 관련 select 태그를 관리하는 JQuery 객체의 append 메소드를 호출하여
			  // 년도 관련 select 태그 내부에 <option value="년도숫자">"년도숫자"</option> 태그 삽입하기
			  //-------------------------------------------------------------------
			  for(var i=min_year; i<=max_year ; i++){				       
					   if(year_asc_or_desc==1 ){
						  yearObj.append("<option value="+i+">"+i+"</option>"); 
					   }
					   if(year_asc_or_desc==2){ 
						  yearObj.prepend("<option value="+i+">"+i+"</option>");	
					   }
			  }
			  //-------------------------------------------------------------------
			  // 월 관련 select 태그를 관리하는 JQuery 객체의 append 메소드를 호출하여
			  // 월 관련 select 태그 내부에 <option value="월숫자">"월숫자"</option> 태그 삽입하기
			  //------------------------------------------------------------------- 
			   for(var i=1 ; i<=12 ; i++){	
						if(i<10){
							monthObj.append("<option value=0"+i+">0"+i+"</option>");		        			 
						}		     
						else{
							monthObj.append("<option value="+i+">"+i+"</option>");
						}
			   }
			   //-------------------------------------------------------------------
			   // 일 관련 select 태그를 관리하는 JQuery 객체의 append 메소드를 호출하여
			   // 일 관련 select 태그 내부에 <option value="일숫자">"일숫자"</option> 태그 삽입하기
			   //-------------------------------------------------------------------	
				for(var i=1; i<=31 ; i++){	
						if(i<10){				  
						  dateObj.append("<option value=0"+i+">0"+i+"</option>");		        			 
						}
						else{
						  dateObj.append("<option value="+i+">"+i+"</option>");
						}
			  
			}
		  }catch(ex){
		       alert("insertYMD_to_select3 함수 호출시 예외발생! 흑흑흑!" + ex.message)
	      }
		}
  

	 //***********************************************
	 //월년도 
	 //***********************************************
        function insertvalidDate(
		    yearObj        //년도 관련 select 태그를 관리하는 JQuery 객체
		    ,monthObj      //월 관련 select 태그를 관리하는 JQuery 객체
			,dateObj       //일 관련 select 태그를 관리하는 JQuery 객체	
						
		){
           try{
				 //-------------------------------------------------------------
				 // 년도 관련 태그를 관리하는 JQuery 객체의 val 메소드 호출로
				 // 년도 관련 태그의 value값 얻기= 선택한 년도 얻기
				 //-------------------------------------------------------------
				 var birth_year  = yearObj.val();   // val은 숫자문자
				 //-------------------------------------------------------------
				 // 월 관련 태그를 관리하는 JQuery 객체의 val 메소드 호출로
				 // 월 관련 태그의 value값 얻기= 선택한 월 얻기
				 //-------------------------------------------------------------
				 var birth_month = monthObj.val(); 
                 //-------------------------------------------------------------
				 // 일 관련 태그를 관리하는 JQuery 객체의 val 메소드 호출로
				 // 일 관련 태그의 value값 얻기= 선택한 일 얻기
				 //-------------------------------------------------------------
				 var birth_date  = dateObj.val(); 
		         //-------------------------------------------------------------
                 // 년과 월이 있으면 = 즉 년과 월이 선택되어있으면  
                 //-------------------------------------------------------------
				 if( birth_year !="" && birth_month !=""){
				    // 년과 월의 해당하는 마지막 날짜를 관리하는 Date 객체를 생성하고
					// 일을 구하기 = 년, 월의 마지막 일을 구하기
					var last_date =new Date(
						 parseInt(birth_year,10)
						 ,parseInt(birth_month,10)
						 ,0
					).getDate();
						// alert( last_date);				    
					//-------------------------------------------------------------
                    // 일을 표현하는 태그를 JQuery 객체의 empty 메소드를 호출하여
					// 일을 표현한는 태그의 내부를 비우기 = 일을 표현하는 태그의 내부의 option 태그 없애기
                    //-------------------------------------------------------------
					dateObj.empty();
				    //-------------------------------------------------------------
                    // 일을 표현하는 태그를 JQuery 객체의 append 메소드를 호출하여
					// 일을 표현한는 태그의 내부에 <option value=''></option> 를 막내 아들로 삽입하기
                    //-------------------------------------------------------------
					dateObj.append("<option value=''></option>");
					//-------------------------------------------------------------
                    // 일을 표현하는 태그를 JQuery 객체의 append 메소드를 호출하여
					// 일을 표현한는 태그의 내부에 1~마지막일수 까지 
					// <option value='일수'>일수</option> 를  삽입하기
                    //-------------------------------------------------------------
					for(var i=1 ; i<=last_date ; i++ ){
                       dateObj.append("<option value="+i+">"+i+"</option>");
					}
				    //---------------------------------
					// 만약에 선택한 일이 비어있지 않으면
					//---------------------------------
					if(birth_date!=""){
					   // 일을 표현하는 태그를 JQuery 객체의 val 메소드를 호출하여 원래
					   // 선택한 일을 다시 선택하게 하기
					   dateObj.val(birth_date);
					}
				 }				 
		  }catch(ex){
		       alert("insertvalidDate 함수 호출시 예외발생! 흑흑흑!" + ex.message)
	      }
		}



//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

   function insertComma( 
	       obj  // 숫자와 콤마(,) 가 어울려 삽입될 입력양식을 관리하는 JQuery 객체의 메위주 
	   ){
               //--------------------------------------------
			   // keyup 이벤트가 발생한 입력 양식의 value 값, 즉 유저가 입력한 데이터를
			   // 자바스크립트 영역으로 가져와 money 변수에 저장.
			   //-------------------------------------------
		      var money = obj.val();
			  //--------------------------------------------
	          // 숫자만 골라서 저장할 변수 선언
	          //-------------------------------------------
			  var num ="";
			  //--------------------------------------------
	          // money 변수 안의 데이터 중 숫자만 골라 num 변수에 누적시킴
	          //-------------------------------------------
			  
			  for(var i=0 ; i<money.length ; i++){
			      //money 안의 문자 데이터중 i번째 데이터가 숫자문자면 num 변수에 축적하기
				  // charAt(인덱스번호) 인덱스번호 위치하는 문자를  리턴. 인덱스번호는 0부터 시작한다. 
				  var i_str = money.charAt(i)
				  if( ("0123456789").indexOf(i_str)>=0){				        
				         num = num + i_str;
				  }
			  } 
			  //------------------------------------
			  // num 변수 안의 맨 앞이 데이터가 0이면 0을 제거.
			  // 단 0하나만 있을 경우 없애지 않는다.
			  //------------------------------------
			  while(num.charAt(0)=="0" && num.length>1){
			       num=num.substring(1);     
			   // if(num=="00"){num.val("");} 
			  }
			 		  
			 //-------------------------------------
			 //위 반복문은 아래 코딩으로 대체 가능하다.
			 //-------------------------------------
			 /*
			   while(num.charAt(0)=="0"){
			       num=num.replace("0","");     
			  }          			
			 
			  if( num.length>=1){
			      num = parseInt(num,10)+"";
			    if(num=="0"){num="";}
			  }
			 */
			  //----------------------------------
			  // 콤마를 포함한 최종 문자열을 저장할 변수 선언
			  //----------------------------------
			  var result = "";
			  //------------------------------------
			  // num 에서 맨 뒤에서 부터 하나씩 낚아채서 result 변수 누적 시킴.
			  // 이때 3의 배수 만큼 낚아챌 때 콤마(,)를 앞에 넣어 누적 시킴.
			  //------------------------------------
			 
				var cnt = 0;
			  for(var i=num.length-1 ; i>=0 ; i--){
			    cnt++;
				 if (cnt%3==0){	 
				     result = "," + num.charAt(i) + result;
			     }else{ 
			         result = num.charAt(i) + result;
			     }			   			    
			  }
			   //-------------------------------------------
			   //맨 앞이 콤마(,)로 시작하면 그 이후 문자를 낚아채 result 에 재 저장
			   //-------------------------------------------
			   if(result.charAt(0)==","){  //0인덱스 번호에 , 가 들어오면
                    result=result.substring(1);    //인덱스 1번호부터 끝까지 낚아챈다.
					}
			  //-------------------------------------------
			  // keyup 이벤트가 발생한 입력 양식의 value 값에 result 변수안의 값을 덮어쓰기
			  // 입력 양식의 value 값에 데이터를 갱신하면 웹브라우저 화면의 입력값도 변화된다.
			  //-------------------------------------------
			  obj.val(result);
	   }
         

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm 
// 홀  짝 행의 배경색 바꾸기
//---------------------------------------------------	  
	  
	  function inputBgColor_to_tr(
				   trsObj          // 화면에 보이거나 안보이게 할 모든 tr 태그를 관리하는 JQuery 객채의 메위주
				   , oddBgColor      // 홀수 번째 tr태그의 배경색. 인간기준   // 프로그램상 짝수 인덱스 번호 넣어야함
				   , evenColor     // 짝수 번째 tr태그의 배경색.  인간기준  // 프로그램상 홀수 인덱스 번호 넣어야함
		   ){    

				 // tr 태그 중 화면에 보이는 tr 중 홀수 tr 만 골라서 배경색을 주기
				 trsObj.filter(":visible").filter(":even").css( "background-color",oddBgColor);	//사람기준 홀수임 // visble : 화면에 보이는 것만 보이게 하는 선택자	   
				 // tr 태그 중 화면에 보이는 tr 중 짝수 tr 만 골라서 배경색을 주기
				 trsObj.filter(":visible").filter(":odd").css( "background-color",evenColor);    //사람기준 짝수임 // visble : 화면에 보이는 것만 보이게 하는 선택자	                                                                                
		   }
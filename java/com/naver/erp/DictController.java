package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.Parameters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// 가상 URL 주소로 접속하며 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언  
// @Controller 를 붙임으로써 [컨트롤러 클래스]임을 지정한다.
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
@Controller
public class DictController {
	
		DictSearchDTO dictSearchDTO = new DictSearchDTO(); 
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 속성변수 boardService 선언하고 [BoardService 인터페이스]를 구현받은 클래스를 찾아 객체 생성해 저장.
	// 관용적으로 [BoardService 인터페이스]를 구현받은 클래스명은 BoardServiceImpl 이다.
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// @Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	// [인터페이스]를 구현한 [클래스]가 1개가 아니면 에러가 발생한다.
	// 단 @Autowired( required=false ) 로 선언하면 0개 이어도 에러없이 null 이 저장된다.
	// Spring 에서만 지원하는 어노테이션이다.
	
	 @Autowired private DictService dictService;

	 
//===<myNoteForm>==========================================================================================
 	 
		 @RequestMapping( value="/mynote.do")
			
			public ModelAndView getMyNote( 
					@RequestParam(value= "ex_keyword",  required=false ,  defaultValue="") String ex_keyword		// dictList에서 이동할 경우 필요
					,DictSearchDTO dictSearchDTO
					,HttpSession session 
			) {
			 	String user_id = (String)session.getAttribute("user_id");
			 	System.out.println( "user_id : " + user_id);
			 	dictSearchDTO.setUser_id(user_id);
			 	System.out.println( "user_id2 : " + dictSearchDTO.getUser_id());
			 	//*******************************************				
				//  user_id를 사용하여, 해당 id값으로 저장된 MYNOTE들 가져오기/////여기할차례!
			 	//*******************************************
			 	List<Map<String,String>> mynoteList = this.dictService.getMynote(dictSearchDTO );
			 	//List<Map<String,String>> mynoteList  = null;
					 
				//  마이노트 목록 총 개수 가져오기
				int mynote_cnt = this.dictService.getMynoteCnt( dictSearchDTO );
				
				// [선택된 페이지 번호] 보정하기
				if( mynote_cnt>0 ){
				
					int beginRowNo= dictSearchDTO.getSelectPageNo( )*dictSearchDTO.getRowCntPerPage( )
									- dictSearchDTO.getRowCntPerPage( )+1;
					System.out.println(1+dictSearchDTO.getSelectPageNo( ) +"/"+ dictSearchDTO.getRowCntPerPage( )+1);
					// [시작행번호] > [총검색 개수] 일 경우 
					// [선택된 페이지 번호]를 1로하고 검색 행의 [시작행 번호]를 1로하기
					if(mynote_cnt<beginRowNo) {
							dictSearchDTO.setSelectPageNo(1);
					}
				}
				
				ModelAndView mav = new ModelAndView();
				
				mav.setViewName("/dictMynote.jsp");
				//mav.setViewName("/loginForm.jsp");
				mav.addObject("mynoteList", mynoteList);
				mav.addObject("ex_keyword", ex_keyword);
				mav.addObject("mynote_cnt", mynote_cnt );
				mav.addObject("DictSearchDTO", dictSearchDTO);
				
				return mav;	
			}
		 
		 
		 @RequestMapping(value = "/insertMynote.do")
		 		
		 		@ResponseBody
				public int insertMynote(
					@RequestParam(value="user_id", required = false, defaultValue = "") String user_id
					,@RequestParam(value="lang_code") String lang_code
					,@RequestParam(value="dict_no") String dict_no
					,@RequestParam(value="turnOff", required = false, defaultValue = "") String turnOff	//mynote의 등록을 해지할지의 여부인  turnOff를 확인
					,HttpSession session
						){
			 System.out.println( dict_no +"/"+ lang_code +"/" + user_id +"/"+turnOff);
			 
			 Map<String,String> map = new HashMap<String,String>();
			 user_id = (String)session.getAttribute("user_id");
			 map.put("user_id",user_id);
			 map.put("lang_code",lang_code);
			 map.put("dict_no",dict_no);
			 
			 int turnOffCnt = 0;
			 if( turnOff.equals("turnOff")==true ) {	//turnOff변수에 데이터가 저장된 상태로 Controller에 진입하고
				 										//그 값이 turnOff일 경우 해당 꼬리글의 계정 mynote값을 0으로 업데이트하도록 지시
				 turnOffCnt = this.dictService.turnOffMynote(map);
				 	if(turnOffCnt==0) {return -2;}			//수정행 개수가 0이면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기
				 	else if(turnOffCnt==1) {return 2;}		//수정행 개수가 1이면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기
				 	else { return -3;}						//수정행 개수가 0도 1도 아니면 JSP페이지로 반환하고 해당하는 메시지 출력하도록 하기
				 }
			 		 
			 
			 int insertMynoteCnt = this.dictService.insertMynote(map);
			 
			 System.out.println( "insertMynoteCnt => "+ insertMynoteCnt);
			 
			 return insertMynoteCnt;
		 }
		 
//===<dictList>==========================================================================================	 
	 
	 		//*************************************************
			// 통합사전 게시판으로 진입시 호출되는 메소드
			@RequestMapping( value="/dictList.do")
			
			public ModelAndView getDictList( 

					DictSearchDTO dictSearchDTO 
					//,@RequestParam(value="ex_keyword") String ex_keyword
					,HttpSession session
					
			) {
				
					System.out.println("DictListController .getDictList메소드 진입 ");
					//  통합검색  게시판 목록 총 개수 가져오기
					int dictListAllCnt_total = this.dictService.getDictListAllCnt_total( dictSearchDTO );
					System.out.println(dictListAllCnt_total);
					//  통합검색 n행 n열 게시판 목록 가져오기
					List<Map<String,String>> dictList_total = this.dictService.getDictList_total( dictSearchDTO );
                    
					
					if( session.getAttribute("dictSearchDTO")!=null) {
						
						session.removeAttribute("dictSearchDTO");
					}
					//dictSearchDTO.setKeyword(ex_keyword);
					session.setAttribute("dictSearchDTO",dictSearchDTO);
					
					
					// [선택된 페이지 번호] 보정하기
					if( dictListAllCnt_total>0 ){
						
						int beginRowNo = dictSearchDTO.getSelectPageNo()*dictSearchDTO.getRowCntPerPage()- dictSearchDTO.getRowCntPerPage()+1;
						//System.out.println(1+dictSearchDTO.getSelectPageNo( ) +"/"+ dictSearchDTO.getRowCntPerPage( )+1);
						// [시작행번호] > [총검색 개수] 일 경우 
						// [선택된 페이지 번호]를 1로하고 검색 행의 [시작행 번호]를 1로하기
						if(dictListAllCnt_total<beginRowNo) {
							dictSearchDTO.setSelectPageNo(1);
						}
					}
			/*		
					System.out.println("acc_read =>" + session.getAttribute("acc_read") );
					String acc_read = "";
					Object obj = session.getAttribute("acc_read");
					acc_read = (String)obj;
					
					System.out.println("acc_read =>" + session.getAttribute("acc_read") + "acc_r2 : " + (acc_read+1) + "OBJ? : " + obj ) ;
	        */	
					ModelAndView mav = new ModelAndView();
					
					mav.setViewName("/dictList.jsp");
			/*		
					
					if(acc_read=="0") { mav.setViewName("/frontPage.jsp"); }
					else { mav.setViewName("/dictList.jsp"); }
		   */		
					mav.addObject("dictList_total", dictList_total);
					mav.addObject("dictListAllCnt_total", dictListAllCnt_total );
					
					System.out.println("keyword(C) : " + dictSearchDTO.getKeyword() );
					System.out.println("lang_code(C) : " + dictSearchDTO.getLang_code() );
					System.out.println("RowCntPerPage(C) : " + dictSearchDTO.getRowCntPerPage() );
					System.out.println("selectPageNo(C) : " + dictSearchDTO.getSelectPageNo() );
					//mav.addObject("DictSearchDTO", dictSearchDTO);
					
					/*
					mav.addObject("dictList_kor", dictList_kor);
					mav.addObject("dictListAllCnt_kor", dictListAllCnt_kor ); 
					
					mav.addObject("dictList_eng", dictList_eng);
					mav.addObject("dictListAllCnt_eng", dictListAllCnt_eng );
					
					mav.addObject("dictList_jpn", dictList_jpn);
					mav.addObject("dictListAllCnt_jpn", dictListAllCnt_jpn );
					
					mav.addObject("dictList_cn", dictList_cn);
					mav.addObject("dictListAllCnt_cn", dictListAllCnt_cn );
					*/
					
					System.out.println("검색 결과 행의 개수 확인=> "+dictList_total.size());
					/*
					System.out.println("한국어 검색 사전행의 개수 확인=> "+dictList_kor.size());
					System.out.println(" 영어  검색 사전행의 개수 확인=> "+dictList_eng.size());
					System.out.println("일본어 검색 사전행의 개수 확인=> "+dictList_jpn.size());
					System.out.println("중국어 검색 사전행의 개수 확인=> "+dictList_cn.size());
					*/
					
					return mav;
				
			}
			
			//*************************************************
			// ContentForm 접속시 호출되는 메소드
			@RequestMapping( value="/dictContentForm.do")
			
			public ModelAndView getDictContent( 
					@RequestParam(value= "ex_keyword") String ex_keyword
					,@RequestParam(value = "note_no", required = false, defaultValue = "0") int note_no	
					,DictSearchDTO dictSearchDTO 
					,HttpSession session 
			) {
			
				//  통합검색 n행 n열 게시판 목록 가져오기
				List<Map<String,String>> dictList_content = this.dictService.getDictContent( dictSearchDTO );
				
				//*******************************************
				// [DictServiceImpl 객체]의 getDictDTO 메소드 호출로 [1개의 게시판 글]을 DictDTO 객체에 담아오기
				//*******************************************
				//DictDTO dictDTO = this.dictService.getDictDTO(note_no);
				
				
				//  통합검색  게시판 목록 총 개수 가져오기
				int dictList_contentAllCnt = this.dictService.getContentAllCnt( dictSearchDTO );
				
				// [선택된 페이지 번호] 보정하기
				if( dictList_contentAllCnt>0 ){
				
					int beginRowNo= dictSearchDTO.getSelectPageNo( )*dictSearchDTO.getRowCntPerPage( )
									- dictSearchDTO.getRowCntPerPage( )+1;
					//System.out.println(1+dictSearchDTO.getSelectPageNo( ) +"/"+ dictSearchDTO.getRowCntPerPage( )+1);
					// [시작행번호] > [총검색 개수] 일 경우 
					// [선택된 페이지 번호]를 1로하고 검색 행의 [시작행 번호]를 1로하기
					if(dictList_contentAllCnt<beginRowNo) {
							dictSearchDTO.setSelectPageNo(1);
					}
				}
				
				ModelAndView mav = new ModelAndView();
				
				mav.setViewName("/dictContentForm.jsp");
				
				mav.addObject("dictList_content", dictList_content);
				mav.addObject("ex_keyword", ex_keyword);
				mav.addObject("dictList_contentAllCnt", dictList_contentAllCnt );
				//mav.addObject("note_no", note_no);
				mav.addObject("DictSearchDTO", dictSearchDTO);
				
				return mav;
				
			}
				
				
		/*		
			//*************************************************
			// 한국어 사전 게시판으로 진입시 호출되는 메소드
			@RequestMapping( value="/dictList_kor.do" )
			
			public ModelAndView getTabDictList_kor( DictSearchDTO dictSearchDTO ) {
				
				//-------------------------------------------------------------------------------------------
				//  Tab 검색 n행 n열 한국어 게시판 목록 가져오기
				List<Map<String,String>> tabDictList_kor = this.dictService.getTabDictList_kor( dictSearchDTO );
				
				// Tab 검색_한국어 게시판 목록 총 개수 가져오기
				int tabDictListAllCnt_kor = this.dictService.getTabDictListAllCnt_kor( dictSearchDTO );
				
				ModelAndView mav = new ModelAndView();
				
				System.out.println("tabkeyword(C) : " + dictSearchDTO.getKeyword() );
				
				mav.addObject("tabDictList_kor", tabDictList_kor);
				mav.addObject("tabDictListAllCnt_kor", tabDictListAllCnt_kor );
				
				mav.setViewName("/dictList.jsp");
				//mav.setViewName("/dictList_kor.jsp");
				
				System.out.println("한국어 탭 검색 사전행의 개수 확인=> "+tabDictList_kor.size());
				
				return mav;
			}  
			
			//*************************************************
			// 영어 사전 게시판으로 진입시 호출되는 메소드
			@RequestMapping(value="/dictList_eng.do")
			
			public ModelAndView getTabDictList_eng( DictSearchDTO dictSearchDTO ) {
				
				System.out.println("컨트롤로 들어온 키워드 파라미터값=> "+ dictSearchDTO.getKeyword() );
				//-------------------------------------------------------------------------------------------
				//  Tab 검색 n행 n열 영어 게시판 목록 가져오기
				List<Map<String,String>> tabDictList_eng  = this.dictService.getTabDictList_eng( dictSearchDTO );
				
				// Tab 검색_영어 게시판 목록 총 개수 가져오기
				int tabDictListAllCnt_eng = this.dictService.getTabDictListAllCnt_eng( dictSearchDTO );
				
				ModelAndView mav = new ModelAndView();
				
				System.out.println("tabkeyword(C) : " + dictSearchDTO.getKeyword() );
				
				mav.addObject("tabDictList_eng", tabDictList_eng);
				mav.addObject("tabDictListAllCnt_eng", tabDictListAllCnt_eng );
				
				mav.setViewName("/dictList.jsp");
				//mav.setViewName("/dictList_eng.jsp");
				
				System.out.println(" 영어  탭 검색 사전행의 개수 확인=> "+ tabDictList_eng.size());
			
				return mav;
			}  
			
			//*************************************************
			// 일본어 사전 게시판으로 진입시 호출되는 메소드
			@RequestMapping( value="/dictList_jpn.do")
			public ModelAndView getTabDictListAllCnt_jpn( DictSearchDTO dictSearchDTO ) {
				
				//-------------------------------------------------------------------------------------------
				//  Tab 검색 n행 n열 일본어 게시판 목록 가져오기
				List<Map<String,String>> tabDictList_jpn  = this.dictService.getTabDictList_jpn( dictSearchDTO );
				
				// Tab 검색_일본어 게시판 목록 총 개수 가져오기
				int tabDictListAllCnt_jpn  = this.dictService.getTabDictListAllCnt_jpn( dictSearchDTO );
				
				ModelAndView mav = new ModelAndView();
				
				System.out.println("tabkeyword(C) : " + dictSearchDTO.getKeyword() );
				
				mav.addObject("tabDictList_jpn", tabDictList_jpn);
				mav.addObject("tabDictListAllCnt_jpn", tabDictListAllCnt_jpn );
				
				mav.setViewName("/dictList.jsp");
				//mav.setViewName("/dictList_jpn.jsp");
				
				System.out.println("일본어 탭 검색 사전행의 개수 확인=> "+tabDictList_jpn.size());
				
				return mav;
			}  
			
			//*************************************************
			// 중국어 사전 게시판으로 진입시 호출되는 메소드
			@RequestMapping( value="/dictList_cn.do")
			public ModelAndView getTabDictList_cn( DictSearchDTO dictSearchDTO ) {
				
				//-------------------------------------------------------------------------------------------
				//  Tab 검색 n행 n열 중국어 게시판 목록 가져오기
				List<Map<String,String>> tabDictList_cn  = this.dictService.getTabDictList_cn( dictSearchDTO );
				
				// Tab 검색_중국어 게시판 목록 총 개수 가져오기
				int tabDictListAllCnt_cn   = this.dictService.getTabDictListAllCnt_cn( dictSearchDTO );
				
				ModelAndView mav = new ModelAndView();
				
				System.out.println("tabkeyword(C) : " + dictSearchDTO.getKeyword() );
				
				mav.addObject("tabDictList_cn", tabDictList_cn);
				mav.addObject("tabDictListAllCnt_cn", tabDictListAllCnt_cn);
				
				mav.setViewName("/dictList.jsp");
				//mav.setViewName("/dictList_cn.jsp");
				
				System.out.println("중국어 탭 검색 사전행의 개수 확인=> "+tabDictList_cn.size());
				
				return mav;
			}  
		*/	
			//*************************************************
			// frontpage 화면 진입 호출 메소드
			@RequestMapping( value="/frontPage.do")
			public ModelAndView goBizLoginForm() {
				
				ModelAndView mav = new ModelAndView();
				mav.setViewName("/frontPage.jsp");
				return mav;
			}
			

			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// /recommend.do 로 접근하면 호출되는 메소드 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			@RequestMapping(
					value="/recommend.do"
					,method=RequestMethod.POST
					,produces="application/json;charset=UTF-8"
			)
			@ResponseBody
			public int doRecommend( 
					@RequestParam( value="user_id" ) String user_id,
					@RequestParam( value="lang_code" ) String lang_code,
					@RequestParam( value="d_no" ) String d_no
			){
				System.out.println( "DictController.doRecommend 메소드 진입 " );
				//session.setAttribute("user_id", user_id);
				//session.setAttribute("lang_code", lang_code);
				//session.setAttribute("d_no", d_no);
				//session.setAttribute("d_kor_no", d_kor_no);
				//session.setAttribute("d_eng_no", d_eng_no);
				//session.setAttribute("d_jpn_no", d_jpn_no);
				//session.setAttribute("d_cn_no", d_cn_no);
				
		
				Map<String,String> map = new HashMap<String,String>();
				map.put("user_id",user_id); 
				map.put("lang_code",lang_code);
				map.put("d_no",d_no);
		 
				//map.put("d_kor_no",d_kor_no);
				//map.put("d_eng_no",d_eng_no);
				//map.put("d_jpn_no",d_jpn_no);
				//map.put("d_cn_no",d_cn_no);
				
				
				int cnt = this.dictService.doRecommend(map);
				
				
				System.out.println( "DictController.doRecommend 실행 성공" );
				return cnt;
			} 
			
	 
	 
//===<dictRegForm>==========================================================================================	 
			
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 가상주소 /boardRegForm.do 로 접근하면 호출되는 메소드 선언
	// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@RequestMapping(value = "/dictRegForm.do")
	public ModelAndView goDictRegForm(
			// ------------------------------------------------------------------------
			// 파라미터명이 b_no 인 파라마터값을 받아오는 매개변수 b_no 선언하기
			// ------------------------------------------------------------------------
			@RequestParam(value = "note_no", required = false, defaultValue = "0") int note_no
	// ----------- ------------------ -----------------
	// 파라미터명 설정 파라미터명,값이 안들어와도 용서한다는 의미 파라미터값 없으면 0 저장
	// ------------------------------------------------------------------------
	// 만약 required=true 거나 required=~ 가 없으면 반드시 파리미터값은 들어와야하고 안들어오면
	// 에러발생해서 메소드 안의 내용은 하나도 실행이 안된다.
	// ------------------------------------------------------------------------

	) {
		// ------------------------------------------------------
		// [ModelAndView 객체] 생성하기
		// ------------------------------------------------------
		ModelAndView mav = new ModelAndView();
		// ------------------------------------------------------
		// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
		// ------------------------------------------------------
		mav.setViewName("dictRegForm.jsp");
		// ------------------------------------------------------
		// [ModelAndView 객체]에 JSP 페이지에서 꺼내볼 게시판 pk 번호 저장하기
		// [ModelAndView 객체]의 addObject 메소드로 저장된 DB 연동 결과물은 HttpServletRequest 객체에도
		// 저장된다.
		// ------------------------------------------------------
		mav.addObject("note_no", note_no);
		mav.addObject("DictSearchDTO", dictSearchDTO);
		// ------------------------------------------------------
		// [ModelAndView 객체] 리턴하기
		// ------------------------------------------------------
		return mav;

		/*
		 * //------------------------------------------------------ // <1> [ModelAndView
		 * 객체] 생성하기 // <2> [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기 // <3> [ModelAndView
		 * 객체]에 JSP 페이지에서 꺼내볼 게시판 pk 번호 저장하기 // [ModelAndView 객체]의 addObject 메소드로 저장된 DB
		 * 연동 결과물은 HttpServletRequest 객체에도 저장된다. // <4> [ModelAndView 객체] 리턴하기
		 * //------------------------------------------------------ ModelAndView mav =
		 * new ModelAndView( ); // <1> mav.setViewName("boardRegForm.jsp"); // <2>
		 * mav.addObject("b_no", b_no); // <3> return mav; // <4>
		 */

	}

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// /wordCheckProc.do 로 접근하면 호출되는 메소드 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping(
				value="/wordCheckProc.do"
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody
		public int checkWord(
			@RequestParam(value="word") String word
			,@RequestParam(value="lang_code") String lang_code
		){
			System.out.println("Controller checkWord 진입 성공");
			//-------------------------------------------
			// 입력하는 단어가 DB에 존재하는지를 확인하고, 존재할 경우 note_no 받아오기
			//-------------------------------------------
			int note_no = 0;
			//-------------------------------------------
			// 입력하려는 단어와, 그 언어코드를 HashMap객체에 담기
			//-------------------------------------------
			Map<String,String> map = new HashMap<String,String>();
			map.put("word",word);
			map.put("lang_code", lang_code);
			System.out.println("word : " + word + "lang_code : " + lang_code);		
			try{ 
			// CORE테이블의 word값과 lang_code가 동시에 일치하는 행의 note_no를 리턴
				note_no = this.dictService.checkWord(map);
				}
			catch(Exception ex){
								
				System.out.println( "DictController.checkWord 메소드 실행 시 예외발생!" );

			}

			return note_no;
		}

			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			// /boardRegProc.do 로 접근하면 호출되는 메소드 선언
			//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			@RequestMapping(
					value="/wordRegProc.do"
					,method=RequestMethod.POST
					,produces="application/json;charset=UTF-8"
			)
			@ResponseBody
			public int insertWord(	DictDTO dictDTO ){
				//-------------------------------------------
				// 단어 입력 성공 행의 개수를 저장할 변수 선언
				//-------------------------------------------
				int insertCnt = 0;
				System.out.println("Controller insertWord 진입 성공");
				
				try{
					insertCnt = this.dictService.insertNewWord(dictDTO);
					System.out.println( "BoardController.insertBoard 실행 성공" );
				}
				catch(Exception ex){
										
					System.out.println( "BoardController.insertBoard 메소드 실행 시 예외발생!" );
					insertCnt = -1;
				}
				//-------------------------------------------
				// 클라이언트에게 전달할 Map<String,String> 객체 생성하기
				// Map<String,String> 객체에 키값과 저장값을 "boardRegCnt", boardRegCnt+"" 로 저장하기
				// Map<String,String> 객체에 키값과 저장값을 "checkMsg", checkMsg 로 저장하기
				//-------------------------------------------

				//-------------------------------------------
				// Map<String,String> 객체 리턴하기
				//-------------------------------------------
				return insertCnt;
			}
			

	
	//==================<dictUpDelForm>========================================>>>
	
		// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 가상주소 /dictUpDelForm.do 로 접근하면 호출되는 메소드 선언
		// mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		@RequestMapping(value = "/dictUpDelForm.do")
		public ModelAndView goDictUpDelForm(
				// ------------------------------------------------------------------------
				// 파라미터명이 b_no 인 파라마터값을 받아오는 매개변수 b_no 선언하기
				// ------------------------------------------------------------------------
				//@RequestParam(value = "note_no", required = false, defaultValue = "0") int note_no
		// ----------- ------------------ -----------------
		// 파라미터명 설정 파라미터명,값이 안들어와도 용서한다는 의미 파라미터값 없으면 0 저장
		// ------------------------------------------------------------------------
		// 만약 required=true 거나 required=~ 가 없으면 반드시 파리미터값은 들어와야하고 안들어오면
		// 에러발생해서 메소드 안의 내용은 하나도 실행이 안된다.
		// ------------------------------------------------------------------------
				DictDTO dictDTO
				
				,HttpSession session 
		) {
			// ------------------------------------------------------
			// [ModelAndView 객체] 생성하기
			// ------------------------------------------------------
			ModelAndView mav = new ModelAndView();
			// ------------------------------------------------------
			// [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기
			// ------------------------------------------------------
			mav.setViewName("dictUpDelForm.jsp");
			mav.addObject("dictDTO",dictDTO);
			// ------------------------------------------------------
			// [ModelAndView 객체]에 JSP 페이지에서 꺼내볼 게시판 pk 번호 저장하기
			// [ModelAndView 객체]의 addObject 메소드로 저장된 DB 연동 결과물은 HttpServletRequest 객체에도
			// 저장된다.
			// ------------------------------------------------------
			//mav.addObject("note_no", note_no);
			// ------------------------------------------------------
			// [ModelAndView 객체] 리턴하기
			// ------------------------------------------------------
			return mav;

			/*
			 * //------------------------------------------------------ // <1> [ModelAndView
			 * 객체] 생성하기 // <2> [ModelAndView 객체]에 [호출 JSP 페이지명]을 저장하기 // <3> [ModelAndView
			 * 객체]에 JSP 페이지에서 꺼내볼 게시판 pk 번호 저장하기 // [ModelAndView 객체]의 addObject 메소드로 저장된 DB
			 * 연동 결과물은 HttpServletRequest 객체에도 저장된다. // <4> [ModelAndView 객체] 리턴하기
			 * //------------------------------------------------------ ModelAndView mav =
			 * new ModelAndView( ); // <1> mav.setViewName("boardRegForm.jsp"); // <2>
			 * mav.addObject("b_no", b_no); // <3> return mav; // <4>
			 */

		}	
		
		 //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm //
		  // dictUpDelProc.do 접속 시 호출되는 메소드 선언
		  //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		  
		  @RequestMapping( value="/dictUpDelProc.do" 
				  		,method=RequestMethod.POST
				  		,produces="application/json;charset=UTF-8" )
		  
		  @ResponseBody 
		  public Map<String,String> upDelNote( DictDTO dictDTO  ,@RequestParam(value="upDel") String upDel 
		  // Error 객체를 관리하는 BindingResult 객체가 저장된 매개변수 bindingResult 선언 , : 
		  ,BindingResult bindingResult
		  ){ 
		  // 노트를 수정/삭제하고 수정/삭제 적용행의 개수 저정할 변수 선언하기
		  int noteUpDelCnt=2;
		  // 게시판 수정 시 유효성 체크 시 경고문자 저장 변수  선언하기 
		  String checkMsg = "";
		  try{ // 만약 게시판 삭제 모드이면
		  if(upDel.equals("del")){
		  // DictServiceImpl객체의 deleteNote메소드를 호출하여 게시판 글 삭제하기 
		  noteUpDelCnt = this.dictService.upDelNote(dictDTO, upDel);
		  // 혹은 삭제된 꼬리글만을 관리하는 테이블에 노트번호 등록
		   }
		 //*******************************************
		 //만약게시판 수정 모드이면 
		 //******************************************* 
		  else if(upDel.equals("up")) { 
	    //----------------------------------------
		// DictDTO 객체에 저장된 데이터의 유효성 체크할 DictValidator 객체 생성하기
		// 유효성 체크 시 에러가 발생하면 BindingResult 객체가 인지한다.
		//----------------------------------------
		  System.out.println( upDel + "진행중 -  " + dictDTO.getLang_code() );
		  DictValidator dictValidator = new DictValidator();
		  dictValidator.validate(dictDTO, bindingResult);
		  //---------------------------------------- 
		  // BindingResult 객체의 hasErrors()메소드 호출하여 true 값을 얻으면, 즉 유효성 체크에 걸렸으면
		  //---------------------------------------- 
		  if( bindingResult.hasErrors() ) {
		  // 유효성 체크 시 경고 에러 메시지를 checkMsg 변수에 저장하기 
		  checkMsg = bindingResult.getFieldError().getCode();
		  }
		  //----------------------------------------
		  // BindingResult 객체의 hasErrors()메소드 호출하여 false 값을 얻으면, 즉 유효성 체크에 걸리지 않았으면
		  //---------------------------------------- 
		  else{
				//----------------------------------------
				// 수정 실행하고 수정 적용행의 개수얻기
				//----------------------------------------
				System.out.println("picName(전) : " + dictDTO.getWord()+upDel );
				noteUpDelCnt = this.dictService.upDelNote(dictDTO, upDel);
				System.out.println("picName(후) : " + dictDTO.getWord()+upDel );
							
			}
		  }
		  
		  }catch(Exception e) { noteUpDelCnt = -5; 
		  System.out.println("DictController.dictUpDelProc 메소드 실행 시 예외발생!" );
		  	}
		  // 클라이언트에게 전달할 객체 생성하기  Map<String,String>  
		  // Map<String,String> 객체의 키값과 저장값을 "noteUpDelCnt", noteUpDelCnt+"" 로 저장하기 
		  // Map<String,String> 객체의 키값과 저장값을 "checkMsg", checkMsg로 저장하기 
		  //*******************************************
		  Map<String,String> map = new HashMap<String,String>();
		  map.put("noteUpDelCnt", noteUpDelCnt+"" );
		  map.put("checkMsg", checkMsg );
		  // Map<String,String> 객체 리턴하기
		  return map;
		  }
		
		
		
	
	
	
	
	
	
	
	
	
	
		
	  


}

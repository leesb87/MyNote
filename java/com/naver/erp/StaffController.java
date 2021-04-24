package com.naver.erp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StaffController {

	public void pt(int no) {
		System.out.println(no);
	}

	@Autowired
	private StaffService staffService;

	@Autowired
	HttpServletRequest request;

//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
// 가상주소 /boardList.do로 접근하는 호출되는 메소드 선언
//	@RequestMapping 내부에 method="RequestMethod.POST"가 없으므로
//	가상주소 /boardListForm.do로 접근시 get 또는 post방식접근 모두를 허용한다.
//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN

	@RequestMapping(value = "/staffList.do") // start.jsp로부터 접근
	public ModelAndView staffForm(
			//-------------------------------------
			// 파라미터값을 저장하고 있는  StaffSearchDTO객체를 받아오는 매개변수 선언
			//-------------------------------------
			StaffSearchDTO staffSearchDTO
			) {
		
		/*		
		//*********************************************
		// [검색된 게시글의 총 개수] 얻기
		//*********************************************
		//int boardListAllCnt = this.boardService.getBoardListAllCnt(boardSearchDTO);
		int staffListAllCnt = this.boardService.getStaffListAllCnt();
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		// [선택된 페이지 번호] 보정하기
		//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		//--------------------------------------------
		// 검색된 게시판 총 개수가 1개 이상일 때, [선택된 페이지번호] 보정하기
		// [선택된 페이지번호]와 총개수 간의 관계가 이상할 경우가 있다.
		// 예) 검색 페이지 수가 3개인 상태에서 선택페이지가 2페이지일 경우 3페이지째의 검색결과를 표시할 수 없다.
		// 이 경우, 선택페이지 번호를 1로 수정한다.	
		//--------------------------------------------
		if(boardListAllCnt>0) {
			int beginRowNo = boardSearchDTO.getSelectPageNo()*boardSearchDTO.getRowCntPerPage()
								-boardSearchDTO.getRowCntPerPage()+1;
			// [시작행번호] > [총검색 개수]일 경우 
			// [선택된 페이지 번호]를 1로 하고 검색 행의 [시작행 번호]를 1로 하기
			if(boardListAllCnt < beginRowNo) {
				boardSearchDTO.setSelectPageNo(1);		
			}
		}
		*/
		//*********************************************
		// [게시판 목록] 얻기
		//*********************************************
		// BoardService인터페이스를 구현한 객체(=BoardServiceImpl) 소유의 getBoardList메소드 호출로
		// [검색한 게시판 목록]을 List<Map<String,String>> 객체로 얻기
		// 이때 BoardService인터페이스를 구현한 객체의 이름을 알 필요가 없다.
		// Spring이 알아서 찾아주기 때문이다.(Autowired)

		List<Map<String,String>> staffList = this.staffService.getStaffList(staffSearchDTO);
	
		System.out.println("staffList : " + staffList.size());
		
		
		int staffListAllCnt = this.staffService.getStaffListAllCnt(staffSearchDTO);
		
		
		
		
		
		
		
		//*********************************************
		//[ModelAndView객체] 생성하기	
		//*********************************************
		ModelAndView mav = new ModelAndView();	
		//*********************************************
		//[ModelAndView객체]에 [호출JSP페이지명]을 저장하기	
		//*********************************************
		mav.setViewName("staff_search_form.jsp");
		//******************************************************************
		// [ModelAndView객체]에 JSP페이지에서 꺼내볼 게시판목록이 저장된
		// List<Map<String,String>> 객체 저장하기
		//******************************************************************
		mav.addObject("staffList", staffList);
		//******************************************************************
		// [ModelAndView객체]에 addObject메소드로 저장된 DB연동결과물은 
		// HTTPServletRequest객체에도 저장된다.
		//******************************************************************
		mav.addObject("staffListAllCnt", staffListAllCnt);
		
		
		

		//[ModelAndView객체] 리턴하기
		return mav;
	}

	
	/*
	 * 
	 * @RequestMapping(value="/staffList.do") public ModelAndView getStaffList(
	 * //------------------------------------- // 파라미터값을 저장하고 있는 BoardSearchDTO객체를
	 * 받아오는 매개변수 선언 //------------------------------------- BoardSearchDTO
	 * boardSearchDTO //------------------------------------- // HttpSession객체를 받아오는
	 * 매개변수 선언 //------------------------------------- ,HttpSession session ) {
	 * 
	 * //********************************************* // HttpSession객체에서 로그인 성공시
	 * 저장한 아이디 꺼내기 // 꺼낸 아이디가 없으면 (=로그인 상태가 아니면) ModelAndView객체에 // "logout.jsp"를
	 * 저장하고 ModelAndView객체 리턴하기 //*********************************************
	 * 
	 * String admin_id = (String)session.getAttribute("admin_id");
	 * if(admin_id==null) { ModelAndView mav = new ModelAndView();
	 * mav.setViewName("logout.jsp"); return mav; }
	 * 
	 * //********************************************* // [검색된 게시글의 총 개수] 얻기
	 * //********************************************* 
	 * 
	 * //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% // [선택된 페이지 번호] 보정하기
	 * //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	 * //-------------------------------------------- // 검색된 게시판 총 개수가 1개 이상일 때,
	 * [선택된 페이지번호] 보정하기 // [선택된 페이지번호]와 총개수 간의 관계가 이상할 경우가 있다. // 예) 검색 페이지 수가 3개인
	 * 상태에서 선택페이지가 2페이지일 경우 3페이지째의 검색결과를 표시할 수 없다. // 이 경우, 선택페이지 번호를 1로 수정한다.
	 * //-------------------------------------------- if(boardListAllCnt>0) { int
	 * beginRowNo =
	 * boardSearchDTO.getSelectPageNo()*boardSearchDTO.getRowCntPerPage()
	 * -boardSearchDTO.getRowCntPerPage()+1; // [시작행번호] > [총검색 개수]일 경우 // [선택된 페이지
	 * 번호]를 1로 하고 검색 행의 [시작행 번호]를 1로 하기 if(boardListAllCnt < beginRowNo) {
	 * boardSearchDTO.setSelectPageNo(1); } }
	 * 
	 * //********************************************* // [게시판 목록] 얻기
	 * //********************************************* // BoardService인터페이스를 구현한
	 * 객체(=BoardServiceImpl) 소유의 getBoardList메소드 호출로 // [검색한 게시판 목록]을
	 * List<Map<String,String>> 객체로 얻기 // 이때 BoardService인터페이스를 구현한 객체의 이름을 알 필요가
	 * 없다. // Spring이 알아서 찾아주기 때문이다.(Autowired)
	 * 
	 * List<Map<String,String>> boardList =
	 * this.boardService.getBoardList(boardSearchDTO);
	 * 
	 * 
	 * 
	 * 
	 * //********************************************* //[ModelAndView객체] 생성하기
	 * //********************************************* ModelAndView mav = new
	 * ModelAndView();
	 * 
	 * //********************************************* //[ModelAndView객체]에
	 * [호출JSP페이지명]을 저장하기 //*********************************************
	 * mav.setViewName("boardList.jsp");
	 * 
	 * //****************************************************************** //
	 * [ModelAndView객체]에 JSP페이지에서 꺼내볼 게시판목록이 저장된 // List<Map<String,String>> 객체 저장하기
	 * //******************************************************************
	 * mav.addObject("boardList", boardList);
	 * //****************************************************************** //
	 * [ModelAndView객체]에 addObject메소드로 저장된 DB연동결과물은 // HTTPServletRequest객체에도 저장된다.
	 * //******************************************************************
	 * 
	 * //****************************************************************** //
	 * [BoardSearchDTO객체]에서 keyword를 키명-키값으로 mav객체에 저장하기
	 * //******************************************************************
	 * //mav.addObject("boardSearchDTO", boardSearchDTO ); //int
	 * rnum=boardSearchDTO.getRnum(); //mav.addObject("rnum", rnum+"");
	 * 
	 * //[ModelAndView객체] 리턴하기 return mav;
	 * 
	 * }
	 * 
	 * 
	 * 
	 * 
	 * 
	 * //+++++++++++++++++++++++++++++++++++++++++++++++++ // 가상주소 /boardRegForm.do로
	 * 접근하면 호출되는 메소드 선언 //+++++++++++++++++++++++++++++++++++++++++++++++++
	 * 
	 * @RequestMapping(value="/boardRegForm.do") public ModelAndView goBoardRegForm(
	 * 
	 * @RequestParam(value="b_no", required=false // -------------- ------------- //
	 * 파라미터명 설정 파라미터명이 없어도 괜찮다는 설정 , defaultValue="0") int b_no //b_no가 0일 때에는 새글쓰기,
	 * 0이 아닐 때는 댓글쓰기 모드 //--------------- //파라미터값이 없으면 0 저장
	 * //------------------------------------------------------ // 만약 required값이
	 * true거나 설정되어있지 않으면 반드시 파라미터값이 들어와야 하고 // 들어오지 않으면 메소드 내부의 내용은 실행되지 않는다.
	 * //(int형 변수에는 반드시 정수데이터가 들어가야 하기 때문) ,HttpSession session ) {
	 * 
	 * 
	 * //********************************************* // HttpSession객체에서 로그인 성공시
	 * 저장한 아이디 꺼내기 // 꺼낸 아이디가 없으면 (=로그인 상태가 아니면) ModelAndView객체에 //
	 * //********************************************* String admin_id =
	 * (String)session.getAttribute("admin_id"); if(admin_id==null) { ModelAndView
	 * mav = new ModelAndView(); mav.setViewName("logout.jsp"); return mav; }
	 * 
	 * 
	 * //[ModelAndView객체] 생성하기 ModelAndView mav = new ModelAndView();
	 * //[ModelAndView객체]에 [호출JSP페이지명]을 저장하기 mav.setViewName("boardRegForm.jsp");
	 * //--------------------------------------------------------- //
	 * [ModelAndView객체]에 JSP페이지에서 꺼내본 게시판 PK번호 저장하기 // [ModelAndView객체]에
	 * addObject메소드로 저장된 DB연동결과물은 HttpServletRequest객체에도 저장된다.
	 * //---------------------------------------------------------
	 * //boardDTO.setB_no(b_no);
	 * 
	 * mav.addObject("b_no", b_no); //[ModelAndView객체] 리턴하기 return mav; }
	 * 
	 * @RequestMapping( value="/boardRegProc.do" ,method=RequestMethod.POST
	 * ,produces="application/json;charset=UTF-8" )
	 * 
	 * @ResponseBody public int insertBoard( //@RequestParam(value="writer") String
	 * writer //,@RequestParam(value="subject") String subject
	 * //,@RequestParam(value="email") String email
	 * //,@RequestParam(value="content") String content
	 * //,@RequestParam(value="pwd") String pwd
	 * 
	 * //************************************************************** // 파라미터값을
	 * 저장할 [BoardDTO객체]를 매개변수로 선언
	 * //************************************************************** // [파라미터명]과
	 * [BoardDTO객체]의 [속성변수명]이 같으면 // setter메소드가 작동되어 [파라미터값]이 [속성변수]에 저장된다. //
	 * [속성변수명]에 대응하는 [파라미터명]이 없으면 setter메소드가 작동되지 않는다. // [속성변수명]에 대응하는 [파라미터명]이 있는데
	 * [파라미터값]이 없으면 // [속성변수]의 자료형에 관계없이 무조건 null값이 저장된다. // 이때 [속성변수]의 자료형이 기본형일 경우
	 * null값이 저장될 수 없어 에러가 발생한다. // 이러한 에러를 피하려면 파라미터값이 기본형이거나 속성변수의 자료형을 String으로
	 * 해야한다. // 이러한 에러가 발생하면 메소드안의 실행구문은 하나도 실행되지 않음에 주의한다. // 매개변수로 들어온 [DTO]객체는 이
	 * 메소드가 끝난 후 호출되는 JSP페이지로 그대로 이동한다. // 즉, HttpServletRequest객체에 boardDTO라는 키값명으로
	 * 저장된다. //**************************************************************
	 * BoardDTO boardDTO ) {
	 * 
	 * //---------------------------------------------------------- // 게시판 글 입력하고
	 * [게시판 입력 적용행의 개수] 저장할 변수 선언
	 * //---------------------------------------------------------- int boardRegCnt
	 * = 0; System.out.println("(C)_insertBoard 진입성공");
	 * 
	 * try { //---------------------------------------------------------- //
	 * [BoardServiceImpl객체[의 insertBoard 메소드 호출로 // 게시판 글 입력하고 [게시판 입력 적용행의 개수] 얻기
	 * //---------------------------------------------------------- boardRegCnt =
	 * this.boardService.insertBoard(boardDTO); } catch(Exception ex) {
	 * System.out.println("BoardController.insertBoard 메소드 실행시 예외발생!"); boardRegCnt
	 * = -1; }
	 * 
	 * 
	 * return boardRegCnt; }
	 * 
	 * 
	 * @RequestMapping( value="/boardContentForm.do" ,method=RequestMethod.POST )
	 * public ModelAndView goBoardContentForm(
	 * 
	 * @RequestParam(value="b_no") int b_no // String으로도 받을 수 있다. 기본형으로 받을 경우 값이 꼭
	 * 있어야 한다. ) {
	 * 
	 * System.out.println("BoardContentForm 진입 성공/ b_no : " + b_no); //
	 * [ModelAndView객체] 생성하기 ModelAndView mav = new ModelAndView(); //
	 * [ModelAndView객체]에 [호출JSP페이지명]을 저장하기 mav.setViewName("boardContentForm.jsp");
	 * 
	 * //*************************************************** // [BoardService객체]의
	 * getBoard메소드 호출로 [1개의 게시판 글]을 BoardDTO객체에 담아오기
	 * //*************************************************** BoardDTO board =
	 * this.boardService.getBoard(b_no);
	 * //*************************************************** // [ModelAndView객체]에
	 * 검색한 BoardDTO객체 저장하기 // [ModelAndView객체]의 addObject메소드로 저장된 객체는
	 * HttpSurvletRequest객체에도 저장된다.
	 * //*************************************************** mav.addObject("board",
	 * board);
	 * 
	 * 
	 * 
	 * // [ModelAndView객체] 리턴하기 return mav; }
	 * 
	 * //****************************************** // /boardUpDelForm.do 접속시 호출되는
	 * 메소드 선언 //******************************************
	 * 
	 * @RequestMapping(value="/boardUpDelForm.do", method=RequestMethod.POST) public
	 * ModelAndView goBoardUpDelForm( // "b_no" 파라티머의 값이 저장되는 매개변수 b_no 선언 // 이
	 * 파라미터는 수정/삭제할 게시글의 고유번호가 들어온다.
	 * 
	 * @RequestParam(value="b_no") int b_no ) { //*********************************
	 * // [ModelAndView객체] 생성하기 // [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
	 * //********************************* ModelAndView mav = new ModelAndView();
	 * mav.setViewName("boardUpDelForm.jsp"); //********************************* //
	 * [수정/삭제할 1개의 게시판 글 정보] 얻기 // [ModelAndView객체]에 [수정/삭제할 1개의 게시판 글 정보] 저장하기
	 * //********************************* // 수정/삭제작업 도중 메인글이 삭제될 수 있으므로, 메인글의 존재여부도
	 * 확인한다. BoardDTO boardDTO =
	 * this.boardService.getBoard_without_updateReadCnt(b_no); //BoardDTO board =
	 * this.boardService.getBoard(b_no); mav.addObject("board", boardDTO);
	 * 
	 * //********************************* // [ModelAndView 객체] 리턴하기
	 * //********************************* return mav; }
	 * 
	 * @RequestMapping( value="/boardUpDelProc.do" ,method=RequestMethod.POST
	 * ,produces="application/json;charset=UTF-8" )
	 * 
	 * @ResponseBody public int boardUpDelProc( //DTO객체의 속성변수명과 파라미터명이 같아야 함
	 * BoardDTO boardDTO ,@RequestParam(value="upDel") String upDel ){
	 * 
	 * //************************************************ // 게시판 글을 수정/삭제하고 적용된 행의
	 * 개수를 저장할 변수 선언하기 //************************************************ int
	 * boardUpDelCnt=0; //************************************************ // 수정모드일
	 * 경우 수정 실행하고 수정 적용행의 개수 얻기 //************************************************
	 * if(upDel.equals("up")) { boardUpDelCnt =
	 * this.boardService.updateBoard(boardDTO);
	 * 
	 * System.out.println("upDelCnt(Up) : " + boardUpDelCnt);
	 * 
	 * } //************************************************ // 삭제모드일 경우 삭제 실행하고 삭제
	 * 적용행의 개수 얻기 //************************************************ else {
	 * 
	 * boardUpDelCnt = this.boardService.deleteBoard(boardDTO);
	 * System.out.println("upDelCnt(Del) : " + boardUpDelCnt); }
	 * 
	 * return boardUpDelCnt; }
	 * 
	 */

}

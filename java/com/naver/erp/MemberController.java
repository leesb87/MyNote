package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
// URL주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
// @Controller를 붙임으로서 [컨트롤러 클래스]임을 지정한다.
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
@Controller
public class MemberController {
	
	//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	@Autowired
	public MemberService memberService;
	//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	
	//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	@Autowired
	HttpServletRequest request;
	//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	

	//+++++++++++++++++++++++++++++++++++++++++++++++++
	// 가상주소 /memberRegForm.do로 접근하면 호출되는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++++++++++++
	@RequestMapping(value="/memberRegForm.do")
	public ModelAndView memberRegForm() {
		
		//[ModelAndView객체] 생성하기	
		ModelAndView mav = new ModelAndView();	
		//[ModelAndView객체]에 [호출JSP페이지명]을 저장하기	
		mav.setViewName("memberRegForm.jsp");

		return mav;
	}
	
@RequestMapping(
		value="/memberRegProc.do"
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
			)
@ResponseBody
public int insertMember(MemberDTO memberDTO	){
			
			//----------------------------------------------------------
			//	게시판 글 입력하고 [게시판 입력 적용행의 개수] 저장할 변수 선언
			//----------------------------------------------------------	
			int memberRegCnt = 0;
			System.out.println("(C)_insertMember 진입성공");
			
			try {
			//----------------------------------------------------------
			// [BoardServiceImpl객체[의 insertBoard 메소드 호출로
			// 게시판 글 입력하고 [게시판 입력 적용행의 개수] 얻기		
			//----------------------------------------------------------
				memberRegCnt = this.memberService.insertMember(memberDTO);
			}
			catch(Exception ex) {
				System.out.println("MemberController.insertMember 메소드 실행시 예외발생!");
				memberRegCnt = -1;			
			}
			

			return memberRegCnt;
	}	
	
	

//****************************************************
// 위 loginProc(~)메소드는 아래처럼 @ResponseBody를 사용하면 JSP 페이지 호출없이
// 리턴하는 로그인 정보 정보개수를 직접 클라이언트에게 전송할 수도 있다.
// 단, 서버가 보내는 데이터를 클라이언트가 받을 수 있도록 클라이언트 측에 코딩되어 있어야한다.
//****************************************************
	
@RequestMapping(
		value="/memberRegVerify.do"		//memberRegForm의 memberRegVerify.do()로부터 접근
		,method=RequestMethod.POST
		,produces="application/json;charset=UTF-8"
)
@ResponseBody //check_for  id_verify jumin_verify  idJuminVal
public int getVerification(

		//-------------------------------------------------------------------------
		// "check_for"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 check_for에 저장하고 들어온다.
		//-------------------------------------------------------------------------
		@RequestParam( value="check_for" ) String check_for
		//-------------------------------------------------------------------------
		// "idJuminVal"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 idJuminVal에 저장하고 들어온다.
		//-------------------------------------------------------------------------
		,@RequestParam( value="idJuminVal" ) String idJuminVal
		//-------------------------------------------------------------------------
		) {
		
	// 중복여부 확인대상 데이터를 가지고 DB연동을 하여 아이디의 존재개수를 리턴하기
	
	//--------------------------------------------------------
	// HashMap객체에 로그인 ID,암호를 저장하기
	// 하나의 변수 안에 데이터를 넣어 다른 객체로 전달하기가 쉽다.
	// 뿐만 아니라 mybatis 프레임워크 mybatis쪽으로 던져지는 데이터는 무조건 하나여야 한다.
	//--------------------------------------------------------
			
	Map<String,String> map = new HashMap<String,String>();
	map.put("check_for",check_for);
	map.put("idJuminVal",idJuminVal);
	System.out.println("MemberService 메소드 진입 직전");
	//------------------------------------------------
	// 로그인 ID,암호의 존재개수를 저장하는 변수 선언
	//------------------------------------------------
	int idCnt = 0;
	//------------------------------------------------
	// MemberServiceImpl객체의 getVerifyCnt메소드를 호출해서 로그인ID,암호의 존재개수 얻기
	//------------------------------------------------
	idCnt = this.memberService.getVerifyCnt(map);
	
	
	return idCnt;
		
}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}

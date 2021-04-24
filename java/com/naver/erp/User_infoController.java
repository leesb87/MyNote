package com.naver.erp;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
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
public class User_infoController {
	
	
	@Autowired
	private User_infoService user_infoService;
	
	@Autowired
	HttpServletRequest request;
	
	//****************************************************
	// 가상주소 /erp/memberRegForm.do로 접근하면 호출되는 메소드 선언
	//****************************************************
	@RequestMapping(value="/userRegForm.do")	// start.jsp로부터 접근
	public ModelAndView memberRegForm(		   	
       ){	
		System.out.println("User_infoController userRegForm 진입성공");
		//---------------------------------------------
		// [ModelAndView객체] 생성하기
		// [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
		// [ModelAndView객체] 리턴하기
		//---------------------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("userRegForm.jsp");
		System.out.println("User_infoController userRegForm 진입성공");
		return mav;			
	}	
	
	
	

    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// /boardRegProc.do 로 접근하면 호출되는 메소드 선언
	// 새글쓰기 ,댓글쓰기
	// 새글쓰기 저장시
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
			@RequestMapping(
					         value="/userRegProc.do"
					         ,method=RequestMethod.POST
					         ,produces="application/json;charset=UTF-8"
			)
			@ResponseBody
			public Map<String, String> insertMember(
					        User_infoDTO user_infoDTO
					       ,BindingResult bindingResult  
			){	
       System.out.println("User_infoController insertMember 진입성공");
			//----------------------------------------------------------
			//	게시판 글 입력하고 [회원가입 성공행의 개수] 저장할 변수 선언
			//----------------------------------------------------------	
             int user_infoRegCnt = 0;
            //-------------------------------------------
     		// 게시판 입력 데이터의 유효성  체크 시 경고문자 저장 변수 선언하기
     		//-------------------------------------------
     		String checkMsg="";			 
	   try{		
		   User_infoValidator user_infoValidator = new User_infoValidator();
		   user_infoValidator.validate(
	        	    user_infoDTO                 // 유효성 체크할 DTO 객체
				   ,bindingResult                // 유효성 체크 결과를 관리하는 BindingResult 객체  
			 );	
	         if(bindingResult.hasErrors()) {
	        	 checkMsg=bindingResult.getFieldError().getCode();
	         }
	         else{
	            //--------------------------------- 
	        	// 회원가입 성공행의 개수
	            //--------------------------------- 
	        	 user_infoRegCnt = this.user_infoService.insertMember(user_infoDTO);
	         }
             System.out.println( "User_infoController.insertMember 실행 성공" + user_infoRegCnt);
	   }
	   catch(Exception ex){    //입력 .insert는 반드시 들어아갸한다. 
	            System.out.println( "User_infoController.insertMember 메소드 실행 시 예외발생!" );
       user_infoRegCnt = -1;
       }    	
			Map<String,String> map = new HashMap<String,String>();		
				map.put("user_infoRegCnt", user_infoRegCnt+"");
				map.put("checkMsg", checkMsg);
					
			return map;
			}
				
		
				
	
//****************************************************
// 위 loginProc(~)메소드는 아래처럼 @ResponseBody를 사용하면 JSP 페이지 호출없이
// 리턴하는 로그인 정보 정보개수를 직접 클라이언트에게 전송할 수도 있다.
// 단, 서버가 보내는 데이터를 클라이언트가 받을 수 있도록 클라이언트 측에 코딩되어 있어야한다.
//****************************************************
			
		@RequestMapping(
				value="/userRegVerify.do"		//memberRegForm의 memberRegVerify.do()로부터 접근
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
			
			System.out.println( "idJuminVal 체크한당! " + idJuminVal );
			
			
			Map<String,String> map = new HashMap<String,String>();
			map.put("check_for",check_for);
			map.put("idJuminVal",idJuminVal);
			System.out.println("user_infoService 메소드 진입 직전");
			//------------------------------------------------
			// 로그인 ID,암호의 존재개수를 저장하는 변수 선언
			//------------------------------------------------
			int idCnt = 0;
			//------------------------------------------------
			// MemberServiceImpl객체의 getVerifyCnt메소드를 호출해서 로그인ID,암호의 존재개수 얻기
			//------------------------------------------------
			idCnt = this.user_infoService.getVerifyCnt(map);
			
			
			
			return idCnt;
		}			
		
		
		
		
			
		
}

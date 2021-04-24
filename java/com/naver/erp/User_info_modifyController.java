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
public class User_info_modifyController {
	
	@Autowired
	private User_info_modifyService user_info_modifyService;
	
	@Autowired
	HttpServletRequest request;
	
	//****************************************************
	// 가상주소 userReg_modify.do로 접근하면 호출되는 메소드 선언
	//****************************************************
	@RequestMapping(value="/user_modify.do")	
	
	public ModelAndView user_modify(	
			
			 HttpSession session   	
    ){	
			System.out.println("User_info_modifyController user_modify 진입성공");
		
			ModelAndView mav = new ModelAndView();
			mav.setViewName("user_modify.jsp");
			
			String user_id = (String)session.getAttribute("user_id");
			System.out.println("user_id" + user_id);
			
			
			
			User_info_modifyDTO user_info  = this.user_info_modifyService.getUser_info(user_id);
			
			mav.addObject("user_info", user_info);
		
			System.out.println("User_info_modifyController user_modify 출력성공");
			
			return mav;			
	}	

    //mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// /userReg_modifyProc.do 로 접근하면 호출되는 메소드 선언
	// 회원정보 수정
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	@RequestMapping(
			         value="/user_modifyProc.do"
			         ,method=RequestMethod.POST
			         ,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int user_modifyProc(
			User_info_modifyDTO user_info_modifyDTO
			
	){	
		System.out.println("User_info_modifyController user_modifyProc 진입성공");
		//----------------------------------------------------------
		//	 [회원 수정 성공행의 개수] 저장할 변수 선언
		//----------------------------------------------------------	
		int user_modifyCnt = 0;
		
        //--------------------------------- 
    	// 회원수정 성공행의 개수
        //--------------------------------- 
    	user_modifyCnt = this.user_info_modifyService.update_user_info(user_info_modifyDTO);
    
        System.out.println( "User_info_modifyController.update_user_info 실행 성공" + user_modifyCnt );
   
		return user_modifyCnt;
		
	}
				
	//****************************************************
	// 중복체크하는 가상주소
	//****************************************************
				
		@RequestMapping(
				value="/user_ModifyVerify.do"		
				,method=RequestMethod.POST
				,produces="application/json;charset=UTF-8"
		)
		@ResponseBody 
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
			System.out.println( "idJuminVal 체크한당! " + idJuminVal );
			
			
			Map<String,String> map = new HashMap<String,String>();
			map.put("check_for",check_for);
			map.put("idJuminVal",idJuminVal);
			System.out.println("User_info_modifyController getVerification 메소드 진입");
			//------------------------------------------------
			// 중복의 존재개수를 저장하는 변수 선언
			//------------------------------------------------
			int verifyCnt = 0;
			//------------------------------------------------
			// 중복의 존재개수 얻기
			//------------------------------------------------
			verifyCnt = this.user_info_modifyService.getVerifyCnt(map);
			return verifyCnt;
		}			
				
		
}

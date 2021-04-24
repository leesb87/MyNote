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
public class LoginController {
	//************************************************
	//속성변수 loginService 선언하고
	//@Autowired에 의해 LoginService 라는 인터페이스를
	//구현한 클래스를 객체화하여 저장한다.
	//************************************************
		//  @Autowired가 붙은 속성변수에는 인터페이스 자료형을 쓰고,
		//  이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
		//  LoginService라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다. 1개만 존재하면 된다.
		//  LoginService라는 인터페이스를 구현한 클래스의 이름을 바꾸어도 현재 이 클래스에는 바꿀 코딩이 없으므로,
		//  연쇄코디 수정을 막을 수 있다. 즉, 결합성이 약화된다.
		//************************************************
	@Autowired
	public LoginService loginService;	
	//****************************************************
	// 가상주소 /erp/loginForm.do로 접근하면 호출되는 메소드 선언
	//****************************************************
	@RequestMapping(value="/loginForm.do")	// start.jsp로부터 접근
	public ModelAndView loginForm(){	
		//---------------------------------------------
		// [ModelAndView객체] 생성하기
		// [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
		// [ModelAndView객체] 리턴하기
		//---------------------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginForm.jsp");
		return mav;			
	}	
/*
	@RequestMapping(value="/loginFormSP.do")	// start.jsp로부터 접근
	public ModelAndView loginFormSP(){
	
		//---------------------------------------------
		// [ModelAndView객체] 생성하기
		// [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
		// [ModelAndView객체] 리턴하기
		//---------------------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginFormSP.jsp");
		return mav;				
	}	
	*/
	
	//****************************************************
	// 위 loginProc(~)메소드는 아래처럼 @ResponseBody를 사용하면 JSP 페이지 호출없이
	// 리턴하는 로그인 정보 정보개수를 직접 클라이언트에게 전송할 수도 있다.
	// 단, 서버가 보내는 데이터를 클라이언트가 받을 수 있도록 클라이언트 측에 코딩되어 있어야한다.
	//****************************************************
		
	@RequestMapping(
			value="/loginProc.do"		//loginForm의 checkLogin()로부터 접근
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int getAdminIdCnt(
			// 클라이언트가 보낸 요청메시지 HttpServletRequest객체가 매개변수로 들어온다.
			// HttpServletRequest객체를 통해 파라미터값을 얻을 수 있다.
			//HttpServletRequest request
			//클라이언트 쪽에서
		    //---------------------------------------------
	        // "admin_id"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 admin_id에 저장하고 들어온다.
			//---------------------------------------------
			@RequestParam( value="id" ) String id
			//---------------------------------------------
			// "pwd"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 pwd에 저장하고 들어온다.
			//---------------------------------------------
			,@RequestParam( value="pwd" ) String pwd
			//---------------------------------------------
			// "is_login"라는 파라미터명에 해당하는 파라미터값을 꺼내서 매개변수 is_login에 저장하고 들어온다.
			// 체크박스는 비어있으면 에러나기 떄문이다. 체크가 안되어 있을수도 있다.
			//---------------------------------------------
			,@RequestParam( value="is_login",  required=false ) String is_login
			//---------------------------------------------
			// HttpSession 객체를 받아오는 매개변수 선언
			// 내가 다시 접속 할때까지 살아있음 계속 살아있음  아이디값을 저장
			//---------------------------------------------
			,HttpSession session
			//---------------------------------------------
			// [HttpServletResponse 객체]를 받아오는 매개변수 선언 쿠키값을 저장한다.
			//--------------------------------------------- 
			,HttpServletResponse resoponse
			){
		
		//클라이언트가 보낸 요청메시지 안의 "admin_id"명의 파라미터값 꺼내기
		//String admin_id = request.getParameter("admin_id");
		//클라이언트가 보낸 요청메시지 안의 "pwd"명의 파라미터값 꺼내기		
		//String pwd = request.getParameter("pwd");
				
		// 아이디/암호를 가지고 DB연동을 하여 아이디의 존재개수를 리턴하기
		
		//--------------------------------------------------------
		// HashMap객체에 로그인 ID,암호를 저장하기
		// HashMap객체에 저장하는 이유는 하나로 모으기 위함이다.
		// 그래야 다른 객체로 객체 전달하기가 쉽다.
		// 더구나 mybatis 프레임워크를 사용하면
		// 하나의 변수 안에 데이터를 넣어 다른 객체로 전달하기가 쉽다.
		// mybatis 프레임워크 쪽으로 던져지는 데이터는 무조건 하나여야 한다.
		//--------------------------------------------------------
		Map<String,String> map = new HashMap<String,String>();
		map.put("id",id);
		map.put("pwd",pwd);
				
		//------------------------------------------------
		// 로그인 ID,암호의 존재개수를 저장하는 변수 선언
		//------------------------------------------------
		int admin_idCnt = 0;
		String user_name ="";	
		String acc_read ="";	
		String acc_upDel ="";
		String acc_write ="";
		//------------------------------------------------
		// LoginServiceImpl객체의 getAdminCnt메소드를 호출해서 로그인ID,암호의 존재개수 얻기
		//------------------------------------------------	
		admin_idCnt = this.loginService.getAdminIdCnt(map);
		
		//------------------------------------------------
		//아이디와 암호의 존개 개수 1개면, 즉 아이디와 암호가 admin 테이블에 존재하면
		//------------------------------------------------
		if(admin_idCnt ==1 ) {
				if( session.getAttribute("admin_id")!=null   ) {
				session.removeAttribute("admin_id");
				}
			    session.setAttribute("user_id", id);
			    
			    user_name = this.loginService.getUser_name(id);				    
				session.setAttribute("user_name", user_name);
				
				acc_read = this.loginService.getAcc_read(id);	
				session.setAttribute("acc_read", acc_read);
				
				acc_upDel = this.loginService.getAcc_upDel(id);	
				session.setAttribute("acc_upDel", acc_upDel);
				
				acc_write = this.loginService.getAcc_write(id);	
				session.setAttribute("acc_write", acc_write);
				
				System.out.println("****************************************************************************************");
				System.out.println( "admin_id => "   + session.getAttribute("admin_id") 
									+" / "+ "user_id => "    + session.getAttribute("user_id") 
									+" / " + "user_name => "  + session.getAttribute("user_name") 
									+" / " + "acc_read => "   + session.getAttribute("acc_read") 
									+" / "  + "acc_upDel => "  + session.getAttribute("acc_upDel") 
									+" / "  + "acc_write => "  + session.getAttribute("acc_write")   );
				
				if(is_login==null) {
				    //Cookie 객체를 생성하고 쿠키명-쿠키값을 ["admin_id","null"]로 하기
					Cookie cookie1 = new Cookie("user_id",null);
					//Cookie 객체 수명은 0 으로 하기  
					cookie1.setMaxAge(0);
					//Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd","null"]로 하기
					Cookie cookie2 = new Cookie("pwd",null);
					//Cookie 객체 수명은 0으로 하기  
					cookie2.setMaxAge(0);
					//Cookie 객체를 응답메시지에 저장하기
					resoponse.addCookie(cookie1);
					resoponse.addCookie(cookie2);
			    }
				else {	
			        //Cookie 객체를 생성하고 쿠키명-쿠키값을 ["admin_id","입력아이디"]로 하기
					Cookie cookie1 = new Cookie("user_id",id);
					//Cookie 객체 수명은 60*60*24(=하루)으로 하기
					// 60*60*24*30 넣으면 30일이다
					cookie1.setMaxAge(60*60*24);
					//Cookie 객체를 생성하고 쿠키명-쿠키값을 ["pwd","pwd"]로 하기
					Cookie cookie2 = new Cookie("pwd",pwd);
					//Cookie 객체 수명은 60*60*24(=하루)으로 하기  
					cookie2.setMaxAge(60*60*24);
					//클라이언트로 갈 Cookie 객체를 응답메시지에 저장하기 
					//결국  Cookie 객체가 소유한 쿠키명-쿠키값이 응답메시지에 저장되는 샘이다.
					//응답메시지에 저장에 저장된 쿠키는 클라이언트쪽으로 전송되어 클라이언트쪽에 저장된다.
					resoponse.addCookie(cookie1);
					resoponse.addCookie(cookie2);
				}
	 
		 }
		else if(admin_idCnt == 2) {
			//------------------------------------------------
			// HttpSession객체에  로그인 성공한 [아이디] 저장하기
		    // HttpSession객체에 로그인에 성공한 [아이디]를 저장하면
			// 연결 상태가 유지되는 한 모든 JSP 페이지에서 꺼내어 확인해 볼 수 있다. 클라이언트에게 보내기
			//------------------------------------------------
				if( session.getAttribute("user_id")!=null || session.getAttribute("user_name")!=null || session.getAttribute("acc_read")!=null
						|| session.getAttribute("acc_upDel")!=null || session.getAttribute("acc_write")!=null) {
				
					// 밑에 있는 세션들 이거 하나로 다 지움
					//session.invalidate();
			
				session.removeAttribute("acc_read");
				session.removeAttribute("acc_upDel");	
				session.removeAttribute("acc_write");	
			    session.removeAttribute("user_id");
				session.removeAttribute("user_name");
				
				}
			session.setAttribute("admin_id", id);
			
			System.out.println("****************************************************************************************");
			System.out.println( "admin_id => "   + session.getAttribute("admin_id") 
								+" / "+ "user_id => "    + session.getAttribute("user_id") 
								+" / " + "user_name => "  + session.getAttribute("user_name") 
								+" / " + "acc_read => "   + session.getAttribute("acc_read") 
								+" / "  + "acc_upDel => "  + session.getAttribute("acc_upDel") 
								+" / "  + "acc_write => "  + session.getAttribute("acc_write")   );
			
		 }
		
		//admin_idCnt = 1;
		
		//-------------------------------------
		// 로그인 아이디,암호의 존재 개수를 리턴하기
		//-------------------------------------
		return admin_idCnt;				
	}
	
	
	//**************************************
	//가상주소  로 접근하면 호출되눈 메소드 선언
	//************************************** 
	@RequestMapping( value="/logout.do" )		//loginForm의 checkLogin()로부터 접근
	public ModelAndView logout(
			   //-----------------------------------
			   // HttpSession 객체]가 들어올 매개변수 선언.
			   // 매개변수에 자료형이 HttpSession이면 웹서버가
			   // 생성한 HttpSession 객체가 들어온다.
			   //-----------------------------------					
            HttpSession session 	
	){
		//-----------------------------------
		// HttpSession 객체에 저장된 로그인 아이디 삭제하기
	    //-----------------------------------
		session.removeAttribute("id");
	      
		//---------------------------------------------
		// [ModelAndView객체] 생성하기
		// [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
		// [ModelAndView객체] 리턴하기
		//---------------------------------------------
		ModelAndView mav = new ModelAndView();
		mav.setViewName("logout.jsp");
		System.out.println("<접속성공> [접속 URI]->/logout.do  [호출메소드]->BoardController.logout(~) \n");
		return mav;			
	    }	

	
	
	
	
	
	
	
	
	
	
/*	
	@RequestMapping(
			value="/findingPwd.do"		//loginForm의 checkLogin()로부터 접근
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public String findingPwd(
			@RequestParam( value="admin_id" ) String admin_id
		) {
		
		String finding_pwd = "123";
		
		return finding_pwd;
		
		}
	
	*/
	
	
	
	
	
	
	
	
	
	
	
	
	

}

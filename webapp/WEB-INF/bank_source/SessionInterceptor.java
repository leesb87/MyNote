package com.naver.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//==================================================================
// URL 접속시 [컨트롤러 클래스의 메소드] 호출 전 OR 후에
// 실행될 메소드를 소유한 [SessionInterceptor 클래스] 선언.
//==================================================================
	// 컨트롤러 클래스의 메소드 호출 전 or 후에 실행될 메소드를 소유한 클래스가 될 자격 조건
	//--------------------------------------------------------------------------------------
	//	<1> 스프링이 제공하는 [HandlerInterceptor 인터페이스]를 구현한다.
	//  <2> HandlerInterceptor 인터페이스의 preHandle 메소드를 재정의한다.
	//--------------------------------------------------------------------------
		//**********************************************************************
		// [HandlerInterceptorAdapter 객체]의 메소드 종류와 호출 시점
		//***********************************************************
		// preHandle()	: Controller 클래스의 메소드 실행 전에 호출, boolean 값을 return 하며 Controller 클래스의 특정 메소드 실행 여부를 결정
		// postHandle() : Controller 클래스의 메소드 실행 후, JSP 를 실행 전에 호출
		// afterCompletion() : Controller 클래스의 메소드 실행 후, JSP 를 실행 후 호출됨. responseBody를 이용할 경우 값을 Client 에게 전달 후 호출
		// HandlerInterceptorAdapter 에 줄이 가있는 이유는 사용중이지만 더 좋은 게 있으니 다른 것을 사용했으면 좋겠다는 권장되지 않는다는 의미이다.
		// 그래서 HandlerInterceptor로 바꾸고 extents가 아닌 인터페이스인 것을 implements해주어야 에러가 사라진다.
//==================================================================
public class SessionInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(
			HttpServletRequest request
			,HttpServletResponse response
			,Object handler
	) throws Exception{
		//------------------------------------------------------
		// HttpSession 객체 얻기
		// HttpServletRequest 객체의 getSession() 메소드를 호출하면 HttpSession 객체를 얻을 수 있다.
		//----------------------
		HttpSession session = request.getSession();
		//------------------------------------------------------
		// Session 객체에서 키값이 admin_id 로 저장된 데이터 꺼내기.
		// 즉 로그인 정보 꺼내기
		//----------------------
		String admin_id = (String)session.getAttribute("admin_id");
		//------------------------------------------------------
		// 꺼낸 admin_id가 null이면, 즉, 로그인한 적이 없으면
		//----------------------
		if(admin_id==null) {

			//-------------------------------------------------
			// 현재 이 웹 서비스의 Context Root 명 구하기 
			// HttpServletRequest 객체의 getContextPath() 메소드를 호출하면 Context Root명을 얻을 수 있다.
			//------------------------
			String contextroot = request.getContextPath();
			//-------------------------------------------------
			// Client 가 /loginForm.do로 재 접속하라고 설정하기
			// boardUpDelForm.do는 get방식 접근으로 인한 405 error가 발생하는데,
			// 로그인 상태가 아닌 상태에서 각 url로 접속하면 다 튕겨낸다.
			//------------------------
			response.sendRedirect(contextroot + "/loginForm.do");
			
			//--------------------
			// false 값을 리턴하기
			// false 값을 리턴하면 컨트롤러 클래스의 메소드는 호출되지 않는다.
			return false;
		}
		//------------------------------------------------------
		// 꺼낸 admin_id가 null이 아니면, 즉, 로그인한 적이 있으면
		//----------------------
		else {
			// false로 return하면 controller 클래스로 가지 않는다.
			// true는 보낸다.
			//System.out.println("<접속성공> SessionInterceptor.preHandle(~)\n");
			return true;
				
		}
		
		
	}
}
		

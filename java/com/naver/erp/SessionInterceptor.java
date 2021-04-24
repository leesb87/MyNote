package com.naver.erp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
//URL 접속 시 [컨트롤러 클래스의 메소드] 호출 전 또는 후에
//실행될 메소드를 송유한 [SessionInterceptor 클래스] 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
      // [컨트롤러 클래스의 메소드] 호출 전 또는 후에 실행될 메소드를 소유한 클래스가 될 자격 조건
      //-----------------------------------------------------------------
      //       <1> 스프링이 제공하는 [HandlerInterceptor 인터페이스]를 구현한다.
      //       <2> HandlerInterceptor 인터페이스의 preHandle 메소드를 재정의한다.
    
            //*****************************************************
            // [HandlerInterceptor 객체]의 메소드 종류와 호출 시점
			//*****************************************************
			// preHandle()       :Controller 클래스의 메소드 실행 전에 호출. boolean 값을 return 하며 Controller 클래스의 특정 메소드 실행 여부를 결정 
            // postHandle()      :Controller 클래스의 메소드 실행 후, JSP 를 실행 전에 호출
            // afterCompletion() :Controller 클래스의 메소드 실행 후, JSP 를 실행 후에 호출.responseBody를 이용할 경우 값을 클라이언트에게 전달 후 호출
// 권장되지 않는 HandlerInterceptorAdapter  줄그어진 이유는 이제는 쓰지 않았으면 좋겟다
// 작동은 하나 권장하지 않는다.
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

public class SessionInterceptor implements HandlerInterceptor{
	
	 @Override
		 public boolean preHandle(
				     HttpServletRequest request
				     ,HttpServletResponse response
					 ,Object Handler
		 ) throws Exception {
			 //---------------------------------- 
			 // HttpSession 객체 얻기
			 // HttpServletRequest 객체의 getSession() 메소드 호출하면 HttpSession 객체를 얻을 수 있다.   
			 //----------------------------------		 
			 HttpSession session = request.getSession();
			 
			 //---------------------------------- 
			 // Session 객체에서 키값이 admin_id 로 저장된 데이터 꺼내기.
			 // 즉 로그인 정보 꺼내기  
			 //----------------------------------	
			 String admin_id=(String)session.getAttribute("admin_id");
			 String user_id=(String)session.getAttribute("user_id");
			 
			 //System.out.println(  admin_id +"/"+   user_id   );
			 //-----------------------------
			 // 꺼낸 admin_id 가 null 이면, 즉 로그인한 적이 없으면  
			 //----------------------------------
			 if(user_id==null && admin_id==null  ) {
				 //-----------------
				 // 현재 이 웹서비스의 컨택스트 루트명 구하기
				 // HttpServletRequest 객체의 getContextPath() 메소드를 호출하면 컨택스트 루트명을 얻을 수 있다.   
				 //-----------------
				 String ctRoot  = request.getContextPath();
				 //-----------------
				 //클라이언트가/loginForm.do 로 재접속하라고 설정하기
				 //-----------------
				 response.sendRedirect( ctRoot + "/loginForm.do" );
				 
				 //-----------------
				 //false 값을 리턴하기
				 //false 값을 리턴하면 컨트롤러 클래스 메소드는 호출되지 않는다.
				 //-----------------		 
				 return false;
	         }
			
			 //-----------------------------
			 // 꺼낸 admin_id 가 null 아니면, 즉 로그인한 적이 있으면  
			 //----------------------------------
			 else{    
			     System.out.println("<접속성공> SessionInterceptor.preHandle(~)\n");
			     return true;
			 }
			 
	    }	 
}

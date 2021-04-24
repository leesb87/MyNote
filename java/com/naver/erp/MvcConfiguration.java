package com.naver.erp;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
//SessionInterceptor 클래스를 인터셉터로 등록하기 위한 MvcConfiguration 클래스 선언하기
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
     // MvcConfiguration 클래스 자체를 빈으로 등록하기 위해 클래스 앞에 @Configuration 어노테이션을 붙인다.
     // MVC 패턴의 웹과 관련된 처리를 위해 WebMvcConfigurer 인터페이스를 구현받는다.
     //MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	//SessionInterceptor 객체를 인터셉터로 등록하는 addInterrceptors 메서드로 오버라이딩한다.
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
     //---------------------------------------------------
	 // InterceptorRegistry 객체의 addInterceptor 메소드를 호출하여 SessionInterceptor 객체를 인터셉터로 등록하고  		
     // excludePathPatterns 메소드를 호출하여 예외되는 URL 주소 패턴을 등록한다.
	 //---------------------------------------------------	
     registry.addInterceptor(new SessionInterceptor()).excludePathPatterns(
    		 "/loginForm.do"
    		 ,"/loginProc.do"
    		 ,"/logout.do"
    		 ,"/userRegForm.do"
    		 //,"/boardList.do"
    		 ,"/userRegProc.do"
    		 ,"/userRegVerify.do"
    		 ,"/adminForm.do"
    		 ,"/accessUpdateProc.do"  
    		 ,"/resources/**"   		 
		 );		
	}
}
/*MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
인터셉터(Interceptor)란?
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
   웹서버에 URI 로 접근하면 컨트롤러 클래스의 메소드가 호출되는데
   컨트롤러 클래스의 메소드가 호출되기 전에 또는 호출 후에 호출되는 메소드를 소유하고 있는 객체를 말한다.
   컨트롤러 클래스의 URI에 접근 전 또는 후에 무언가를 제어할 필요가 있을 때 사용된다.
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
Spring에서 빈(Bean)?
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
   Spring 에서 POJO(plain, old java object)를 Bean 라고 부른다.
   Beans 는 애플리케이션의 핵심을 이루는 객체이며, Spring IO(Inversion of Control) 컨테이너에 의해 인스턴스화, 관리, 생성된다.
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM 
@Configuration 어노테이션?
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
    클래스를 빈으로 등록하는 어노테이션이다.
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
HandlerInterceptor 인터페시으 구현 객체]의 메소드 종류와 호출 시점
MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM 
   preHandle()       :Controller 클래스의 메소드 실행 전에 호출. boolean 값을 return 하며 Controller 클래스의 특정 메소드 실행 여부를 결정 
   postHandle()      :Controller 클래스의 메소드 실행 후, JSP 를 실행 전에 호출
   afterCompletion() :Controller 클래스의 메소드 실행 후, JSP 를 실행 후에 호출.responseBody를 이용할 경우 값을 클라이언트에게 전달 후 호출   
*/


















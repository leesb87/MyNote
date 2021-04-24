package com.naver.erp;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//========================================================================================
// SessionInterceptor 클래스를 인터셉터로 등록하기 위한 MvcConfiguration 클래스 선언하기
//========================================================================================
	// MvcConfiguration 클래스 자체를 빈으로 등록하기 위해 클래스 앞에 @Configuration 어노테이션을 붙인다.
	// MVC 패턴의 웹과 관련된 처리를 위해 WebMvcConfigurer 인터페이스를 구현받는다.
	//====================================================================================
@Configuration
public class MvcConfiguration implements WebMvcConfigurer {
	
	//------------------------------------------------------------------------------------------
	// SessionInterceptor 객체를 인터셉터를 등록하는 addInterceptors 메소드를 overridding 한다.
	//----------------------------------
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		//-----------------------------------------------------------------------------------------------------------
		// InterceptorRegistry 객체의 addInterceptor 메소드를 호출하여 SessionInterceptor 객체를 인터셉터로 등록하고
		// excludePathPatterns 메소드를 호출하여 예외되는 URL 주소 패턴을 등록한다.
		//---------------------------------
		registry.addInterceptor(new SessionInterceptor()).excludePathPatterns(
				
				"/loginForm.do"
				,"/loginProc.do"
				,"/logout.do"
				,"/memRegForm.do"
				,"/resources/**"
				
		);
		
	}
}
/*
========================================================================
	인터셉터(Interceptor)란?
===================================
	웹서버에 URI 로 접근하여 컨트롤러 클래스의 메소드가 호출되는데
	컨트롤러 클래스의 메소드가 호출되기 전 또는 호훌 후에 호출되는 메소드를 소유하고 있는 객체를 말한다.
	컨트롤러 클래스의 URI 에 접근 전 또는 후에 무언가를 제어할 필요가 있을 때 사용된다.
========================================================================
	Spring에서 빈(Bean)이란?
===================================
	Spring 에서 POJO(Plain, Old Java Object)를 Bean 이라고 부른다.
	Beans는 애플리케이션의 핵심을 이루는 객체이며, Spring IoC(Inversion of Control) 컨테이너에 의해 인스턴스화, 관리, 생성된다.
========================================================================
	@Configuration 이란?
===================================
	클래스를 빈으로 등록하는 annotation이다.
========================================================================
	[HandlerInterceptor 인터페이스 구현 객체]의 메소드 종류와 호출 시점
===================================
	preHandle()			: 컨트롤러 클래스의 메소드 실행 전에 호출. boolean 값을 return 하며 Controller 클래스의 특정 메소드 실행 여부를 결정
	postHandle()		: 컨트롤러 클래스의 메소드 실행 후, JSP  를 실행 전에 호출
	afterCompletion()	: 컨트롤러 클래스의 메소드 실해 후, JSP  를 실행 후 호출됨. responseBody를 이용할 경우 값을 Client에게 전달 후 호출
	















 */


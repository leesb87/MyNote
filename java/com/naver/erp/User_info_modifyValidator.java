package com.naver.erp;


import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// User_info_modifyValidator 클래스는 유효성을 주로하는 클래스다
// User_info_modifyDTO 객체에 저장된 데이터의 유효성 체크할 User_info_modifyValidator 클래스 선언하기.    
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class User_info_modifyValidator implements Validator {
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	//유효성 체크할 객체의 클래스 타입 정보 얻어 리턴하기
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	@Override
	public boolean supports(Class<?> arg0) {
		return User_info_modifyDTO.class.isAssignableFrom(arg0); //검증할 객체의 클래스 타입 정보
	}
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	//유효성 체크할 메소드 선언하기
	//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
	@Override
	public void validate(
		  Object obj                         // DTO 객체 저장 매개변수   Object 젤 위에 조상님 같은 존재
		  ,Errors errors                     // 유효성 검사 시 발생하는 에러 관리하는 Errors 객체 저장 매개변수  
	){	
		 try{
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			//유효성 체크할 DTO 객체 얻기
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			 User_info_modifyDTO dto =(User_info_modifyDTO)obj;
		     
		/*
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// [ 비밀번호 ]  Errors 객체의저장하기
			//-------------------------------------------------------------------------------------------- 
		   
		    ValidationUtils.rejectIfEmptyOrWhitespace( 
		    		errors                                             // Errors 객체
		           ,"pwd"                                              // User_infoDTO 속성변수명
		           ,"비밀번호를 입력해주세요."                         // User_infoDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을 때 경고 문구 
		     );
		    
             String pwd = dto.getPwd();          
	          if(pwd!=null &&  Pattern.matches("^[a-zA-Z0-9]{6,13}$",pwd)==false){
		    	 errors.rejectValue(
	    			 "pwd"                                             // DTO 객체의 속성변수명
	    			 , "비밀번호는 영문 대소문, 숫자 포함(6~13자리)로 입력하세요"         	   // 경고문구
		    	 ); 
		     
		      }  
		 */     	              		   	 
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// [ 유저명 ]  Errors 객체의저장하기
			//-------------------------------------------------------------------------------------------- 
		      ValidationUtils.rejectIfEmptyOrWhitespace( 
		    		errors                                             // Errors 객체
		           ,"user_name"                                        // User_infoDTO 속성변수명
		           ,"유저명을 입력해주세요."                           // User_infoDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을 때 경고 문구 
		      );  
		      //-------------------------------------------------------------------------------------------
             String user_name = dto.getUser_name();          
              if(user_name!=null &&  Pattern.matches("^[가-힣a-zA-Z0-9]{1,10}$",user_name)==false){
		    	 errors.rejectValue(
	    			 "user_name"                                                   // DTO 객체의 속성변수명
	    			 , "유저명은 영문 대소문자,한글, 숫자를 포함(1~10자리)로 입력하세요"        // 경고문구
		    	 ); 
		  
              }      
	      
			//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			// [이메일 ]  Errors 객체의저장하기
			//-------------------------------------------------------------------------------------------- 
	  	      ValidationUtils.rejectIfEmptyOrWhitespace( 
	  	    		errors                                             // Errors 객체
	  	           ,"email"                                        	   // User_infoDTO 속성변수명
	  	           ,"이메일을 입력해주세요."                           // User_infoDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을 때 경고 문구 
	  	      );  
	  	    //-------------------------------------------------------------------------------------------
		  	//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		  	// [ 주소 ]  Errors 객체의저장하기
		  	//-------------------------------------------------------------------------------------------- 
	  	 	  ValidationUtils.rejectIfEmptyOrWhitespace( 
	  	 	    		errors                                             // Errors 객체
	  	 	           ,"addr"                                        // User_infoDTO 속성변수명
	  	 	           ,"주소를 입력해주세요."                           // User_infoDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을 때 경고 문구 
	  	 	   );  
	              
			 }catch(Exception ex) {
			   System.out.println("User_info_modifyValidator.validate 메소드 실행 시  예외발생!");	
			}
 
		}
	
	}

 


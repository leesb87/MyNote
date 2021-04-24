package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

//***********************************************************
// [서비스 클래스]인 [LoginServiceImpl 클래스] 선언          =DB연동 지시한다.
//***********************************************************
	// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
	//--------------------------------------------------------
	// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
	// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
    // @Transactional = 뺴버리면 예외발생도 인정해버리기 떄문에 꼭 넣어야한다. 
@Service
@Transactional
public class AdminServiceImpl implements AdminService{
	  //************************************************
	  //속성변수 boardDAO 선언하고, [BoardDAO 인터페이스]를 구현한 클래스를 객체화해서 저장한다.
	  //************************************************
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	  //************************************************
	  @Autowired
	  private  AdminDAO  adminDAO;	
     

	 //**************************************************
     // [검색한 회목 목록  입력 적용 행의 개수] 리턴하는 메소드 선언
     //**************************************************   
	    public  List<Map<String, String>> getAdminList(AdminSearchDTO adminSearchDTO){
	    	System.out.println("AdminServiceImpl.getAdminList 진입 성공....." );	
	    	List<Map<String,String>> adminList  =this.adminDAO.getAdminList(adminSearchDTO);
			
	    	System.out.println("AdminServiceImpl.getAdminList 실행 성공....." );	
			 return adminList;  
	      }
	 

   

	    //**************************************************
	     // [검색한 회원 목록] 바디없는 메소드 선언
	     //**************************************************   
		public int getAdminAllCnt(AdminSearchDTO adminSearchDTO) {
			System.out.println("AdminServiceImpl.getAdminAllCnt 진입 성공....." );	
	    	int adminAllCnt  =this.adminDAO.getAdminAllCnt(adminSearchDTO);
			
	    	System.out.println("AdminServiceImpl.getAdminAllCnt 실행 성공....." );	
			 return adminAllCnt;  
	      }
			
			
			
		public int accessUpdate(HashMap map) {
						
			int updateCnt = this.adminDAO.accessUpdate( map );
			
			return updateCnt;
			
		}
			
			

   
     
     
}
  
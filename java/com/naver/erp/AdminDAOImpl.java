package com.naver.erp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class AdminDAOImpl implements AdminDAO{
  //************************************************
  //속성변수 sqlSession 선언하고, [SqlSessionTemplate 객체]를 생성해서 저장
  //************************************************
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [클래스]면 이를 객체화하여 저장한다.    
	        //************************************************
@Autowired
//  SqlSessionTemplate 는 클래스이다.      
private SqlSessionTemplate sqlSession;	

   //*********************************************************************************************************************
   // [게시판 목록 보기] 리턴하는 메소드 선언
   // selectList 메소드 = n행n열을 검색 
   //**************************************************  
    public List<Map<String,String>> getAdminList(AdminSearchDTO adminSearchDTO){
         //-----------------------------------------------------	
    	 System.out.println("AdminDAOImpl getAdminList 검색한 게시판 목록의 총개수 진입 성공"); 
    	 //-----------------------------------------------------	
    	 List<Map<String,String>> adminList  =this.sqlSession.selectList(  
    			 "com.naver.erp.AdminDAO.getAdminList"   	       //실행할 SQL 구문의 위치 지정 getUserAccessList
                  ,adminSearchDTO
    			 ); 	
    	//-----------------------------------------------------	
    	 System.out.println("AdminDAOImpl getAdminList 검색한 게시판 목록의 총개수 진입 성공"); 
    	//-----------------------------------------------------	
    return adminList;  
    }
    
  
  //************************************************
  // [검색한 회원 목록의 총개수] 리턴하는 메소드 선언
  //************************************************ 
	public int getAdminAllCnt(AdminSearchDTO adminSearchDTO) {
		//-----------------------------------------------------	
		System.out.println("AdminDAOImpl getAdminAllCnt 검색한 게시판 목록의 총개수 진입 성공"); 
		//-----------------------------------------------------	
		int adminAllCnt  = 0;
		adminAllCnt  = this.sqlSession.selectOne(  			
			 "com.naver.erp.AdminDAO.getAdminAllCnt"   	       //실행할 SQL 구문의 위치 지정 getUser_accesstAllCnt
              ,adminSearchDTO
			 ); 	
		//-----------------------------------------------------	
		System.out.println("AdminDAOImpl getAdminAllCnt 검색한 게시판 목록의 총개수 진입 성공"); 
		//-----------------------------------------------------	
    return adminAllCnt;  
    }   
	
	
	
	public int accessUpdate(HashMap map) {
		
		int updateCnt = 0; 
		
		updateCnt = this.sqlSession.update(  			
				 "com.naver.erp.AdminDAO.accessUpdate"   	       //실행할 SQL 구문의 위치 지정 getUser_accesstAllCnt
	              ,map
				 ); 
		
		return updateCnt;
	}
	
	
	
	
}

package com.naver.erp;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//***********************************************************
// [DAO 클래스] 인 [BoardDAOImpl 클래스] 선언
//***********************************************************
	// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
	//--------------------------------------------------------
	// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
	// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.

@Repository
public class User_info_modifyDAOImpl implements User_info_modifyDAO{
  //************************************************
  //속성변수 sqlSession 선언하고, [SqlSessionTemplate 객체]를 생성해서 저장
  //************************************************
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [클래스]면 이를 객체화하여 저장한다.    
	        //************************************************
@Autowired
private SqlSessionTemplate sqlSession;	
		    
		//--------------------------------------------------------
		// [회원 정보] 리턴 메소드 선언
		//--------------------------------------------------------
		public User_info_modifyDTO getUser_info(String user_id){
			
			System.out.println("User_info_modifyDAOImpl/ getUser_info 진입성공  ");
			
			User_info_modifyDTO user_info  = this.sqlSession.selectOne(
					"com.naver.erp.User_info_modifyDAO.getUser_info"	
					,user_id
			);

			System.out.println("User_info_modifyDAOImpl/ getUser_info DB연동성공  ");
			return user_info;	
		}
		
		
		//**************************************************
		// 수정 하기 전 게시물이 존재하는지 확인하는 갯수를 리턴하는 메소드 선언
		//**************************************************
		public   int  getUser_infoCnt(User_info_modifyDTO user_info_modifyDTO) {
			
			System.out.println("User_info_modifyDAOImpl/ getUser_infoCnt 진입성공  ");
			 
			int user_infoCnt = this.sqlSession.selectOne(
					  
					  "com.naver.erp.User_info_modifyDAO.getUser_infoCnt" 
					  ,user_info_modifyDTO 
			); 
			
			System.out.println("User_info_modifyDAOImpl/ getUser_infoCnt DB연동성공 ");
			 return user_infoCnt; 
		}
		

		//-------------------------------------------------
		//  수정 실행하고 수정 적용행의 갯수를 리턴하는 메소드 선언
		//-------------------------------------------------
		  public int update_user_info(User_info_modifyDTO user_info_modifyDTO) {
			  
			  System.out.println("User_info_modifyDAOImpl/ update_user_info 진입성공  ");
		  
			  int userReg_modifyCnt = this.sqlSession.update(
					  "com.naver.erp.User_info_modifyDAO.update_user_info" 
					  ,user_info_modifyDTO 
			  ); 
			  System.out.println("User_info_modifyDAOImpl/ update_user_info DB연동성공  ");
			  return userReg_modifyCnt; 
		  }
		  
		 //=====================================
		 // 등록요청된 데이터의 중복개수를 리턴하는 메소드 선언
		 //=====================================
		public int getVerifyCnt(Map<String,String> verify_idJumin){		
			
			System.out.println("User_info_modifyDAOImpl/ getVerifyCnt 진입성공  ");
			
			int verifyCnt = this.sqlSession.selectOne(
					"com.naver.erp.User_info_modifyDAO.getVerifyCnt" 
					,verify_idJumin				
			);		
			
			System.out.println("User_info_modifyDAOImpl/ getVerifyCnt DB연동성공  ");
			
			return verifyCnt;
			
		}
		
 }

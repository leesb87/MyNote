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
public class User_infoDAOImpl implements User_infoDAO{
  //************************************************
  //속성변수 sqlSession 선언하고, [SqlSessionTemplate 객체]를 생성해서 저장
  //************************************************
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [인터페이스]를 구현한 [클래스]를 객체화하여 저장한다.
	        //@Autowired 역할 -> 속성변수에 붙은 자료형인 [클래스]면 이를 객체화하여 저장한다.    
	        //************************************************
@Autowired
private SqlSessionTemplate sqlSession;	


		    
		//--------------------------------------------------------
		// [회원가입 성공여부] 리턴하는 메소드 선언
		//--------------------------------------------------------
		public int insertMember(User_infoDTO user_infoDTO){
			
			int user_infoRegCnt = 0;
			
			user_infoRegCnt = sqlSession.insert(
					"com.naver.erp.User_infoDAO.insertMember"	//실행할 SQL구문의 위치 저장
					,user_infoDTO								//실행할 SQL구문에서 사용할 데이터 지정
					);
		
			System.out.println( "User_infoDAOImpl.insertMember 실행 성공 / user_infoRegCnt : " + user_infoRegCnt);	
			
		return user_infoRegCnt;
			
		}
	
 
		//**************************************************
		// [회원 관리 성공 개수]  리턴하는 메소드 선언 
		//**************************************************
		public int insertAccess(User_infoDTO user_infoDTO) {
			
	    int user_accessCnt = 0;
			
	    user_accessCnt = sqlSession.insert(
					"com.naver.erp.User_infoDAO.insertAccess"	//실행할 SQL구문의 위치 저장
					,user_infoDTO								//실행할 SQL구문에서 사용할 데이터 지정
					);
		
			System.out.println( "User_infoDAOImpl.insertMember 실행 성공 / user_infoRegCnt : " + user_accessCnt);	
			
		return user_accessCnt;
			
		}
			
			
			
			
			
	
          
          
          
		//=====================================
		// 등록요청된 데이터의 중복개수를 리턴하는 메소드 선언
		//=====================================
		public int getVerifyCnt(Map<String,String> verify_idJumin){
		//DAO클래스에게 DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
			//+++++++++++++++++++++++++++++++++++++++++++
			// memberDAOImpl객체의 getAdminIdCnt메소드 호출하여 ID,암호 존재개수를 얻기
			//+++++++++++++++++++++++++++++++++++++++++++				
			int idCnt = this.sqlSession.selectOne(
					"com.naver.erp.User_infoDAO.verifyIdJumin" // xml파일 내부의 쿼리문의 위치 지정
					,verify_idJumin				
					);					
		//-----------------------------------------------
		// 아이디, 또는 주민번호의 존재개수를 리턴하기
		//-----------------------------------------------
		return idCnt;
			
		}
		
}

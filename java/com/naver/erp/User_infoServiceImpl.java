package com.naver.erp;

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
public class User_infoServiceImpl implements User_infoService{

	  @Autowired
	  private User_infoDAO user_infoDAO;	

	 
		 //**************************************************
		 // [회원가입 정보의 개수] 리턴하는 메소드 선언
		 //**************************************************
		public int insertMember(User_infoDTO user_infoDTO		    
		){
			//DAO클래스에게 DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
			System.out.println("User_infoServiceImpl 진입성공 / user_infoRegCnt : " + user_infoDTO);
			//String user_name = user_infoDTO.getUser_name();
			//System.out.println("User_infoServiceImpl 진입성공 user_name : " + user_name);
			int incertCnt = 0;
			int user_infoRegCnt = 0;
			int user_accessCnt = 0;
			
			user_infoRegCnt = this.user_infoDAO.insertMember(user_infoDTO);
			
			
			user_accessCnt = this.user_infoDAO.insertAccess(user_infoDTO);
			
			
			System.out.println("User_infoServiceImpl 실행성공 / user_infoRegCnt : " + user_infoRegCnt   + "/" +    user_accessCnt);
			
			
			incertCnt =  user_infoRegCnt +user_accessCnt;
			return incertCnt;
				
			}

    
	 
	  
	  
		//=====================================
		// 등록요청된 데이터의 중복개수를 리턴하는 메소드 선언
		//=====================================
		public int getVerifyCnt(
				Map<String,String> verify_idJumin 
			){
		//DAO클래스에게 DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
			//+++++++++++++++++++++++++++++++++++++++++++
			// LoginDAOImpl객체의 getAdminIdCnt메소드 호출하여 ID,암호 존재개수를 얻기
			//+++++++++++++++++++++++++++++++++++++++++++				
		 int idCnt = this.user_infoDAO.getVerifyCnt(verify_idJumin);
		//-----------------------------------------------
		// 아이디, 암호 존재개수를 리턴하기
		//-----------------------------------------------
		return idCnt;
			
		}
		


}
  
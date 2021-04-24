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
public class User_info_modifyServiceImpl implements User_info_modifyService{

	  @Autowired
	  private User_info_modifyDAO user_info_modifyDAO;	

	 
		 //**************************************************
		 // [회원수정 정보의 게시물] 리턴하는 메소드 선언
		 //**************************************************
		public User_info_modifyDTO getUser_info (String user_id){
			
			User_info_modifyDTO user_info  = this.user_info_modifyDAO.getUser_info(user_id);
			return user_info;	
		}	
		
		//**************************************************
		// [회원수정 정보의 개수] 리턴하는 메소드 선언
		//**************************************************
		public int update_user_info(User_info_modifyDTO user_info_modifyDTO		    
		){
			
			System.out.println("User_info_modifyServiceImpl 진입성공  ");
	
			int updateCnt = 0;
			int user_modifyCnt = 0;
			
			//게시물 존재 갯수
			int user_infoCnt = this.user_info_modifyDAO.getUser_infoCnt(user_info_modifyDTO);
			
			// 수정성공 행의 갯수
			user_modifyCnt = this.user_info_modifyDAO.update_user_info(user_info_modifyDTO);
		
			System.out.println("User_info_modifyServiceImpl DB실행성공" );
			
			return user_modifyCnt;
				
		} 
		//=====================================
		// 등록요청된 데이터의 중복개수를 리턴하는 메소드 선언
		//=====================================
		public int getVerifyCnt(
				Map<String,String> verify_idJumin 
			){
					
		 int verifyCnt = this.user_info_modifyDAO.getVerifyCnt(verify_idJumin);
		//-----------------------------------------------
		// 아이디, 암호 존재개수를 리턴하기
		//-----------------------------------------------
		return verifyCnt;
			
		}
		

}
  
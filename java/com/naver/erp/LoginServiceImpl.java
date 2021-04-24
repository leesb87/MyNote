package com.naver.erp;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

	//***********************************************************
	// [서비스 클래스]인 [LoginServiceImpl 클래스] 선언
	//***********************************************************
		// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
		//--------------------------------------------------------
		// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
		// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.
@Service
@Transactional
	public class LoginServiceImpl implements LoginService{
		//=======================================
		//속성변수 loginDAO 선언하고 LoginDAO라는 인터페이스를
		//구현한 클래스를 객체화하여 저장	
		//=======================================
			// @@Autowired이 붙은 속성변수에는 인터페이스 자료형을 쓰고
			// 이 인터페이스를 구현한 클래스를 객체화하여 저장한다.
			// LoginDAO라는 인터페이스를 구현한 클래스의 이름을 몰라도 관계없다.
			// 1개 존재하기만 하면 된다.
        //=======================================
		@Autowired
		public LoginDAO loginDAO;
		//private LoginDAOImpl loginDAO = new LoginDAOImpl();
			
		//=====================================
		// 로그인 정보의 개수를 리턴하는 메소드 선언
		//=====================================
		public int getAdminIdCnt(
				Map<String,String> id_pwd 
			){
		
		//------------------------------------------------------
	    // LoginDAOImpl 객체의 getAdminIdCnt 메소드를 호출하여 아이디 암호 존개 개수를 얻기  //DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
	    //------------------------------------------------------
		int adminCnt = this.loginDAO.getAdminIdCnt(id_pwd);
		if(adminCnt==1){return 2;}
	
		//------------------------------------------------------
		//회원 아이디 암호 존재 개수 리턴하기
		//------------------------------------------------------
		int userinfoCnt = this.loginDAO.getUserinfoCnt(id_pwd);
		return userinfoCnt;
		}




		//=====================================
		// 유저명을 리턴하는 바디없는 메소드 선언
		//=====================================
		public String getUser_name(String id) {
// System.out.println("LoginServiceImpl getUser_name 진입 성공"+"/"  + id );	

			String user_name="";
			user_name = this.loginDAO.getUser_name(id);
			
// System.out.println("LoginServiceImpl getUser_name 실행 성공"+"/"  + id +"/"  + user_name  );				
         return	user_name;
		}


		
		public String getAcc_read(String id){
			 String acc_read="";
			 acc_read = this.loginDAO.getAcc_read(id);
         return	acc_read;
		}
		
		
		public String getAcc_upDel(String id){
			String acc_upDel="";
			acc_upDel = this.loginDAO.getAcc_upDel(id);		
         return	acc_upDel;
		}
		
		
		
		public String getAcc_write(String id){
			String acc_write="";
			acc_write = this.loginDAO.getAcc_write(id);	
         return	acc_write;
		}






}

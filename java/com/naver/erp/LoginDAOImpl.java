package com.naver.erp;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//+++++++++++++++++++++++++++++++++++++++
// @Repositary를 붙임으로서 [DAO클래스]임을 지정하게 되고, bean태그로 자동등록
//+++++++++++++++++++++++++++++++++++++++
@Repository
public class LoginDAOImpl implements LoginDAO{

	//+++++++++++++++++++++++++++++++++++++++
	// SqlSessionTemplate객체를 생성해 속변 sqlSession에 저장
	// @Autowired 어노테이션을 붙이면 자료형에 맞는 SqlSessionTemplate 객체를 생성한다.
	//+++++++++++++++++++++++++++++++++++++++
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getAdminIdCnt( 
		//----------------------------------------------------------
	    // 매개변수로 클라이언트가 입력한 아이디와 암호가 저장된 HashMap 객체가 들어온다.
		// <참고>Map 인터페이스를 구현한 HashMap 클래스이다.
	    //       그러므로 HashMap 객체가 들어와도 자료형은 Map 을 쓸 수있다.
		//----------------------------------------------------------		
	    Map<String,String> id_pwd ){	
		// mybatis에게 DB연동지시 내리고 ID,암호의 존재개수를 얻기	
		
		//---------------------------------------
		// SqlSessionTemplate 객체의 selectOne메소드 호출로
		// Myabatis 프레임워크가 관리하는 SQL구문을 호출하여
		// 1행의 데이터인 [로그인 아이디, 암호존재개수]를 얻기
		//---------------------------------------
		//---------------------------------------
		//selectOne("com.naver.erp.LoginDAO.getAdminIdCnt", admin_id_pwd)의 의미
		//---------------------------------------
			// mybatis SQL구문 설정 XML파일(=mapper_login.xml)에서
			// <mapper namespace="com.naver.erp.LoginDAO">태그 내부의
			// <select id="getAdminCnt" ~ > 태그 내부의
			// [1행리턴 select 쿼리문]을 실행하고 얻은 데이터를 int로 리턴
			// 2번재 인자는 [1행리턴 select쿼리문]에 삽입될 데이터이다.
			// 리턴자료형은 무조건 int이다.		
			// 1행 1열  = int, double, String
	        // 1행 n열  = HashMap, DTO 
		    //---------------------------------------	
		//com.naver.erp.LoginDAO이라는 네임값의 getAdminIdCnt라는 애 있어?
		int adminCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getAdminIdCnt" // xml파일 내부의 select쿼리문의 위치 지정
				,id_pwd		  //참여할 데이터		
				);
			return adminCnt;					
	   }	

	//----------------------------------------------------------
    // 회원 아이디, 비밀번호 존재의 개수를 없는 리턴하는 메소드 선언
	//----------------------------------------------------------
	public int getUserinfoCnt(Map<String, String> id_pwd){
		int userCnt = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getUserinfoCnt" // xml파일 내부의 select쿼리문의 위치 지정
				,id_pwd		  //참여할 데이터		
				);
			return userCnt;					
	   }	

	//----------------------------------------------------------
    // 유저명을 리턴하는 메소드  선언
	//----------------------------------------------------------
	public String getUser_name(String id) {	
		System.out.println("LoginDAOImpl getUser_name 진입 성공"+"/"  + id );	
		String user_name = this.sqlSession.selectOne(
				"com.naver.erp.LoginDAO.getUser_name" // xml파일 내부의 select쿼리문의 위치 지정
				,id		  //참여할 데이터		
				);
		
	   System.out.println( "LoginDAOImpl getUser_name 실행 성공"  +"/" + id +"/" +user_name );	
			
			return user_name;					
	   }

		   //------------------------------------------------------------------------	
			public String getAcc_read(String id) {	
				System.out.println("LoginDAOImpl getAcc_read 진입 성공"+"/"  + id );	
				String acc_read = this.sqlSession.selectOne(
						"com.naver.erp.LoginDAO.getAcc_read" // xml파일 내부의 select쿼리문의 위치 지정
						,id		  //참여할 데이터		
						);
				
			   System.out.println( "LoginDAOImpl getAcc_read 실행 성공"  +"/" + id +"/" + acc_read );	
					
					return acc_read;					
			   }



		 //------------------------------------------------------------------------	
			public String getAcc_upDel(String id) {	
				System.out.println("LoginDAOImpl getAcc_upDel 진입 성공"+"/"  + id );	
				String acc_upDel = this.sqlSession.selectOne(
						"com.naver.erp.LoginDAO.getAcc_upDel" // xml파일 내부의 select쿼리문의 위치 지정
						,id		  //참여할 데이터		
						);
				
			   System.out.println( "LoginDAOImpl getAcc_upDel 실행 성공"  +"/" + id +"/" + acc_upDel );	
					
					return acc_upDel;					
			   }

		//------------------------------------------------------------------------	
				public String getAcc_write(String id) {	
					System.out.println("LoginDAOImpl getAcc_write 진입 성공"+"/"  + id );	
					String acc_write = this.sqlSession.selectOne(
							"com.naver.erp.LoginDAO.getAcc_write" // xml파일 내부의 select쿼리문의 위치 지정
							,id		  //참여할 데이터		
							);
					
				   System.out.println( "LoginDAOImpl getAcc_write 실행 성공"  +"/" + id +"/" + acc_write );	
						
						return acc_write;					
				   }






}

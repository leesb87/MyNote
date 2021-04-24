package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAOImpl implements MemberDAO{

@Autowired
private SqlSessionTemplate sqlSession;	

			
		//--------------------------------------------------------
		// [회원가입 성공여부] 리턴하는 메소드 선언
		//--------------------------------------------------------
		public int insertMember(MemberDTO memberDTO){
			
			int memberRegCnt = 0;
			
			memberRegCnt = sqlSession.insert(
					"com.naver.erp.MemberDAO.insertMember"	//실행할 SQL구문의 위치 저장
					,memberDTO								//실행할 SQL구문에서 사용할 데이터 지정
					);

			System.out.println( "MemberDAOImpl.insertMember 실행 성공 / memberRegCnt : " + memberRegCnt);	
			
		return memberRegCnt;
			
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
					"com.naver.erp.MemberDAO.verifyIdJumin" // xml파일 내부의 쿼리문의 위치 지정
					,verify_idJumin				
					);					
		//-----------------------------------------------
		// 아이디, 또는 주민번호의 존재개수를 리턴하기
		//-----------------------------------------------
		return idCnt;
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}

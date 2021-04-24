package com.naver.erp;

//import java.util.List;
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
public class MemberServiceImpl implements MemberService{
	
@Autowired
private MemberDAO memberDAO;	
		
	public int insertMember(MemberDTO memberDTO){
		//DAO클래스에게 DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
		
		String username = memberDTO.getUsername();
		System.out.println("MemberDAO 진입성공 username : " + username);
		
		int memberRegCnt = 0;
		memberRegCnt = this.memberDAO.insertMember(memberDTO);
			
		System.out.println("MemberDAO 실행성공 / memberRegCnt : " + memberRegCnt);
		return memberRegCnt;
			
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
	 int idCnt = this.memberDAO.getVerifyCnt(verify_idJumin);
	//-----------------------------------------------
	// 아이디, 암호 존재개수를 리턴하기
	//-----------------------------------------------
	return idCnt;
		
	}
	

	
	
	
	
	
	
	
	
	
}

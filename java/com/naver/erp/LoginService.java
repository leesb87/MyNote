package com.naver.erp;

import java.util.Map;

public interface LoginService {

	//=====================================
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	//=====================================
	public int getAdminIdCnt(
			//매개변수로 클라이언트가 입력한 ID,암호가 저장된 HashMap객체가 들어온다.
			//<참고>Map인터페이스를 구현한 클래스가 HashMap이다.
			//따라서, HashMap객체가 들어와도 자료형은 Map으로 할 수 있다.
			Map<String,String> id_pwd

	);
	//=====================================
	// 유저명을 리턴하는 바디없는 메소드 선언
	//=====================================
	public String getUser_name(String id);
	
	public String getAcc_read(String id);
	
	public String getAcc_upDel(String id);
	
	public String getAcc_write(String id);
	
}

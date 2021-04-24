package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

//*********************************************
// [BoardService인터페이스] 선언         
// 구현받은 고유메소드는 호출 불가능하게 하려고  (=신입들이 막 메소드를 추가할수도 있어서막음)
//*********************************************
public interface User_infoService {

	
	 
	 //**************************************************
	 // [회원가입 정보의 개수] 바디없는 메소드 선언 
	 //**************************************************
	public int insertMember(User_infoDTO user_infoDTO);
	 //**************************************************
	 // [로그인ID,암호의 존재개수 얻기] 바디없는 메소드 선언 
	 //**************************************************
	public int getVerifyCnt(Map<String, String> verify_idJumin);


	
}

package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

	//*********************************************
	// [BoardService인터페이스] 선언         
	// 구현받은 고유메소드는 호출 불가능하게 하려고  (=신입들이 막 메소드를 추가할수도 있어서막음)
	//*********************************************
	public interface User_info_modifyService {
		 //**************************************************
		 // [회원 정보]  가져오는 바디없는 메소드 선언 
		 //**************************************************
		 User_info_modifyDTO getUser_info(String user_id);
		 //**************************************************
		 // [회원 정보 수정] 실행하고 수정 적용행의 갯수를 리턴하는 메소드 선언
		 //**************************************************
		 int update_user_info(User_info_modifyDTO user_info_modifyDTO);

		 //**************************************************
		 // [회원 정보 수정] 시 중복확인 메소드 선언
		 //**************************************************
		 int getVerifyCnt(Map<String, String> verify_idJumin);
		
	}

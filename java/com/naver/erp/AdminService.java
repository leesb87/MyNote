package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

//*********************************************
// [BoardService인터페이스] 선언         
// 구현받은 고유메소드는 호출 불가능하게 하려고  (=신입들이 막 메소드를 추가할수도 있어서막음)
//*********************************************
public interface AdminService {
	 
	
     //**************************************************
     // [회원 정보 글] 바디없는 메소드 선언
     //**************************************************   
	public List<Map<String, String>> getAdminList(AdminSearchDTO adminSearchDTO);
	 
	 
	

     //**************************************************
     // [검색한 회원 목록] 바디없는 메소드 선언
     //**************************************************   
	public int getAdminAllCnt(AdminSearchDTO adminSearchDTO);




	public int accessUpdate(HashMap map);
	  
	
	


	
}

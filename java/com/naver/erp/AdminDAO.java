package com.naver.erp;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

//*********************************************
//[BoardDAO 인터페이스] 선언
//*********************************************
public interface AdminDAO {
     
	   //************************************************
	   // [회목 목록 리스트]  바디없는 메소드 선언
	   //************************************************
	    public List<Map<String, String>> getAdminList(AdminSearchDTO adminSearchDTO);
       
	    
	  //************************************************
	  // [검색한 회원 목록의 총개수] 바디없는 메소드 선언
	  //************************************************ 
		public int getAdminAllCnt(AdminSearchDTO adminSearchDTO);


		public int accessUpdate(HashMap map);
	   
	  	   
}

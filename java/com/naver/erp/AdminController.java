package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
// URL주소로 접속하면 호출되는 메소드를 소유한 [컨트롤러 클래스] 선언
// @Controller를 붙임으로서 [컨트롤러 클래스]임을 지정한다.
//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
@Controller
public class AdminController {
	
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	HttpServletRequest request;
	
	//****************************************************
	// 가상주소 /erp/userAccessForm.do로 접근하면 호출되는 메소드 선언
	//****************************************************
	@RequestMapping(value="/adminForm.do")	// start.jsp로부터 접근
    public ModelAndView getAdminList(
    		AdminSearchDTO adminSearchDTO
    		,HttpSession session 
    		){	
		System.out.println("AdminController getAdminAllCnt 진입성공");
		System.out.println("AdminController getAdminList 진입성공");
		
		//******************************************
		// [검색한 회원 목록]얻기
		//******************************************
		 int adminAllCnt = this.adminService.getAdminAllCnt( adminSearchDTO ); 
		//***************************************
		//[선택된 페이지 번호] 보정하기
		//*************************************** 
		 
		 if( adminAllCnt>0) {
				int beginRowNo= adminSearchDTO.getSelectPageNo()*adminSearchDTO.getRowCntPerPage()
						          -adminSearchDTO.getRowCntPerPage()+1;
				//[시작행번호] > [총검색 개수] 일 경우
				     //[선택된 페이지 번호]를 1로하고 검색 행의 [시작행 번호]를 1로하기
				 if(adminAllCnt < beginRowNo){
					 adminSearchDTO.setSelectPageNo(1);
				   }
			} 
	
		
		//******************************************
		// [ 회원 정보 글]을 얻기
		//******************************************
		 //System.out.println("adminSearchDTO =>" + adminSearchDTO.getOrderby());
		  List<Map<String,String>> adminList = this.adminService.getAdminList(adminSearchDTO); 
					
		
		//---------------------------------------------
		// [ModelAndView객체] 생성하기
		// [ModelAndView객체]에 [호출 JSP페이지명]을 저장하기
		// [ModelAndView객체] 리턴하기
		//---------------------------------------------

	 	  
	     ModelAndView mav = new ModelAndView();
		mav.setViewName("adminForm.jsp");
		mav.addObject("adminList",adminList);	
		mav.addObject("adminAllCnt",adminAllCnt);	
		System.out.println("AdminController getAdminList 실행성공");
		System.out.println("AdminController getAdminAllCnt 실행성공");
		return mav;			
	}	
	
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	
	@RequestMapping(value="/accessUpdateProc.do"
					,method=RequestMethod.POST
					,produces="application/json;charset=UTF-8"
			)
	@ResponseBody
	public int accessUpdate(
			@RequestParam(value="user_no") String user_no	
			,@RequestParam(value="columnN") String columnN
			,@RequestParam(value="updateV") String updateV
    		){

		
		// System.out.println("user_no+1 : " + user_no +  "columnN : " + columnN +  "updateV : " + updateV );
		
		
		HashMap map = new HashMap();
		map.put("user_no", user_no);
		map.put("columnN", columnN);
		map.put("updateV", updateV);
		
		int updateCnt = 0;
		
		updateCnt = this.adminService.accessUpdate( map );
		
		return updateCnt;
		
	}
	
	
	
	
	
	

		
}

package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StaffServiceImpl implements StaffService{


	@Autowired
	private StaffDAO staffDAO;	
	
	
	public List<Map<String,String>> getStaffList(StaffSearchDTO staffSearchDTO) {
	
	System.out.println("staffService 진입 성공");
	
	List<Map<String,String>> staffList = this.staffDAO.getStaffList(staffSearchDTO);
	
	System.out.println("staffService 메소드 호출 성공");
	
	return staffList;	
	}
	
	
	public int getStaffListAllCnt(StaffSearchDTO staffSearchDTO){
		
		int staffListAllCnt = this.staffDAO.getStaffListAllCnt(staffSearchDTO);
		return staffListAllCnt;
	}
	
		
}

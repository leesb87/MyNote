package com.naver.erp;

import java.util.List;
import java.util.Map;

public interface StaffService {

	
	public List<Map<String,String>> getStaffList(StaffSearchDTO staffSearchDTO);
	
	public int getStaffListAllCnt(StaffSearchDTO staffSearchDTO);
	
	
}

package com.naver.erp;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class StaffDAOImpl implements StaffDAO{

	@Autowired
	private SqlSessionTemplate sqlSession;	
	
	public List<Map<String,String>> getStaffList(StaffSearchDTO staffSearchDTO) {
	
		List<Map<String,String>> staffList = this.sqlSession.selectList(
				"com.naver.erp.StaffDAO.getStaffList" //실행할 SQL 구문의 위치 지정
				,staffSearchDTO );
	return staffList;	
	}
	
	
	public int getStaffListAllCnt(StaffSearchDTO staffSearchDTO){
		
		int staffListAllCnt = this.sqlSession.selectOne(
				"com.naver.erp.StaffDAO.getStaffListAllCnt"		
				,staffSearchDTO);
		return staffListAllCnt;
	}
	
	
		
}

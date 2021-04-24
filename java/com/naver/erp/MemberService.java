package com.naver.erp;

import java.util.Map;

public interface MemberService {

	
	public int insertMember(MemberDTO memberDTO);
	
	
	public int getVerifyCnt(
			Map<String,String> verify_idJumin 
		);
	
	
}

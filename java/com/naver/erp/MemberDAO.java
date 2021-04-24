package com.naver.erp;

import java.util.Map;

public interface MemberDAO {

	public int insertMember(MemberDTO memberDTO);
	
	public int getVerifyCnt(
			Map<String,String> verify_idJumin 
		);
}

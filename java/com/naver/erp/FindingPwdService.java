package com.naver.erp;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//import java.util.Map;

@Service
@Transactional
public class FindingPwdService {

	//=====================================
	// 로그인 정보의 개수를 리턴하는 메소드 선언
	//=====================================
	public String findingPwd(
			//매개변수로 클라이언트가 입력한 ID,암호가 저장된 HashMap객체가 들어온다.
			//<참고>Map인터페이스를 구현한 클래스가 HashMap이다.
			//따라서, HashMap객체가 들어와도 자료형은 Map으로 할 수 있다.
			String admin_id_pwd

	) {
		String findingPwd="123";
		return findingPwd;
	}
	
}

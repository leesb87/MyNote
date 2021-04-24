package com.naver.erp;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// BoardDTO객체에 저장된 데이터의 유효성체크를 실행할 BoardValidator클래스 선언하기
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class DictValidator implements Validator{


	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	// 유효성을 체크할 객체의 클래스타입 정보를 얻어 리턴하기
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	@Override
	public boolean supports(Class<?> arg0) {
		return DictDTO.class.isAssignableFrom(arg0); //검증할 객체의 클래스타입 정보
	}
	
	@Override
	public void validate(
			Object obj			// DTO객체 저장 매개변수
			, Errors errors		// 유효성검사시 발생하는 에러를 관리하는 Errors객체 저장 매개변수
			) {
		try {
		//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
		//유효성 체크할 DTO객체 얻기
		//WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
		DictDTO dto = (DictDTO)obj;
		
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// ValidationUtils클래스의 rejectIfEmptyOrWhitespace메소드를 호출하여
		// DictDTO객체의 속성변수명 register가 비거나 공백으로 구성되어 있으면
		// 경고메시지를 Error객체에 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		ValidationUtils.rejectIfEmptyOrWhitespace( // static 메소드이므로 객체화가 필요없다.
				errors				//Errors객체
				,"register"			//DictDTO객체의 속성변수명
				,"작성자명을 입력해 주십시오."		//DictDTO객체의 속성변수명이 비거나 공백으로 구성되어있을 때의 경고문구
				);
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// DictDTO객체의 속성변수명 "register"가 저장된 데이터의 길이가 10자보다 크면
		// Errors객체에 속성변수명 "register"과 경고메시지 저장하기 / 현재 session에서 ID값을 입력하므로 비활성화
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		String register = dto.getRegister();
		if(register!=null && register.length()>20) {
			errors.rejectValue(
					"register"							//DTO객체의 속성변수명
					,"작성자명은 20자 이하로 입력가능합니다."		//경고문구
					);
		}
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// ValidationUtils클래스의 rejectIfEmptyOrWhitespace메소드를 호출하여
		// DictDTO객체의 속성변수명 subject가 비거나 공백으로 구성되어 있으면
		// 경고메시지를 Error객체에 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		ValidationUtils.rejectIfEmptyOrWhitespace( // static 메소드이므로 객체화가 필요없다.
				errors				//Errors객체
				,"lang_code"		//DictDTO객체의 속성변수명
				,"언어코드를 입력해 주십시오"		//DictDTO객체의 속성변수명이 비거나 공백으로 구성되어있을 때의 경고문구
				);
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// DictDTO객체의 속성변수명 "lang_code"가 저장된 데이터의 길이가 10자보다 크면
		// Errors객체에 속성변수명 "lang_code"과 경고메시지 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		String lang_code = dto.getLang_code();
		if(lang_code!=null && Pattern.matches("^[0-4]{1}$", lang_code)==false) {
			errors.rejectValue("lang_code", "언어코드는 4 이하의 숫자코드입니다.");
				}
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// ValidationUtils클래스의 rejectIfEmptyOrWhitespace메소드를 호출하여
		// DictDTO객체의 속성변수명 email이 비거나 공백으로 구성되어 있으면
		// 경고메시지를 Error객체에 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		ValidationUtils.rejectIfEmptyOrWhitespace( // static 메소드이므로 객체화가 필요없다.
				errors								//Errors객체
				,"word"								//DictDTO객체의 속성변수명
				,"노트에 저장할 단어를 입력해 주십시오."		//DictDTO객체의 속성변수명이 비거나 공백으로 구성되어있을 때의 경고문구
				);
				//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
				// DictDTO객체의 속성변수명 "content"가 저장된 데이터의 길이가 10자보다 크면
				// Errors객체에 속성변수명 "content"과 경고메시지 저장하기
				//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
				String word = dto.getWord();
				if(word!=null && word.length()>20) {
					errors.rejectValue(
							"word"							//DTO객체의 속성변수명
							,"단어는 20자 이하로 입력가능합니다."	//경고문구
							);
		}
		
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// ValidationUtils클래스의 rejectIfEmptyOrWhitespace메소드를 호출하여
		// DictDTO객체의 속성변수명 content가 비거나 공백으로 구성되어 있으면
		// 경고메시지를 Error객체에 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		ValidationUtils.rejectIfEmptyOrWhitespace( // static 메소드이므로 객체화가 필요없다.
				errors						//Errors객체
				,"content"					//DictDTO객체의 속성변수명
				,"노트 내용을 입력해 주십시오."		//DictDTO객체의 속성변수명이 비거나 공백으로 구성되어있을 때의 경고문구
				);
				//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
				// DictDTO객체의 속성변수명 "content"가 저장된 데이터의 길이가 10자보다 크면
				// Errors객체에 속성변수명 "content"과 경고메시지 저장하기
				//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
				String content = dto.getContent();
				if(content!=null && content.length()>150) {
					errors.rejectValue(
							"content"							//DTO객체의 속성변수명
							,"노트 내용은 150자까지 입력 가능합니다."		//경고문구
							);
		}
	
				
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// ValidationUtils클래스의 rejectIfEmptyOrWhitespace메소드를 호출하여
		// BoardDTO객체의 속성변수명 pwd가 비거나 공백으로 구성되어 있으면
		// 경고메시지를 Error객체에 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		ValidationUtils.rejectIfEmptyOrWhitespace( // static 메소드이므로 객체화가 필요없다.
				errors						//Errors객체
				,"note_no"					//BoardDTO객체의 속성변수명
				,"중복확인을 진행해 주십시오."		//BoardDTO객체의 속성변수명이 비거나 공백으로 구성되어있을 때의 경고문구
				);
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
		// BoardDTO객체의 속성변수명 "writer"가 저장된 데이터의 길이가 10자보다 크면
		// Errors객체에 속성변수명 "writer"과 경고메시지 저장하기
		//nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn
			String note_no = dto.getNote_no()+"";
			if(note_no!=null && Pattern.matches("^[0-9]{1,10}$", note_no)==false) {
				errors.rejectValue("note_no", "노트 코드는 1~10자리의 숫자입니다. 중복확인을 진행해 주세요.");
					}
	
		}catch(Exception ex) {
			System.out.println("DictValidator.validate메소드 실행시 예외발생!");
		
			
			}
		}
	
	
	
}

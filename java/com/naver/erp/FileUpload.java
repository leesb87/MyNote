package com.naver.erp;

import java.io.File;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// Spring에서 파일업로드하는 사용자정의 클래스 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class FileUpload {
	//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	// 속성변수 선언
	// <참고> 클래스 내부의 모든 멤버가 공유하는 변수가 속성변수이다.
	//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	private MultipartFile multipartFile;			// 파일업로드 기능이 있는 MultipartFile객체 속성변수
	//      ▲ MultipartFile인터페이스는 Spring에서 제공하는 자료저장 객체의 뼈대이다.		
	private String uploadDir;						// 업로드된 파일이 저장되는 서버측 운영체제상 폴더경로
	private String newFileName;						// 업로드된 파일의 새로운 이름
	private File file;								// 파일 또는 폴더를 관리하는 File객체가 저장될 속성변수
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN	
	// 객체생성시 호출되는 생성자 선언
	// 생성자가 호출되면서 외부에서 데이터가 객체 내부로 주입된다.
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	public FileUpload() {}
	//		↕ 생성자 Overloading, 메소드명이 같아야 하고, 매개변수의 개수가 다르거나 매개변수의 개수가 동일할 경우 자료형이 달라야 한다.
	public FileUpload(
			MultipartFile multipartFile	// 업로드된 파일을 관리하는 MultipartFile객체
			,String uploadDir			// 업로드된 파일을 저장할 폴더명
			) throws Exception {
		//매개변수로 들어온 uploadDir 내부의 데이터를 속성변수 uploadDir로 저장하기 
		this.uploadDir = uploadDir;
		//매개변수로 들어온 multipartFile 내부의 데이터를 속성변수 multipartFile로 저장하기
		this.multipartFile = multipartFile;
		// 만약 매개변수 multipartFile 안의 데이터가 null값이 아니면,
		// 즉 외부에서 MultipartFile객체가 매개변수로 들어온다면
		if( multipartFile!=null && multipartFile.isEmpty()==false) {
			//동료메소드 upLoadFile을 호출하기
			upLoadFile();
		}
	}
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	// 파일 업로드 실행 메소드 선언
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	public void upLoadFile() throws Exception{ //try-catch구문을 직접 실행할 경우 ajax측에서 에러가 발생하므로
		//try{								   //  throws Exception으로 메소드를 호출한 곳에서 에러를 알린다.
		//---------------------------------------------------------------------------
		// MultipartFile객체의 getOriginalFilename메소드를 호출하여 업로드된 파일의 이름을 얻기
		//---------------------------------------------------------------------------
		String ori_file_name = multipartFile.getOriginalFilename();
		//---------------------------------------------------------------------------
		// 업로드된 파일의 확장자 얻기
		//---------------------------------------------------------------------------
		String file_extension = ori_file_name.substring(ori_file_name.lastIndexOf(".")+1);
		//---------------------------------------------------------------------------
		// UUID클래스의 randomUUID() 메소드를 호출하여 유일한 파일이름을 만들기
		// 새로 얻은 파일이름에 확장자를 부여하여 새로운 파일명을 만들고 newFileName변수에 저장하기
		//---------------------------------------------------------------------------
		newFileName = UUID.randomUUID() + "."+file_extension;
		//===================================
		// 새로운 파일명에 해당하는 파일을 만드는 File객체를 생성하기
		//---------------------------------------------------------------------------
		file = new File( uploadDir + newFileName );
		//---------------------------------------------------------------------------
		// MultipartFile객체가 관리하는 업로드파일을 새롭게 생성한 파일에 덮어씌우기
		// 즉, 업로드된 파일의 일므이 변경된다.
		//---------------------------------------------------------------------------
		multipartFile.transferTo(file);
		//===================================
		System.out.println( "<파일업로드 성공> " + uploadDir + newFileName + "파일!\n");
		//}catch(Exception e){
			//System.out.println( "<예외발생장소> FileUpload 클래스 upLoadFile 메소드!\n" );
			//System.out.println( "<예외발생사유> 비정상적인 파일업로드 경로 " + uploadDir );
			//newFileName = null;
			//file = null;
		//}
	}
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	// 파일 업로드시 만들어진 새로운 파일명 리턴메소드 선언
	// 리턴된 새로운 파일명이 DB에 저장될 예정이다. ★
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	public String getNewFileName() {
		return newFileName;		
	}
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	// 업로드된 파일 삭제하기 메소드 선언 - DB연동결과 게시글이 등록되지 않았을 경우 등
	// 업로드 프로세스 중인 업로드파일을 지울 때 사용되는 메소드이다.
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	public void delete() {
		if(file!=null) {
			file.delete();
			System.out.println("<파일 삭제 성공> " + newFileName + "파일!\n");
		}
	}
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	// 매개변수로 전달된 파일 삭제하는 메소드 선언
	// 이미 업로드되어있는 파일을 지울 때 사용된 메소드이다.
	//NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
	public void delete(String file_name) {
		// 만약 매개변수 file_name이 null이거나 비었으면 메소드 중단
		if( file_name==null || file_name.isEmpty() ) {
			return;
		}
		//---------------------------------------------
		// 매개변수로 들어온 파일을 관리하는 File객체 생성하기
		//---------------------------------------------
		File file2 = new File(file_name);
		//---------------------------------------------
		// File객체가 관리하는 파일이 실제로 존재하면 파일 삭제하기
		//---------------------------------------------
		if(file2.isFile() ) {
			file2.delete();
			System.out.println( "<파일 삭제 성공> " + file_name + " 파일!\n");
		}
	}
	
	
	
	
}

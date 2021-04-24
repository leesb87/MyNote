package com.naver.erp;

import java.io.File;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
// Spring에서 파일업로드하는 사용자정의 클래스 선언
//MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
public class FileUpload3 {
	
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 속성변수 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	
	private MultipartFile multipartFile;	// 파일업로드 관리하는 MultipartFile객체 저장예정
	private String fileUploadDir;			// 업로드파일의 젖아폴더명
	private String newFileName;				// 업로드파일의 새로운 파일명 저장예정
	private String delFileName;				// 삭제할 파일의 파일명 저장 예정
	private File file;						// 파일 또는 폴더를 관리하는 File객체 저장예정

	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
	// 생성자 선언
	//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm	

	public FileUpload3() {}
	public FileUpload3(
			MultipartFile multipartFile		// 업로드된 파일을 관리하는 MultipartFile객체 저장 매개변수
			,String fileUploadDir			// 업로드된 파일을 저장할 폴더명 저장 매개변수
			,String delFileName				// 삭제할 파일명의 저장 매개변수
			) throws Exception {
		this.fileUploadDir = fileUploadDir;
		this.multipartFile = multipartFile;
		this.delFileName = delFileName;
		//-----------------------------------------------------------------
		if( delFileName != null && delFileName.isEmpty()==false ) {
			if( new File( fileUploadDir + delFileName).isFile()==false  ) {
				throw new Exception();
			}
		}
		//-----------------------------------------------------------------
		if( multipartFile != null && multipartFile.isEmpty()==false ) {
			String ori_file_name = multipartFile.getOriginalFilename();
			String file_extension = ori_file_name.substring(ori_file_name.lastIndexOf(".")+1);
			newFileName = UUID.randomUUID() + "." + file_extension;
			}
		}
	
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
		// 파일 업로드 실행 메소드 선언
		//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm		
		public void upLoadFile() throws Exception{ 	//try-catch구문을 직접 실행할 경우 ajax측에서 에러가 발생하므로
			 										//  throws Exception으로 메소드를 호출한 곳에서 에러를 알린다.
			if( multipartFile != null &&  multipartFile.isEmpty()==false) {

				// 새로운 파일명에 해당하는 파일을 만드는 File객체를 생성하기
				//---------------------------------------------------------------------------
				file = new File( fileUploadDir + newFileName );
				//---------------------------------------------------------------------------
				// MultipartFile객체가 관리하는 업로드파일을 새롭게 생성한 파일에 덮어씌우기
				// 즉, 업로드된 파일의 일므이 변경된다.
				//---------------------------------------------------------------------------
				multipartFile.transferTo(file);
				//===================================
				if( delFileName != null && delFileName.isEmpty()==false) {
					delete(fileUploadDir + delFileName);
				}
			System.out.println( "<파일업로드 성공> " + fileUploadDir + newFileName + "파일!\n");
			}
		}
		
		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		// 파일 업로드시 만들어진 새로운 파일명 리턴 메소드 선언
		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		public String getNewFileName() {
			return newFileName;
		}

		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		// 업로드된 파일 삭제하기 메소드 선언
		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		public void delete() {
			if( file != null) {
				file.delete();
				System.out.println( "<파일 삭제 성공> " + newFileName + " 파일!\n");
			}			
		}
		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		// 매개변수로 전달되는 파일명의  파일 삭제하기 메소드 선언
		//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		public void delete(String file_name) {
			if( file_name == null || file_name.isEmpty() ) { return; }
			
			File file2 = new File( file_name );
			if( file2.isFile() ) {
				file2.delete();
				System.out.println("<파일 삭제 성공> " + file_name + " 파일!\n");
				
			}
						
		}	






}

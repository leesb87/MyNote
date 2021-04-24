 package com.naver.erp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;



//***********************************************************
// [서비스 클래스]인 [LoginServiceImpl 클래스] 선언
//***********************************************************
	// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
	//--------------------------------------------------------
	// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
	// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.


@Service
@Transactional
public class DictServiceImpl implements DictService{
	
	@Autowired
	private DictDAO dictDAO;
	
//===<dictList>==========================================================================================		
	
	// 통합검색으로 검색된 목록 리턴받는 메소드 선언
	@Override
	public List<Map<String, String>> getDictList_total(DictSearchDTO dictSearchDTO) {
		
		System.out.println( "SelectPageNo(Service) => "+ dictSearchDTO.getSelectPageNo()+"  "+"RowCntPerPage(Service) => "+dictSearchDTO.getRowCntPerPage() );
		
		System.out.println("keyword(Service) : " + dictSearchDTO.getKeyword() );
		
		List<Map<String, String>> dictList_total = this.dictDAO.getDictList_total( dictSearchDTO );
		
		return dictList_total;
	}
	 
	// 통합검색으로 검색된 목록 개수 리턴받는 메소드 선언
	@Override
	public int getDictListAllCnt_total(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_total = this.dictDAO.getDictListAllCnt_total( dictSearchDTO );
		
		return dictListAllCnt_total;
	}

	// [더보기 n행m열 사전 목록 가저오기] 리턴하는 메소드 선언
	@Override
	public List<Map<String, String>> getDictContent(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> dictList_content = this.dictDAO.getDictContent( dictSearchDTO );
		
		return dictList_content;
	}
	
	// [더보기 n행m열 사전 목록 개수 가저오기] 리턴하는 메소드 선언
	@Override
	public int getContentAllCnt(DictSearchDTO dictSearchDTO) {
		
		int dictList_contentAllCnt = this.dictDAO.getContentAllCnt( dictSearchDTO );
		
		return dictList_contentAllCnt;
	}
	

//===<mynote + user_options>=======================================================
	
	@Override
	public List<Map<String, String>> getMynote(DictSearchDTO dictSearchDTO) {

		List<Map<String, String>> mynoteList = this.dictDAO.getMynote( dictSearchDTO );
		return mynoteList;
	
	}

	@Override
	public int getMynoteCnt(DictSearchDTO dictSearchDTO) {

		int mynoteCnt = this.dictDAO.getMynoteCnt( dictSearchDTO );
		return mynoteCnt;
	
	}

	//=====================================
	// MYNOTE 관련 DAO클래스의 메소드로 HashMap객체를 전달하는 메소드 선언 [[4/5]]]
	//=====================================
	
	//선택된 꼬리글이 이미 Mynote에 저장되어 있는지 확인하고
	//저장되어 있지 않으면 checkMynoteCnt==0
	@Override
	public int insertMynote(Map<String, String> map) {
		int checkMynoteCnt = this.dictDAO.checkMynote(map);
		int updateCnt = 0;
		if(checkMynoteCnt==0) {	 //해당 꼬리글의 mynote값을 0에서 1로 변경하기
					updateCnt = this.dictDAO.updateMynote(map);
					if(updateCnt!=1) {	//업데이트 성공값이 1이 아니면(업데이트에 성공한 행이 없다면
										//새로운 일련번호로 mynote 저장하기
						checkMynoteCnt = this.dictDAO.doMynote(map);}
					else {
						return 1;
					}
		}else {	// checkMynoteCnt가 0이 아닐 경우
			return -1;	//-1 리턴하기
		}
		
		return checkMynoteCnt;
	}
	//=====================================
	// MYNOTE 등록 철회 관련 DAO클래스의 메소드로 HashMap객체를 전달하는 메소드 선언 [[4/5]]]
	//=====================================
	@Override
	public int turnOffMynote(Map<String, String> map) {
		
		int turnOffMynoteCnt = this.dictDAO.turnOffMynote(map);
		
		return turnOffMynoteCnt;
	}

	
	
//====================<dictUpDelForm>>===============================================	
	//=====================================================================
	// 꼬리글의 수정/삭제를 리턴하는 메소드 선언
	//=====================================================================
	 public int upDelNote(DictDTO dictDTO, String upDel) {
	      
	      int upDelCnt = 0;
	      //=====================================================================
	      // upDel의 문자데이터에 따라 수정/삭제를 진행
	      //=====================================================================
	      if(upDel.equals("up") ) {
	         upDelCnt = this.dictDAO.updateNote(dictDTO);         
	      }else {
	         
	         //=====================================================================
	         //수정/삭제하려는 꼬리글이 이미 삭제처리된 꼬리글인지 확인하는 함수 호출하고 리턴값을 학인하여 
	         //"0"이 아니면 -1을 리턴하여 이미 삭제되었음을 알리고 메소드 종료
	         //=====================================================================
	         int checkDisabled = this.dictDAO.checkDisabled(dictDTO);
	         if( checkDisabled!=0) { System.out.println("upDelNote : " + checkDisabled); return -1;}
	         
	         
	         upDelCnt = this.dictDAO.deleteNote(dictDTO);
	      }
	      
	      return upDelCnt;
	      
	   }   
		
	//=====================================
	// 추천하기 메소드 선언
	//=====================================
	public int doRecommend(Map<String,String> map) {
		int rec_cnt = this.dictDAO.checkRecommend(map);
		int cnt = 0;
		int rec_YN = 0;
		if(rec_cnt==1) {
			cnt = -1;
		}
		else if(rec_cnt==0){
			rec_YN = this.dictDAO.doRecommend(map);
			System.out.println(rec_YN);
			cnt = this.dictDAO.updateRate_cnt(map);
		}
		System.out.println(cnt);
		return cnt;
	}
	

//===<dictRegForm>==========================================================================================	 	
	//=====================================
	// 단어의 존재여부를 확인하는 메소드 선언
	//=====================================
	public int checkWord(	Map<String,String> map	){
	//DAO클래스에게 DB연동 지시를 내리고 ID,암호의 존재개수를 얻기
		//+++++++++++++++++++++++++++++++++++++++++++
		// LoginDAOImpl객체의 getAdminIdCnt메소드 호출하여 ID,암호 존재개수를 얻기
		//+++++++++++++++++++++++++++++++++++++++++++				
	int checkNo = this.dictDAO.checkWord(map);
	//-----------------------------------------------
	// CORE테이블의 단어 고유번호를 리턴하기
	//-----------------------------------------------
	return checkNo;
		
	}
	
	public int insertNewWord(DictDTO dictDTO) {
		//-----------------------------------------------
		// CORE테이블에 저장된 행 수를 참조하는 변수 incertCnt 선언
		//-----------------------------------------------
		int insertCnt = 0;
		int note_no = dictDTO.getNote_no();		
		// CORE테이블, DICT(사전)테이블에 저장된 행 수를 참조할 변수 NewCoreCnt, NewNoteCnt 선언
		int insertNewCoreCnt = 0;
		int insertNewNoteCnt = 0;
		//-----------------------------------------------
		// CORE테이블에서 가져온 단어중복행의 번호가 0일 때( = 새 노트 작성 모드일 때)	[transaction (A)]
		// CORE테이블에 새 단어 행을 저장하고 저장 행의 개수를 얻기
		//-----------------------------------------------
		if( note_no ==0 ) {
			System.out.println("DictDAO insertNewCore 메소드 진입 성공!");
			insertNewCoreCnt = this.dictDAO.insertNewCore(dictDTO);
		}
		//-----------------------------------------------
		// lang_code의 값에 의해 정의된 사전 테이블에 입력한 단어를 저장하는 nybatis구문으로
		// DTO클래스르를 전달하고, 저장 행의 개수를 얻기
		//-----------------------------------------------		
			System.out.println("DictDAO insertNewWord 메소드 진입 성공!");
			insertNewNoteCnt = this.dictDAO.insertNewNote(dictDTO);
		
			insertCnt = insertNewCoreCnt + insertNewNoteCnt;
			return insertCnt;
	}


	
	
}


/*
	// 한국어, 검색된 목록 리턴받는 메소드 선언
	@Override
	public List<Map<String, String>> getDictList_kor( DictSearchDTO dictSearchDTO ) {
		
		List<Map<String, String>> dictList_kor = this.dictDAO.getDictList_kor( dictSearchDTO );
	
		return dictList_kor;
	}
	

	// 한국어, 검색된 목록 개수 리턴받는 메소드 선언
	@Override
	public int getDictListAllCnt_kor(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_kor = this.dictDAO.getDictListAllCnt_kor( dictSearchDTO );
		
		return dictListAllCnt_kor;
	}
	
	// 영어, 검색된 목록 리턴받는 메소드 선언
	@Override
	public List<Map<String, String>> getDictList_eng(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> dictList_eng = this.dictDAO.getDictList_eng( dictSearchDTO );
		
		return dictList_eng;
	}

	// 영어,검색된 목록 개수 리턴받는 메소드 선언
	@Override
	public int getDictListAllCnt_eng(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_eng = this.dictDAO.getDictListAllCnt_eng( dictSearchDTO );
		
		return dictListAllCnt_eng;
	}
	
	// 일본어, 검색된 목록 리턴받는 메소드 선언
	@Override
	public List<Map<String, String>> getDictList_jpn(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> dictList_jpn = this.dictDAO.getDictList_jpn( dictSearchDTO );
		
		return dictList_jpn;
	}		

	// 일본어,검색된 목록 개수 리턴받는 메소드 선언
	@Override
	public int getDictListAllCnt_jpn(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_jpn = this.dictDAO.getDictListAllCnt_jpn( dictSearchDTO );
		
		return dictListAllCnt_jpn;   
	}

	// 중국어, 검색된 목록 리턴받는 메소드 선언
	@Override
	public List<Map<String, String>> getDictList_cn(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> dictList_cn = this.dictDAO.getDictList_cn( dictSearchDTO );
		
		return dictList_cn;
		
	}

	// 중국어,검색된 목록 개수 리턴받는 메소드 선언
	@Override
	public int getDictListAllCnt_cn(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_cn = this.dictDAO.getDictListAllCnt_cn( dictSearchDTO );
		
		return dictListAllCnt_cn;
	}
*/
//------------------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------------------------	
	// [Tab 검색 한국어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
/*	@Override
	public List<Map<String, String>> getTabDictList_kor(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> tabDictList_kor = this.dictDAO.getTabDictList_kor( dictSearchDTO );
		
		return tabDictList_kor;
		
	}
	
	// [Tab 검색 한국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	@Override
	public int getTabDictListAllCnt_kor(DictSearchDTO dictSearchDTO) {
		
		int dictListAllCnt_kor = this.dictDAO.getTabDictListAllCnt_kor( dictSearchDTO );
		
		return dictListAllCnt_kor;
	}

	
	// [Tab 검색 n행m열 영어 게시판 목록 가져오기] 리턴하는 메소드 선언
	@Override
	public List<Map<String, String>> getTabDictList_eng(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> tabDictList_eng = this.dictDAO.getTabDictList_eng( dictSearchDTO );
		
		return tabDictList_eng;
	}

	// [Tab 검색 영어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	@Override
	public int getTabDictListAllCnt_eng(DictSearchDTO dictSearchDTO) {
		
		int tabDictListAllCnt_eng = this.dictDAO.getTabDictListAllCnt_eng( dictSearchDTO );
		
		return tabDictListAllCnt_eng;
	}

	// [Tab 검색 일본어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	@Override
	public List<Map<String, String>> getTabDictList_jpn(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> tabDictList_jpn = this.dictDAO.getTabDictList_jpn( dictSearchDTO );
		
		return tabDictList_jpn;
	}

	// [Tab 검색 일본어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	@Override
	public int getTabDictListAllCnt_jpn(DictSearchDTO dictSearchDTO) {
		
		int tabDictListAllCnt_jpn = this.dictDAO.getTabDictListAllCnt_jpn( dictSearchDTO );
		
		return tabDictListAllCnt_jpn;
	}

	// [Tab 검색 n행m열 중국어 게시판 목록 가져오기] 리턴하는 메소드 선언
	@Override
	public List<Map<String, String>> getTabDictList_cn(DictSearchDTO dictSearchDTO) {
		
		List<Map<String, String>> tabDictList_cn  = this.dictDAO.getTabDictList_cn( dictSearchDTO );
		
		return tabDictList_cn ;
	}

	// [Tab 검색 중국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	@Override
	public int getTabDictListAllCnt_cn(DictSearchDTO dictSearchDTO) {
		
		int tabDictListAllCnt_cn  = this.dictDAO.getTabDictListAllCnt_cn( dictSearchDTO );
		
		return tabDictListAllCnt_cn ;
	}
*/

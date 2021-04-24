package com.naver.erp;

import java.util.List;
import java.util.Map;


//*********************************************
// [BoardService인터페이스] 선언
//*********************************************
public interface DictService {

//==NOTEHOUSE!!==<mynoteForm>==========이 길을 따라 mapper까지 가주세요!============================		
	
		// 계정명으로 저장된 mynote 페이지 HTML을 가져오는 메소드 선언
		public List<Map<String, String>> getMynote( DictSearchDTO dictSearchDTO );	
		// 계정명으로 저장된 mynote 테이블 수를 가져오는 메소드 선언
		public int getMynoteCnt( DictSearchDTO dictSearchDTO );	
		
		// [[[[4/5]]] MYNOTE 추가에 관련된 DAO클래스로 HashMap객체를 전달하는 메소드 선언
		public int insertMynote(Map<String, String> map);

		// [[[4/5]]]] MYNOTE 등록 철회에 관련된 DAO클래스로 HashMap객체를 전달하는 메소드 선언
		public int turnOffMynote(Map<String, String> map);	
		
		
		
		
		
		
		
		
//===<dictRegForm>==========================================================================================		
	//**************************************************
	// [게시판 글 입력 후 입력적용 행의 개수] 리턴하는 메소드 선언
	//**************************************************
	//public int insertBoard(BoardDTO boardDTO);

	//+++++++++++++++++++++++++++++++++++++++
	// [검색한 게시판 목록] 리턴하는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++	
	public int checkWord( Map<String,String> map );
		
	//+++++++++++++++++++++++++++++++++++++++
	// Controller로부터 DTO클래스를 넘겨받아 DAO클래스로 넘겨주는 메소드 선언
	//+++++++++++++++++++++++++++++++++++++++
	public int insertNewWord(DictDTO dictDTO);
	
//===<dictList>==========================================================================================	 

	// [통합검색 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언	
	List<Map<String, String>> getDictList_total(DictSearchDTO dictSearchDTO);

	
	// [통합검색 n행m열 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getDictListAllCnt_total(DictSearchDTO dictSearchDTO);
	
	// [더보기 n행m열 사전 목록 가저오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getDictContent(DictSearchDTO dictSearchDTO);
	
	// [더보기 n행m열 사전 목록 개수 가저오기] 리턴하는 메소드 선언
	public int getContentAllCnt(DictSearchDTO dictSearchDTO);
	
	// 추천하기
	public int doRecommend(Map<String,String> map);
    
//===<dictUpDelForm>======================================================================================
	
	// 꼬리글의 수정/삭제를 담당하는 메소드 선언
	public int upDelNote(DictDTO dictDTO, String upDel);
			
			
			
			
			
/*	
	// [통합검색 한국어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getDictList_kor(DictSearchDTO dictSearchDTO);

	
	// [통합검색 한국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getDictListAllCnt_kor(DictSearchDTO dictSearchDTO);

	
	// [통합검색 n행m열 영어 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getDictList_eng(DictSearchDTO dictSearchDTO);
	
	
	// [통합검색 영어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getDictListAllCnt_eng(DictSearchDTO dictSearchDTO);

	
	// [통합검색 일본어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
	List<Map<String, String>> getDictList_jpn(DictSearchDTO dictSearchDTO);
	
	
	// [통합검색 일본어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	int getDictListAllCnt_jpn(DictSearchDTO dictSearchDTO);

	
	// [통합검색 n행m열 중국어 게시판 목록 가져오기] 리턴하는 메소드 선언
	List<Map<String, String>> getDictList_cn(DictSearchDTO dictSearchDTO);

	
	// [통합검색 중국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	int getDictListAllCnt_cn(DictSearchDTO dictSearchDTO);
*/
	//------------------------------------------------------------------------------------------------	
/*	// [Tab 검색 한국어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getTabDictList_kor(DictSearchDTO dictSearchDTO);

	
	// [Tab 검색 한국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getTabDictListAllCnt_kor(DictSearchDTO dictSearchDTO);
	
	
	// [Tab 검색 n행m열 영어 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getTabDictList_eng(DictSearchDTO dictSearchDTO);
	
	
	// [Tab 검색 영어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getTabDictListAllCnt_eng(DictSearchDTO dictSearchDTO);
	
	// [Tab 검색 일본어 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getTabDictList_jpn(DictSearchDTO dictSearchDTO);

	
	// [Tab 검색 일본어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getTabDictListAllCnt_jpn(DictSearchDTO dictSearchDTO);
	
	
	// [Tab 검색 n행m열 중국어 게시판 목록 가져오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getTabDictList_cn(DictSearchDTO dictSearchDTO);
	
	
	// [Tab 검색 중국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getTabDictListAllCnt_cn(DictSearchDTO dictSearchDTO);
*/

			
}

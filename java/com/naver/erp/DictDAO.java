package com.naver.erp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

//***********************************************************
// [서비스 클래스]인 [BoardDAOImpl 클래스] 선언
//***********************************************************
	// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
	//--------------------------------------------------------
	// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
	// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.

@Repository
public interface DictDAO {
	
	
//===<dictRegForm>==========================================================================================		
	//--------------------------------------------------------
	// CORE테이블 내에 존재하는 입력 언어의 행 PK번호를 받아오는 메소드 선언
	//--------------------------------------------------------
		public int checkWord(Map<String,String> map	);
	
	//--------------------------------------------------------
	// CORE테이블에 입력한 단어 DTO를 mybatis로 전달하고 저장 행의 수를 받아오는 메소드 선언
	//--------------------------------------------------------
		public int insertNewCore(DictDTO dictDTO);
	//--------------------------------------------------------
	// lang_code로 선언되는 사전테이블에 입력한 단어 DTO를 mybatis로 전달하고 저장 행의 수를 받아오는 메소드 선언
	//--------------------------------------------------------
		public int insertNewNote(DictDTO dictDTO);
		
	//--------------------------------------------------------
	// 작성한 게시글을 MYNOTE에 저장하도록 mybatis에 DTO클래스를 넘겨주는 메소드 선언
	//--------------------------------------------------------		
		public int insertMynote(Map<String, String> map);	
		
		
//===<dictList>==========================================================================================	 

	// [통합검색 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언	
	List<Map<String, String>> getDictList_total(DictSearchDTO dictSearchDTO);

	
	// [통합검색 n행m열 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
	public int getDictListAllCnt_total(DictSearchDTO dictSearchDTO);
	
	// [더보기 n행m열 사전 목록 가저오기] 리턴하는 메소드 선언
	public List<Map<String, String>> getDictContent(DictSearchDTO dictSearchDTO);

	// [더보기 n행m열 사전 목록 개수 가저오기] 리턴하는 메소드 선언
	public int getContentAllCnt(DictSearchDTO dictSearchDTO);

	// 추천 흔적 찾기
	public int checkRecommend(Map<String,String> map);
	
	// 추천 흔적 남기기
	public int doRecommend(Map<String,String> map);
	
	// 추천수 업데이트
	public int updateRate_cnt(Map<String,String> map);

//===<dictUpDel>=========================================================================================
	
		//--------------------------------------------------
		// 수정/삭제 대상 꼬리글이 존재하는지(삭제처리되었는지) 확인하는 메소드 선언
		//--------------------------------------------------
		public int checkDisabled(DictDTO dictDTO);
		
		//--------------------------------------------------
		// 대상 꼬리글을 수정하는 SQL구문으로 DTO객체를 넘겨주는 메소드 선언
		//--------------------------------------------------
		public int updateNote(DictDTO dictDTO);			
		//--------------------------------------------------
		// 대상 꼬리글을 삭제하는 SQL구문으로 DTO객체를 넘겨주는 메소드 선언
		//--------------------------------------------------
		public int deleteNote(DictDTO dictDTO);

		
//==NOTEHOUSE=====<getMynote>======================================================================			
		
		// 계정명으로 저장된 MyNote 테이블을 가져오는 메소드 선언
		public List<Map<String, String>> getMynote(DictSearchDTO dictSearchDTO);

		// 꼬리글 추천 관련 DAO구문 ▼
		public int getMynoteCnt(DictSearchDTO dictSearchDTO);

		//===================================================
		// [[4/5]] 이미 Mynote에 등록된 꼬리글인지를 확인하는 메소드 선언
		//===================================================
		public int checkMynote(Map<String, String> map);
		//===================================================
		// 선택된 꼬리글 정보의 Mynote값이 0이면 1로 바꿔주는 메소드 선언
		public int updateMynote(Map<String, String> map);
		
		// 선택된 꼬리글을 mynote에 저장하는 메소드 선언
		public int doMynote(Map<String, String> map);
		
		// 선택된 꼬리글의 mynote등록을 철회하는 메소드 선언
		public int turnOffMynote(Map<String, String> map);
		//≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡≡


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
	// [Tab 검색 한국어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
/*	public List<Map<String, String>> getTabDictList_kor(DictSearchDTO dictSearchDTO);

	
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


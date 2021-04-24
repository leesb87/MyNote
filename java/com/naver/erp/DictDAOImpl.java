package com.naver.erp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

//***********************************************************
// [서비스 클래스]인 [BoardDAOImpl 클래스] 선언
//***********************************************************
	// [서비스 클래스]에는 @Service와 @Transactional을 붙인다.
	//--------------------------------------------------------
	// @Service		: [서비스 클래스]임을 지정하고 bean태그로 자동 등록된다.
	// @Transactional: [서비스 클래스]의 메소드 내부에서 일어나는 모든 작업에는 [트랜잭션]이 걸린다.

@Repository
public class DictDAOImpl implements DictDAO{
	
@Autowired
private SqlSessionTemplate sqlSession;	
		
//===<dictList>==========================================================================================	 

		// 통합 검색 눌렀을 때, 검색된 목록 리턴받는 메소드 선언
		@Override
		public List<Map<String, String>> getDictList_total( DictSearchDTO dictSearchDTO ) {
			System.out.println("DictListDAOImpl getDictList_total 메소드 진입성공!");
			
			List<Map<String,String>> dictList_total = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictList_total"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			System.out.println("검색결과 행의 개수확인(DAO) : "+dictList_total.size());
			System.out.println("keyword(DAO) : " + dictSearchDTO.getKeyword() );
			return dictList_total;
		}
		// 통합 검색 눌렀을 때, 검색된 목록 개수 리턴받는 메소드 선언
		@Override
		public int getDictListAllCnt_total( DictSearchDTO dictSearchDTO ) {
			System.out.println("DictListDAOImpl getDictList_total 메소드 진입성공!");
			
			 int dictListAllCnt_total = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getDictListAllCnt_total"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return dictListAllCnt_total;
		}
		
		// [더보기 n행m열 사전 목록 가저오기] 리턴하는 메소드 선언
		@Override
		public List<Map<String, String>> getDictContent(DictSearchDTO dictSearchDTO) {
			
			System.out.println("DictListDAOImpl getDictList_total 메소드 진입성공!");
			
			List<Map<String,String>> dictList_content = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictContent"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return dictList_content; 
		} 
		
		// [더보기 n행m열 사전 목록 개수 가저오기] 리턴하는 메소드 선언
		@Override
		public int getContentAllCnt(DictSearchDTO dictSearchDTO) {
			
			System.out.println("DictListDAOImpl getDictList_total 메소드 진입성공!");
			
			 int dictList_contentAllCnt = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getContentAllCnt"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return dictList_contentAllCnt;
		}
		// 추천 흔적 찾기
		public int checkRecommend(Map<String,String> map) {
			int rec_cnt = this.sqlSession.selectOne(
					"com.naver.erp.DictDAO.checkRecommend", // 실행할 SQL 구문의 위치 지정
					map                                 // 실행할 SQL 구문에서 사용할 데이터 지정
			);
			return rec_cnt;
		}

		// 추천 흔적 남기기
		public int doRecommend(Map<String,String> map) {
			int rec_YN = this.sqlSession.insert(
					"com.naver.erp.DictDAO.doRecommend", // 실행할 SQL 구문의 위치 지정
					map                                 // 실행할 SQL 구문에서 사용할 데이터 지정
			);
			return rec_YN;
		}

		// 추천수 업데이트
		public int updateRate_cnt(Map<String,String> map) {
			int cnt = this.sqlSession.update(
					"com.naver.erp.DictDAO.updateRate_cnt", // 실행할 SQL 구문의 위치 지정
					map                                      // 실행할 SQL 구문에서 사용할 데이터 지정
			);
			return cnt;
		}
		
	
		
//===<dictUpDelForm>========================================================================
		
				public int checkDisabled(DictDTO dictDTO) {
					
					int checkDisabled = this.sqlSession.selectOne(
							"com.naver.erp.DictDAO.checkDisabled"  // 실행할 SQL 구문의 위치 지정
							,dictDTO );
					return checkDisabled;
					
				};
				
				
				//--------------------------------------------------
				// 대상 꼬리글을 수정하는 SQL구문으로 DTO객체를 넘겨주는 메소드 선언
				//--------------------------------------------------
				public int updateNote(DictDTO dictDTO) {
					int updateCnt = this.sqlSession.update(
							"com.naver.erp.DictDAO.updateNote"  // 실행할 SQL 구문의 위치 지정
							,dictDTO );
					
					return updateCnt;
				};			
				
				//--------------------------------------------------
				// 대상 꼬리글을 삭제하는 SQL구문으로 DTO객체를 넘겨주는 메소드 선언
				//--------------------------------------------------
				public int deleteNote(DictDTO dictDTO) {
					
					int deleteCnt = this.sqlSession.insert(
							"com.naver.erp.DictDAO.deleteNote"  // 실행할 SQL 구문의 위치 지정
							,dictDTO );
					
					return deleteCnt;
				};	
		
		
//===<dictRegForm>==========================================================================================	

	//--------------------------------------------------------
	// [게시판 글 입력 후 입력 적용 행의 개수] 리턴하는 메소드 선언
	//--------------------------------------------------------
		public int checkWord( Map<String,String> map	){
		
		System.out.println( "DictDAOImpl.checkWord 진입 성공");
		
		//---------------------------------------------
		// SqlSessionTemplate 객체의 insert메소드 호출로
		// 게시판 글 입력 SQL구문을 실행하고 입력성공 행의 개수 얻기
		//---------------------------------------------
		//*********************************************
		// insert("com.naver.erp.BoardDAO.insertBoard", boardDTO ); 의미
		//*********************************************
			// mybatis SQL구문설정 XML파일에서
			// <mapper namespace="com.naver.BoardDAO>태그 내부의
			// <insert id="insertBoard" ~> 태그 내부의
			//insert쿼리문을 실행하고 입력 성공행의 개수를 얻기

		int checkNo = 0;
		checkNo = this.sqlSession.selectOne(
					"com.naver.erp.DictDAO.checkWord"	//실행할 SQL구문의 위치 저장
					,map									//실행할 SQL구문에서 사용할 데이터 지정
					);
//		System.out.println( "DictDAOImpl.checkWord 실행 성공");	
		return checkNo;
	}
		
		//--------------------------------------------------------
		// CORE테이블에 입력한 단어 DTO를 mybatis로 전달하고 저장 행의 수를 받아오는 메소드 선언
		//--------------------------------------------------------
		public int 	insertNewCore(DictDTO dictDTO) {
			int insertCnt =  this.sqlSession.insert(
					"com.naver.erp.DictDAO.insertNewCore"		//실행할 SQL구문의 위치 저장
					,dictDTO									//실행할 SQL구문에서 사용할 데이터 지정
					);
			return insertCnt;
		}
		
		//--------------------------------------------------------
		// lang_code로 선언되는 사전테이블에 입력한 단어 DTO를 mybatis로 전달하고 저장 행의 수를 받아오는 메소드 선언
		//--------------------------------------------------------		
		public int 	insertNewNote(DictDTO dictDTO) {
			int insertCnt =  this.sqlSession.insert(
					"com.naver.erp.DictDAO.insertNewNote"		//실행할 SQL구문의 위치 저장
					,dictDTO									//실행할 SQL구문에서 사용할 데이터 지정
					);
			return insertCnt;
		}

	
	
//==========▼ < Mynote 관련 메소드 > ▼==========

	//--------------------------------------------------------
	// 작성한 게시글을 MYNOTE에 저장하도록 mybatis에 DTO클래스를 넘겨주는 메소드 선언
	//--------------------------------------------------------		
		public int insertMynote(Map<String, String> map) {
			
			int insertCnt = this.sqlSession.insert(
					"com.naver.erp.DictDAO.insertMynote"	//실행할 SQL구문의 위치 저장
					,map										//실행할 SQL구문에서 사용할 데이터 지정
					);
			
			return insertCnt;
		}				
	
		
		public List<Map<String, String>> getMynote (DictSearchDTO dictSearchDTO){
			
			System.out.println("DictListDAOImpl getDictList_total 메소드 진입성공!");
			
			List<Map<String,String>> mynoteList = this.sqlSession.selectList(
					"com.naver.erp.DictDAO.getMynote"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			return mynoteList; 			
		}
		
		
		public int getMynoteCnt(DictSearchDTO dictSearchDTO) {
			
			int mynoteCnt = this.sqlSession.selectOne(
					"com.naver.erp.DictDAO.getMynoteCnt"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			return mynoteCnt;
		}
		
		//이미 Mynote에 등록된 꼬리글인지를 확인하는 메소드 선언
		@Override
		public int checkMynote(Map<String, String> map) {
			int checkMynoteCnt = this.sqlSession.selectOne(
					"com.naver.erp.DictDAO.checkMynote"  // 실행할 SQL 구문의 위치 지정
					,map);
			return checkMynoteCnt;
		}
		//선택된 꼬리글의 mynote값을 0에서 1로 업데이트해주는 메소드 선언
		@Override
		public int updateMynote(Map<String, String> map) {
			int updateCnt = this.sqlSession.update(
					"com.naver.erp.DictDAO.updateMynote"  // 실행할 SQL 구문의 위치 지정
					,map);
			return updateCnt;
		}
		//선택된 꼬리글을 등록해주는 메소드 선언
		@Override
		public int doMynote(Map<String, String> map) {
			int doMynoteCnt = this.sqlSession.insert(
					"com.naver.erp.DictDAO.doMynote"  // 실행할 SQL 구문의 위치 지정
					,map);
			return doMynoteCnt;		
		}
		//선택된 꼬리글의 mynote등록을 철회하는 메소드 선언
		@Override
		public int turnOffMynote(Map<String, String> map) {
			int turnOffCnt = this.sqlSession.update(
					"com.naver.erp.DictDAO.turnOffMynote"  // 실행할 SQL 구문의 위치 지정
					,map);
			return turnOffCnt;
		}	
		
		
	
}	

/*
		// 한국어 검색된 목록 리턴받는 메소드 선언
		@Override
		public List<Map<String, String>> getDictList_kor( DictSearchDTO dictSearchDTO ) {
			System.out.println("DictListDAOImpl getDictList_kor 메소드 진입성공!");
			
			List<Map<String,String>> dictList_kor = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictList_kor"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			//System.out.println("행의 개수확인"+dictList.size());
			return dictList_kor;
		}
		
		// 한국어 검색된 목록 개수 리턴받는 메소드 선언
		@Override
		public int getDictListAllCnt_kor(DictSearchDTO dictSearchDTO) {
			
			int dictListAllCnt_kor = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getDictListAllCnt_kor"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return dictListAllCnt_kor;
		}
		// 영어, 검색된 목록 리턴받는 메소드 선언
		@Override
		public List<Map<String, String>> getDictList_eng(DictSearchDTO dictSearchDTO) {
			System.out.println("DictListDAOImpl getDictList_eng 메소드 진입성공!");
			List<Map<String,String>> dictList_eng = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictList_eng"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			//System.out.println("영어 tab키 눌렀을 때 받는 행의 개수확인"+tabDictList_eng.size());
			return dictList_eng;
		}
		// 영어, 검색된 목록 개수 리턴받는 메소드 선언
		@Override
		public int getDictListAllCnt_eng(DictSearchDTO dictSearchDTO) {
			
			int dictListAllCnt_eng = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getDictListAllCnt_eng"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return dictListAllCnt_eng;
		} 
		// 일본어, 검색된 목록 리턴받는 메소드 선언
		@Override
		public List<Map<String, String>> getDictList_jpn(DictSearchDTO dictSearchDTO) {
			System.out.println("DictListDAOImpl getDictList_jpn 메소드 진입성공!");
			List<Map<String,String>> dictList_jpn = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictList_jpn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			//System.out.println("일본어 tab키 눌렀을 때 받는 행의 개수확인"+tabDictList_jpn.size());
			return dictList_jpn;
		}
		
		// 일본어, 검색된 목록 개수 리턴받는 메소드 선언
		@Override
		public int getDictListAllCnt_jpn(DictSearchDTO dictSearchDTO) {
			
			int dictListAllCnt_jpn = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getDictListAllCnt_jpn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return dictListAllCnt_jpn;  
		}    
		
		// 중국어, 검색된 목록 리턴받는 메소드 선언
		@Override
		public List<Map<String, String>> getDictList_cn(DictSearchDTO dictSearchDTO) {
			System.out.println("DictListDAOImpl getDictList_cn 메소드 진입성공!");
			List<Map<String,String>> dictList_cn = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getDictList_cn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			//System.out.println("중국어 tab키 눌렀을 때 받는 행의 개수확인"+tabDictList_cn.size());
			return dictList_cn;
		}
		
		// 중국어, 검색된 목록 개수 리턴받는 메소드 선언
		@Override
		public int getDictListAllCnt_cn(DictSearchDTO dictSearchDTO) {
			
			int dictListAllCnt_cn = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getDictListAllCnt_cn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return dictListAllCnt_cn; 
		} 
*/ 	
		
//--------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------
/*		// [Tab 검색 한국어 n행m열 게시판 목록 가져오기] 리턴하는 메소드 선언
		@Override
		public List<Map<String, String>> getTabDictList_kor(DictSearchDTO dictSearchDTO) {
			
			List<Map<String,String>> tabDictList_kor  = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getTabDictList_kor"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return tabDictList_kor;
		}
		// [Tab 검색 한국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
		@Override
		public int getTabDictListAllCnt_kor(DictSearchDTO dictSearchDTO) {
			
			int tabDictListAllCnt_kor  = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getTabDictListAllCnt_kor"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return tabDictListAllCnt_kor ; 
		}
		// [Tab 검색 n행m열 영어 게시판 목록 가져오기] 리턴하는 메소드 선언
		@Override
		public List<Map<String, String>> getTabDictList_eng(DictSearchDTO dictSearchDTO) {
			
			List<Map<String,String>> tabDictList_eng = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getTabDictList_eng"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return tabDictList_eng;
		}
		//[Tab 검색 영어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
		@Override
		public int getTabDictListAllCnt_eng(DictSearchDTO dictSearchDTO) {
			
			int tabDictListAllCnt_eng = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getTabDictListAllCnt_eng"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return tabDictListAllCnt_eng; 
		}
		// [Tab 검색 일본어 게시판 목록 가져오기] 리턴하는 메소드 선언
		@Override
		public List<Map<String, String>> getTabDictList_jpn(DictSearchDTO dictSearchDTO) {
			
			List<Map<String,String>> tabDictList_jpn = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getTabDictList_jpn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return tabDictList_jpn;
		}
		//[Tab 검색 일본어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
		@Override
		public int getTabDictListAllCnt_jpn(DictSearchDTO dictSearchDTO) {
			
			int tabDictListAllCnt_jpn = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getTabDictListAllCnt_jpn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return tabDictListAllCnt_jpn ; 
		}
		//[Tab 검색 n행m열 중국어 게시판 목록 가져오기] 리턴하는 메소드 선언
		@Override
		public List<Map<String, String>> getTabDictList_cn(DictSearchDTO dictSearchDTO) {
			
			List<Map<String,String>> tabDictList_cn = this.sqlSession.selectList(
					
					"com.naver.erp.DictDAO.getTabDictList_cn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
					
			);
			return tabDictList_cn;
		}
		//[Tab 검색 중국어 게시판 목록 개수 가져오기] 리턴하는 메소드 선언
		@Override
		public int getTabDictListAllCnt_cn(DictSearchDTO dictSearchDTO) {
			
			int tabDictListAllCnt_cn = this.sqlSession.selectOne(
					
					"com.naver.erp.DictDAO.getTabDictListAllCnt_cn"  // 실행할 SQL 구문의 위치 지정
					,dictSearchDTO
			);
			
			return tabDictListAllCnt_cn; 
		}
*/
	
	
	
	
	
	
	
	


package com.naver.erp;

import java.util.List;

//==========================================================
// 게시판 검색 조건을 저장하는 [DictSearchDTO 클래스] 선언
//==========================================================
public class DictSearchDTO {
	//**********************
	// 속성변수 선언
	//***************
    private String keyword="";
	
	// 검색 키워드 저장하는 속성변수 선언 미리 default ""정해 놓으면 null이 애초에 안들어오잖아!!!!!!!
	private String[] search_keyword;
		
		
	// 언어별 구별 코드 속성변수 선언
	private String lang_code="0";
	
	// 현재 선택된 페이지번호를 저장하는 속성변수 선언
	private int selectPageNo=1;
	
	// 한 화면에 보여줄 행의 개수를 저장하는 속성변수 선언
	private int rowCntPerPage=10;
	
	
	//상세검색 관련 속성변수들..
	private String detail_search;
	private String detail_keyword;
	private String search_date;
	private String range;
	private String orderby;
	private String asc_desc;
	private String top="top_rate_cnt";
	private String begin_year;
	private String begin_month;
	private String end_year;
	private String end_month;
	
	// mynote 색적시 사용되는 user_id를 session에서 받아와서 저장하는 속성변수 user_id 선언
	private String user_id="";
	
	private String myNote_search;
	private String myNote_orderby;
	
	private String user_name;

	
	
	
	
	
	
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String[] getSearch_keyword() {
		return search_keyword;
	}

	public void setSearch_keyword(String[] search_keyword) {
		this.search_keyword = search_keyword;
	}

	public String getLang_code() {
		return lang_code;
	}

	public void setLang_code(String lang_code) {
		this.lang_code = lang_code;
	}

	public int getSelectPageNo() {
		return selectPageNo;
	}

	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public String getDetail_search() {
		return detail_search;
	}

	public void setDetail_search(String detail_search) {
		this.detail_search = detail_search;
	}

	public String getDetail_keyword() {
		return detail_keyword;
	}

	public void setDetail_keyword(String detail_keyword) {
		this.detail_keyword = detail_keyword;
	}

	public String getSearch_date() {
		return search_date;
	}

	public void setSearch_date(String search_date) {
		this.search_date = search_date;
	}

	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}

	public String getAsc_desc() {
		return asc_desc;
	}

	public void setAsc_desc(String asc_desc) {
		this.asc_desc = asc_desc;
	}

	public String getTop() {
		return top;
	}

	public void setTop(String top) {
		this.top = top;
	}

	public String getBegin_year() {
		return begin_year;
	}

	public void setBegin_year(String begin_year) {
		this.begin_year = begin_year;
	}

	public String getBegin_month() {
		return begin_month;
	}

	public void setBegin_month(String begin_month) {
		this.begin_month = begin_month;
	}

	public String getEnd_year() {
		return end_year;
	}

	public void setEnd_year(String end_year) {
		this.end_year = end_year;
	}

	public String getEnd_month() {
		return end_month;
	}

	public void setEnd_month(String end_month) {
		this.end_month = end_month;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getMyNote_search() {
		return myNote_search;
	}

	public void setMyNote_search(String myNote_search) {
		this.myNote_search = myNote_search;
	}

	public String getMyNote_orderby() {
		return myNote_orderby;
	}

	public void setMyNote_orderby(String myNote_orderby) {
		this.myNote_orderby = myNote_orderby;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}	
	
	
	
	
	


}

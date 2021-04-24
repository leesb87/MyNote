package com.naver.erp;
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
// 게시판 검색 조건을 저장하는 [ BoardSearchDTO 클래스] 선언
//mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
public class AdminSearchDTO {
	private String main_keyword;
	private String content_keyword;
		
	private String[] gender;
	private String addr;
	private String[] age_group;	
	private String date;	
	private String range;	
	private String orderby;
	
	private String begin_regDate_year;
	private String begin_regDate_month;
	private String end_regDate_year;
	private String end_regDate_month;
	
	private String begin_birth_year;
	private String begin_birth_month;
	private String end_birth_year;
	private String end_birth_month;
	
	private String[] access;

	
	private int selectPageNo=1;
	private int rowCntPerPage=10;
	
	
	public String getMain_keyword() {
		return main_keyword;
	}
	public void setMain_keyword(String main_keyword) {
		this.main_keyword = main_keyword;
	}
	public String getContent_keyword() {
		return content_keyword;
	}
	public void setContent_keyword(String content_keyword) {
		this.content_keyword = content_keyword;
	}
	public String[] getGender() {
		return gender;
	}
	public void setGender(String[] gender) {
		this.gender = gender;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String[] getAge_group() {
		return age_group;
	}
	public void setAge_group(String[] age_group) {
		this.age_group = age_group;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public String getBegin_regDate_year() {
		return begin_regDate_year;
	}
	public void setBegin_regDate_year(String begin_regDate_year) {
		this.begin_regDate_year = begin_regDate_year;
	}
	public String getBegin_regDate_month() {
		return begin_regDate_month;
	}
	public void setBegin_regDate_month(String begin_regDate_month) {
		this.begin_regDate_month = begin_regDate_month;
	}
	public String getEnd_regDate_year() {
		return end_regDate_year;
	}
	public void setEnd_regDate_year(String end_regDate_year) {
		this.end_regDate_year = end_regDate_year;
	}
	public String getEnd_regDate_month() {
		return end_regDate_month;
	}
	public void setEnd_regDate_month(String end_regDate_month) {
		this.end_regDate_month = end_regDate_month;
	}
	public String getBegin_birth_year() {
		return begin_birth_year;
	}
	public void setBegin_birth_year(String begin_birth_year) {
		this.begin_birth_year = begin_birth_year;
	}
	public String getBegin_birth_month() {
		return begin_birth_month;
	}
	public void setBegin_birth_month(String begin_birth_month) {
		this.begin_birth_month = begin_birth_month;
	}
	public String getEnd_birth_year() {
		return end_birth_year;
	}
	public void setEnd_birth_year(String end_birth_year) {
		this.end_birth_year = end_birth_year;
	}
	public String getEnd_birth_month() {
		return end_birth_month;
	}
	public void setEnd_birth_month(String end_birth_month) {
		this.end_birth_month = end_birth_month;
	}
	public String[] getAccess() {
		return access;
	}
	public void setAccess(String[] access) {
		this.access = access;
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
	
	
	
	
	
	
	
	



	
//--------------------------------------------------	

	
	
	

}

package com.naver.erp;

public class StaffSearchDTO {

	//=================================================

	String staff_name;
	String religion;
	
	String min_grad_day;
	String max_grad_day;
	
	private int selectPageNo=1;
	private int rowCntPerPage=5;
	
	//================================================

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
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getMin_grad_day() {
		return min_grad_day;
	}
	public void setMin_grad_day(String min_grad_day) {
		this.min_grad_day = min_grad_day;
	}
	public String getMax_grad_day() {
		return max_grad_day;
	}
	public void setMax_grad_day(String max_grad_day) {
		this.max_grad_day = max_grad_day;
	}
	
	
	//=================================================
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

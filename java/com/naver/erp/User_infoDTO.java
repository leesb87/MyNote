package com.naver.erp;

public class User_infoDTO {
	private int user_no;
	private String user_id;
	private String pwd; 
	private String user_name;
	private String addr;            
	private String jumin_num;
	private String email;            
	private String tel_num;
	private String reg_date;
	
	private String acc_read;
	private String acc_upDel; 
	private String acc_write;
	//private String[] accArray;
	
	
	
	
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getJumin_num() {
		return jumin_num;
	}
	public void setJumin_num(String jumin_num) {
		this.jumin_num = jumin_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel_num() {
		return tel_num;
	}
	public void setTel_num(String tel_num) {
		this.tel_num = tel_num;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getAcc_read() {
		return acc_read;
	}
	public void setAcc_read(String acc_read) {
		this.acc_read = acc_read;
	}
	public String getAcc_upDel() {
		return acc_upDel;
	}
	public void setAcc_upDel(String acc_upDel) {
		this.acc_upDel = acc_upDel;
	}
	public String getAcc_write() {
		return acc_write;
	}
	public void setAcc_write(String acc_write) {
		this.acc_write = acc_write;
	}
	








}
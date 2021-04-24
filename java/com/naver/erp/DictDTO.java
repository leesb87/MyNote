package com.naver.erp;

public class DictDTO {

	//String saveAt
	//String input_date
	//String edit_date
	int dict_no;
	int rownum;
	int note_no;
	String lang_code;
	String word;
	String content;
	String register;
	int readcount;
	String refer;
	int rate=0;
	int rate_cnt=0;
	
	
	String saveMynote;


	public int getDict_no() {
		return dict_no;
	}

	public void setDict_no(int dict_no) {
		this.dict_no = dict_no;
	}

	public int getRownum() {
		return rownum;
	}

	public void setRownum(int rownum) {
		this.rownum = rownum;
	}

	public int getNote_no() {
		return note_no;
	}


	public void setNote_no(int note_no) {
		this.note_no = note_no;
	}


	public String getLang_code() {
		return lang_code;
	}


	public void setLang_code(String lang_code) {
		this.lang_code = lang_code;
	}


	public String getWord() {
		return word;
	}


	public void setWord(String word) {
		this.word = word;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getRegister() {
		return register;
	}


	public void setRegister(String register) {
		this.register = register;
	}


	public int getReadcount() {
		return readcount;
	}


	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}


	public String getRefer() {
		return refer;
	}


	public void setRefer(String refer) {
		this.refer = refer;
	}


	public int getRate() {
		return rate;
	}


	public void setRate(int rate) {
		this.rate = rate;
	}


	public int getRate_cnt() {
		return rate_cnt;
	}


	public void setRate_cnt(int rate_cnt) {
		this.rate_cnt = rate_cnt;
	}


	public String getSaveMynote() {
		return saveMynote;
	}


	public void setSaveMynote(String saveMynote) {
		this.saveMynote = saveMynote;
	}
	
	

 
	
	
}

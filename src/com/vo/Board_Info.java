package com.vo;

public class Board_Info {
	/*
	 * this is for saving board_info of database.
	 */
	private String index;	
	private String title;
	private String name;
	private String time;
	private String hit;
	private String memo;
	private String pass;
	
	public Board_Info() {
		// TODO Auto-generated constructor stub
	}
	/*
	 * constructor and getter, setter.
	 */
	
	public void setpass(String pass){
		this.pass = pass;
	}
	public String getpass(){
		return pass;
	}
	public String getIndex() {
		return index;
	}

	public void setIndex(String ind) {
		this.index = ind;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String tit) {
		this.title = tit;
	}

	public String getName() {
		return name;
	}

	public void setName(String nam) {
		this.name = nam;
	}
	public String getTime() {
		return time;
	}

	public void setTime(String dat) {
		this.time = dat;
	}
	public String getHit() {
		return hit;
	}

	public void setHit(String hit) {
		this.hit = hit;
	}
	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
}

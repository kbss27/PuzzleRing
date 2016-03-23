package com.vo;

public class Member {
	private String m_id;
	private String m_password;
	private String m_name;
	private int m_age;
	private int m_phone;
	private String m_email;
	private String m_session;
	private String m_food;
	private String m_sleep;
	private String m_area;
	private String m_img;
	private String m_info;

	public Member() {
	}
	
	public Member(String m_id, String m_password, String e_mail, String m_info){
		this.m_id = m_id;
		this.m_password = m_password;
		this.m_email = e_mail;
		this.m_info = m_info;
	}
	
	public Member(String m_id, String m_password, String m_name, int m_age,
			int m_phone, String m_email, String m_img) {

		this.m_id = m_id;
		this.m_password = m_password;
		this.m_name = m_name;
		this.m_age = m_age;
		this.m_phone = m_phone;
		this.m_email = m_email;
		this.m_img = m_img;
	}

	public Member(String m_name, int m_age) {
		this.m_name = m_name;
		this.m_age = m_age;
	}

	public String get_info(){
		return m_info;
	}
	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public String getM_password() {
		return m_password;
	}

	public void setM_password(String m_password) {
		this.m_password = m_password;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getM_session() {
		return m_session;
	}

	public void setM_session(String m_session) {
		this.m_session = m_session;
	}

	public String getM_food() {
		return m_food;
	}

	public void setM_food(String m_food) {
		this.m_food = m_food;
	}

	public String getM_sleep() {
		return m_sleep;
	}

	public void setM_sleep(String m_sleep) {
		this.m_sleep = m_sleep;
	}

	public String getM_area() {
		return m_area;
	}

	public void setM_area(String m_area) {
		this.m_area = m_area;
	}

	public String getM_img() {
		return m_img;
	}

	public void setM_img(String m_img) {
		this.m_img = m_img;
	}

	public int getM_age() {
		return m_age;
	}

	public void setM_age(int m_age) {
		this.m_age = m_age;
	}

	public int getM_phone() {
		return m_phone;
	}

	public void setM_phone(int m_phone) {
		this.m_phone = m_phone;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
}

package com.vo;

import java.util.ArrayList;

public class Project_detail {

	private String project_name;
	
	//3개 추가된 것.
	private String class_name;
	private ArrayList<String> method_list;
	private ArrayList<String> variable_list;
	
	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public ArrayList<String> getMethod_list() {
		return method_list;
	}

	public void setMethod_list(ArrayList<String> method_list) {
		this.method_list = method_list;
	}

	public ArrayList<String> getVariable_list() {
		return variable_list;
	}

	public void setVariable_list(ArrayList<String> variable_list) {
		this.variable_list = variable_list;
	}

	private String project_detail;
	private String id;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Project_detail(String project_name, String project_detail, String id){
		this.id = id;
		this.project_name = project_name;
		this.project_detail = project_detail;
	}
	
	public String getProject_name(){
		return this.project_name;
	}
	
	public String getProject_detail(){
		return this.project_detail;
	}
}

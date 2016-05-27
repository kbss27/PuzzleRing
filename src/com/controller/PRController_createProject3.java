package com.controller;


import java.util.ArrayList;
import java.util.Locale.Category;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRCreateProject;
import com.dao.PRCreateProject2;

public class PRController_createProject3 {
	PRCreateProject2 model2;
	public PRController_createProject3() {
		model2 = new PRCreateProject2();
	}
	
	public void createProcess2(HttpServletRequest req, HttpServletResponse res) {
		RequestDispatcher dis = req.getRequestDispatcher("/form/create_projectForm.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void createProject3(HttpServletRequest req, HttpServletResponse res){
		
		String class_detail = req.getParameter("class_detail");
		String method_detail = req.getParameter("method_detail");
		String project_name = req.getParameter("project_name");
		String project_uml = req.getParameter("uml");
		if((model2.createProject2(class_detail, method_detail,project_uml,project_name))){
			
			RequestDispatcher dis = req.getRequestDispatcher("/form/main.jsp");
			try {
				System.out.println("성공이야성공");
				dis.forward(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("fail to store data.");
		}
		
	}
	
}
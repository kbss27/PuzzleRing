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
		
		System.out.println("test3");
		
		String class_detail = req.getParameter("class_detail");
		String method_detail = req.getParameter("method_detail");
		
		if((model2.createProject2(class_detail, method_detail))){
			
			RequestDispatcher dis = req.getRequestDispatcher("/form/main.jsp");
			try {
				dis.forward(req, res);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			System.out.println("fail to store data.");
		}
		
	}
	
}


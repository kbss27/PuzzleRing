package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRCreateProject;
import com.vo.Member;
//2016.3.23.
public class PRController_createProject {
	PRCreateProject model;
	Member m;
	public PRController_createProject() {
		model = new PRCreateProject();
	}
	
	public void createProcess(HttpServletRequest req, HttpServletResponse res) {
		String ID = req.getParameter("user_id");
		m = new Member(ID,"","","");
		req.setAttribute("member", m);
		RequestDispatcher dis = req.getRequestDispatcher("/form/create_projectForm.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void createProject(HttpServletRequest req, HttpServletResponse res){
		
		String project_creator = req.getParameter("project_creator");
		String project_name = req.getParameter("project_name");
		String project_type = req.getParameter("project_type");
		String project_content = req.getParameter("project_content");
		
		if(model.createProject(project_creator, project_name, project_type, project_content)){
			
			RequestDispatcher dis = req.getRequestDispatcher("/form/mainAftercreate.jsp");
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

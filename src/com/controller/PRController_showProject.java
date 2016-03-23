package com.controller;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRShowProject;
import com.vo.Project_detail;

public class PRController_showProject {
	
	PRShowProject model;

	public PRController_showProject() {
		model = new PRShowProject();
	}
	
	public void showproject(HttpServletRequest req, HttpServletResponse res){
		ArrayList<Project_detail> p_detail;
		String creator = req.getParameter("id");
		
		p_detail = model.getProjectDetail(creator);
		req.setAttribute("project_detail", p_detail);
		
		RequestDispatcher dis = req.getRequestDispatcher("/form/show_Projects.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
}

package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRCreateClassMethod;
import com.vo.Project_overview;

public class PRController_createClassMethod {

	PRCreateClassMethod model;

	public PRController_createClassMethod() {
		model = new PRCreateClassMethod();
	}

	public void createClassMethod(HttpServletRequest req, HttpServletResponse res) {

	      String project_name = req.getParameter("project_name");
	      
	      Project_overview overview = model.createClassMethod(project_name);

	      req.setAttribute("project_overview", overview);
	   
	      RequestDispatcher dis = req.getRequestDispatcher("/form/create_ClassMethodForm.jsp");
	      try {
	         dis.forward(req, res);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }

	   }
}
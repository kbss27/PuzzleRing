<<<<<<< HEAD
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
=======
package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.PRCreateClassMethod;
import com.dao.PRCreateProject;
import com.dao.PRCreateProject2;
import com.vo.Project_overview;

public class PRController_createClassMethod {

	PRCreateClassMethod model;

	public PRController_createClassMethod() {
		model = new PRCreateClassMethod();
	}

	/*
	public void createProcess3(HttpServletRequest req, HttpServletResponse res) {
		RequestDispatcher dis = req.getRequestDispatcher("/form/create_projectForm.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	*/
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
>>>>>>> 351cf939fd9a38581ae639cb731ed0a7b278792c
}
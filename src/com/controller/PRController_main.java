package com.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PRController_main {

	public void mainAll(HttpServletRequest req, HttpServletResponse res) {
		RequestDispatcher dis = req.getRequestDispatcher("/form/home.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void logout(HttpServletRequest req, HttpServletResponse res){
		//this is logout form. this logout form will open login_form.jsp
		req.getSession().removeAttribute("login");
		RequestDispatcher dis = req
				.getRequestDispatcher("/form/home.jsp");
		try {
			dis.forward(req, res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void projectList(HttpServletRequest req, HttpServletResponse res){
	      //this is logout form. this logout form will open login_form.jsp
	   
	      RequestDispatcher dis = req
	            .getRequestDispatcher("/form/project_list.jsp");
	      try {
	         dis.forward(req, res);
	      } catch (Exception e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }
	   }
}
